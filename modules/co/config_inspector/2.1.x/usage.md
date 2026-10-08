<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Configuration Inspector is a developer tool that inspects every configuration object on a Drupal site against the core configuration schema/typed-data system, reporting schema errors, validatability, and constraint violations in the admin UI and via a `config:inspect` Drush command.

---

The module adds a report at Administration » Reports » Configuration inspector (`/admin/reports/config-inspector`, route `config_inspector.overview`, permission `inspect configuration`) that lists every active config object and, per object, whether it has a schema, whether the data complies with that schema, what percentage of its property paths are "validatable" (carry real validation constraints beyond a bare primitive type), and how many validation-constraint violations the data has. Each object can be viewed four ways via local tabs — List, Tree, Form, and Raw data — and downloaded. All the analysis lives in the `config_inspector.manager` service (`ConfigInspectorManager`), which wraps core's `TypedConfigManager`, `SchemaCheckTrait`, and the validation constraint system; it exposes `hasSchema()`, `checkValues()` (schema compliance), `checkValidatabilityValues()` (returns a `ConfigSchemaValidatability`), and `validateValues()` (returns a Symfony `ConstraintViolationList`). The `config:inspect` Drush command (class `InspectorCommands`, alias `inspect_config`) surfaces the same data on the CLI with options such as `--only-error`, `--detail`, `--filter-keys`, `--skip-keys`, `--strict-validation`, `--list-constraints`, `--generate-baseline`, `--baseline`, and `--todo`, and returns a non-zero exit code when schema errors are found (useful in CI). The module has no configuration of its own, no config schema, and no plugin types — it is purely a read-only inspection layer over core's config system.

---

- Audit an entire site's configuration for schema errors before a Drupal core or contrib upgrade.
- Find config objects that have "No schema" so you can add schema for a custom module.
- Verify a custom module's `config/schema/*.yml` correctly types its settings by inspecting the object in the Tree view.
- Run `drush config:inspect --only-error` in CI to fail a build when any config violates its schema.
- Measure how "validatable" your config is (percentage of property paths with real constraints) to drive schema-hardening work.
- Use `--todo` to list the config objects closest to 100% validatability as low-hanging fruit for adding constraints.
- Inspect a single config object's schema by running `drush config:inspect system.site --detail`.
- List the exact validation constraints applied to each property path with `--detail --list-constraints`.
- Filter an inspection to a set of keys (`--filter-keys=system.action.*`) using glob patterns.
- Skip noisy keys during an audit with `--skip-keys=...`.
- Generate a baseline file of currently-failing keys (`--generate-baseline --only-error`) and ignore them in later runs with `--baseline`.
- Treat incomplete validatability as an error in strict pipelines with `--only-error --strict-validation`.
- Compare a config object's raw stored data against its schema-typed interpretation in the Raw data vs Tree tabs.
- Debug why a config import/validation fails by seeing which property path violates which constraint.
- Review whether config types are marked `FullyValidatable` for Drupal's config validation initiative.
- Give developers a table-of-summary overview of all configuration values and their schema coverage.
- Inspect configuration entities (views, field storages, image styles) alongside simple config in one place.
- Download a config object for offline review from the Download tab.
- Check that enum/allowed-values constraints are actually declared on a setting rather than being a free string.
- Identify config that only has `PrimitiveType`/`NotNull` constraints (counted as not truly validatable) so you can tighten it.
- Provide a developer-focused sanity check that a site's config is internally consistent after manual database edits.
- Teach the typed-config and constraint systems by exploring real objects through the schema.
- Assess third-party module config quality by inspecting its schema validatability percentage.
- Locate the highest-impact unvalidatable config *types* across the whole site with `--todo` (high-hanging fruit).
