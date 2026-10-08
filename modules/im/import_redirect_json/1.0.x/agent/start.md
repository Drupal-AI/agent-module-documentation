<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import redirect JSON — agent index

**Imports URL redirects from a JSON file** into the Redirect module (bulk source→destination). Depends on
`redirect`, core `dblog`. Config at `import_redirect_json.mapping`; provides permissions. Version
**1.0.3**. Core `^9||^10||^11`.

**Security:** restrict the import permission (creates redirects controlling where URLs send visitors);
validate the JSON source (avoid malicious/erroneous destinations). Acts with importer's privileges.
