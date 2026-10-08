# devel_php — agent start

Adds an **Execute PHP** feature to Devel: run arbitrary PHP from the admin UI.
Successor to Devel's old PHP-execute page. Depends on `devel` (for `devel.dumper`).
No settings form (`configure: null`). Development-only — arbitrary `eval()` = full compromise.

- Page/block usage, form behavior, the block plugin → [configure/execute-php.md](configure/execute-php.md)
- The single `execute php code` permission and what it gates → [permissions/permissions.md](permissions/permissions.md)
