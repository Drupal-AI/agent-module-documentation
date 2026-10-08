<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Builder (eb) is a declarative, YAML-driven engine that creates and modifies Drupal entity architecture (bundles, fields, displays, field groups, menus) with automatic dependency resolution, preview, validation, rollback, and audit logging.

---

Entity Builder lets you describe an entire content model in a flat, spreadsheet-friendly YAML file and apply it to a Drupal 11 site as a reusable configuration entity (`eb_definition`). Definitions are compiled into atomic operations — one plugin per action such as `create_bundle`, `create_field`, or `configure_view_mode` — whose ordering is resolved automatically by a dependency resolver, so a field can reference a bundle created in the same file. Imports are idempotent (smart sync): unchanged items are skipped, changed items updated, and new items created. Every applied definition is validated in two stages (operation-specific checks plus cross-cutting validator plugins), can be previewed before execution, records a full audit log (`eb_log`), and can be undone through stored rollback data (`eb_rollback`). Work happens through the admin UI at `/admin/config/development/eb`, through the shipped `eb_ui` YAML-editor sub-module, or through the `eb:*` Drush command suite for CI/CD. This documented release is `1.0.0-alpha1`, a pre-release without a stable API. Field groups, Pathauto patterns, Auto Entity Label, and the AG-Grid spreadsheet UI are provided by separate extension modules.

---

- Scaffold a new content type with all its fields, widgets, and formatters from a single YAML file instead of clicking through Field UI.
- Version-control your site's content model as YAML in Git and re-apply it across dev/stage/prod environments.
- Stand up an entire platform (multiple bundles, dozens of fields, field groups, menus) in one import — see the bundled `tests/fixtures/examples/job_board_platform.yml`.
- Preview exactly which entities will be created, updated, or deleted before touching the site, including a dependency graph.
- Validate a definition (field types exist, no duplicate names, no circular dependencies, required keys present, widget/formatter compatibility) before applying.
- Roll back a previously applied definition to restore the prior structure when a change goes wrong.
- Reverse-engineer an existing site's bundles/fields/displays into a definition with `drush eb:generate` for reuse or documentation.
- Export a definition (or full site architecture) to YAML with `drush eb:export`, optionally HMAC-signed for integrity.
- Automate content-model deployment in a CI/CD pipeline with `drush eb:validate`, `eb:preview`, `eb:import --execute`.
- Give non-developers a spreadsheet-style editing workflow (edit in Google Sheets/Excel, import as YAML) for content modelling.
- Delegate definition authoring to non-admin users with fine-grained Tier 1 permissions (create/edit/view/delete own definitions) while keeping apply/import restricted to trusted roles.
- Create and configure form and view display modes (widgets, formatters, weights, label display) declaratively per bundle.
- Add or reorder fields on an existing bundle, or hide a field from a specific display mode, as a repeatable operation.
- Build custom menus and menu links as part of a content-model deployment.
- Keep an audit trail of who changed the architecture and when, with per-operation detail on the log "Show" page.
- Detect drift and re-sync: run the same definition again to bring a site back to its intended structure idempotently.
- Extend the engine with custom operation, validator, or extension plugins to support new field types, integrations, or YAML keys.
- Restrict which entity types definitions may target via the `supported_entity_types` allowlist in settings.
- Purge old rollback and import-history records automatically using retention-day settings, or manually with `drush eb:rollback-purge`.
