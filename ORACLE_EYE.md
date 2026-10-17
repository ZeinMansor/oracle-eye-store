# Oracle Eye project

This repository holds the structure and PL/SQL source of the project's Oracle schemas, one object per
file under `src/database/<schema>/<type>/<name>.sql`. Table data is not stored.

- `main` is the state of the testing/staging environment. Oracle Eye updates it; do not push to it.
- Every feature created in Oracle Eye gets a branch `feature/<key>`.

## Working on a feature

```bash
git fetch && git switch feature/<key>
# edit the files, then compile each one in the DEV database, for example with SQLcl:
#   @src/database/sales/package_bodies/order_api.sql
git commit -am "Describe the change" && git push
```

Then run a check in Oracle Eye. It compares every object in your branch with DEV, adds one commit to the
branch with the result, and lists what still needs attention:

| Status | Meaning | What to do |
|---|---|---|
| In sync | Git and DEV agree | Nothing |
| Not compiled | Pushed but DEV still has the old version | Compile it in DEV |
| Mismatch | DEV holds code other than what you pushed | Compile your version, or adopt DEV's |
| Normalize | A table, index, or sequence differs in form | Review the diff and adopt DEV's form |
| DEV only | Changed in DEV but not committed | Adopt it into this feature, or ignore it |

Run `git pull` after each check to get Oracle Eye's commit. The final check must have nothing left to
resolve. Oracle Eye then tags the commit `oracle-eye/<key>/final`.

## Features whose source of truth is the branch

For these, Oracle Eye exports the feature's schemas from DEV into the branch when the feature starts, and
never commits to it again. Edit, compile in DEV, commit, and push; then capture the final check. Oracle
Eye deploys exactly the objects the branch changed since that export, after checking that DEV holds each
one as pushed. Objects changed only in DEV are left out.

## Rules

- Change a table by editing its `CREATE TABLE` file in place **and** running the matching `ALTER TABLE` in
  DEV. Never commit `ALTER` scripts: deployment scripts are generated from the captured DEV state.
- Keep the file layout and object names as exported; name every constraint and index explicitly.
- Schema-qualify every object (`create or replace package sales.order_api ...`).
