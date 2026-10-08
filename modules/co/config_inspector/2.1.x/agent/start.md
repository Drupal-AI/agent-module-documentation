<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Inspector — agent index

Read-only developer tool that inspects every config object against core's config-schema /
typed-data system: schema compliance, validatability %, and constraint violations. No config
of its own, no plugin types, no config schema. Permission `inspect configuration`.

- **Admin report UI (tabs List/Tree/Form/Raw/Download), routes, permission** →
  [configure/overview.md](configure/overview.md)
- **`drush config:inspect` command + all its options and exit codes** →
  [drush/inspect.md](drush/inspect.md)
- **The `config_inspector.manager` service API (hasSchema/checkValues/validate/validatability)** →
  [api/manager.md](api/manager.md)

Key facts: report at `/admin/reports/config-inspector` (route `config_inspector.overview`).
Drush command `config:inspect` (alias `inspect_config`) exits non-zero on schema errors.
"Validatability" = share of property paths carrying real constraints (a bare `PrimitiveType`,
or `PrimitiveType`+`NotNull`, does **not** count unless the type is boolean/uri/datetime/duration).
