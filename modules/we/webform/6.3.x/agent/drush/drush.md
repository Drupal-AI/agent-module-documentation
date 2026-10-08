# Webform Drush commands

Defined in `drush.services.yml` / `src/Commands/`. Run inside the container (`drush …`) or
`ddev drush …` from the host.

## Data
- `drush webform:generate <webform_id> [num]` — create test submissions (`--entity-type`,
  `--entity-id`, `--kill` to clear first).
- `drush webform:export <webform_id>` — export results to a file (`--exporter=delimited|json|…`,
  `--destination`, `--range-type`, `--delimiter`, etc.). Mirrors the results-download UI.
- `drush webform:purge <webform_id|all>` — delete submissions for a form (or all).
- `drush webform:import <webform_id> <import_uri>` — import submissions from CSV
  (via webform_submission_export_import).

## Maintenance
- `drush webform:repair` — fix/upgrade webform config after core/module updates.
- `drush webform:remove:orphans` — delete submissions whose webform no longer exists.
- `drush webform:tidy [projects]` — reformat YAML config files (dev/maintainer tool).

## Optional libraries
- `drush webform:libraries:status` — list optional external JS/CSS libraries and whether present.
- `drush webform:libraries:download` — download them into `/libraries`.
- `drush webform:libraries:remove` — remove downloaded libraries.
- `drush webform:libraries:composer` / `drush webform:composer:update` — manage libraries via
  Composer (writes require entries).

## Docs (maintainer)
- `drush webform:docs` — generate the module's documentation/readme artifacts.
