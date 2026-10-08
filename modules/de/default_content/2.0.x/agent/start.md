# default_content — agent start

Exports content entities to YAML and imports them automatically when the providing module is
enabled. Files live in the module at `content/{entity_type}/{uuid}.yml`; import fires on
`hook_modules_installed` (and on config import), resolves entity-reference dependencies with a
graph sort, and saves in order. No UI, no settings, no permissions. Beta (`2.0.0-beta1`).

- Export/import via Drush (`dce`/`dcer`/`dcem`/`dcemr`, options, info-file UUID list, `content/` layout) → [drush/default_content.md](drush/default_content.md)
- Call the exporter/importer/normalizer services in code + YAML `_meta` format → [api/default_content.md](api/default_content.md)
- React to import/export via events → [extend/default_content.md](extend/default_content.md)
