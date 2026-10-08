# Purge File — agent index

Purges file URLs/paths from an external cache (Varnish/CDN/Acquia) via the Purge
module whenever a file entity is inserted, updated, or deleted. Depends on `purge`.
No new plugin types, no permissions of its own, no Drush commands.

Prerequisites: `purge` enabled, at least one purger supporting `url`, `wildcardurl`,
`path`, or `wildcardpath`, and at least one purge processor.

- **Configure** — settings form, config keys, workflow (immediate vs queue), invalidation types, base URLs → [configure/purge_file.md](configure/purge_file.md)
- **Hooks** — alter the base URLs purged per file → [hooks/purge_file.md](hooks/purge_file.md)
