SDC Devel is a development aid for Single-Directory Component (SDC) authors: it validates component definitions and their Twig templates and reports problems in the admin UI or via Drush.

---

The module scans every registered SDC (via core's `plugin.manager.sdc`) and validates two things: the component's `*.component.yml` definition (`DefinitionValidator`, wrapping core's `ComponentValidator`) and its Twig template (`TwigValidator`). Twig checks are driven by a pluggable `twig_validator_rule` plugin type (attribute `#[TwigValidatorRule]`, manager `plugin.manager.twig_validator_rule`) with a rule per Twig node/expression kind — constants, filters, functions, includes, get-attr, ternary/elvis/null-coalesce, ranges, names, etc. — each classifying names as allowed/deprecated/warned/forbidden/ignored and emitting severity-tagged `ValidatorMessage`s with source line and snippet. Results appear at `/admin/reports/ui-components` (permission `access components page` + `access site reports`) with overview, details and per-component pages, and via the `drush sdc-devel:validate <project> [id]` command (alias `sdcv`), which can optionally `--install` the project first. It is a developer/CI tool with no runtime effect on the rendered site; it has no config, no permissions of its own beyond the report route, and adds a status-report theme hook.

---

- Lint every SDC in a project for definition and Twig issues before release.
- Catch use of forbidden or deprecated Twig functions/filters inside components.
- Validate that a component's `*.component.yml` matches core's SDC schema.
- Review all component problems on one admin report page.
- Drill into a single component's messages with source lines and snippets.
- Run component validation in CI via `drush sdc-devel:validate` (alias `sdcv`).
- Validate a specific component id rather than a whole project.
- Temporarily install a module/theme for validation with `--install`, then uninstall it.
- Flag templates that reference undefined props or slots.
- Enforce a house style on which Twig constructs components may use.
- Detect risky constructs like `constant()` usage in component Twig.
- Surface `include`/`getattr` patterns that break component encapsulation.
- Add your own `twig_validator_rule` plugin to enforce project-specific rules.
- Gate merges on a clean component report.
- Help theme developers learn correct SDC authoring via concrete messages.
- Audit a contrib theme's components after an upgrade.
- Group validation messages by severity to triage criticals first.
- Check components across multiple projects in one command (comma-separated).
- Get a status-report summary of component errors by severity.
- Standardise component quality across a design system.
