<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Known Overrides (known_overrides) — agent index

Surfaces which configuration values `settings.php` (and its includes) are overriding, so those overrides stop being invisible. Overrides work silently by design: the config UI shows the *stored* value while the site runs on the *overridden* one, so an administrator changes a setting, sees it saved, and nothing happens. The developer declares which config names are overridden in a `$settings['knownOverrides']` array; the module then (1) warns and highlights the overridden fields — disabled, with the live overridden value shown — on the relevant config forms via `hook_form_alter`/`#after_build`, (2) adds an admin-page warning for path-scoped overrides via `hook_page_top`, and (3) renders a consolidated diff at `/admin/reports/known-overrides` comparing each config's editable (stored) values against its live (overridden) values.

The report route reads live state (`no_cache: TRUE`) and is gated by the restricted permission `known overrides report` — warranted, since the diff maps how this environment differs from the codebase (endpoint hostnames, service names, feature flags, deployment shape).

- Depends on: nothing beyond core. Core: `^10 || ^11`. Package: `Reports`.
- No settings form / `configure` route — configuration is the `$settings['knownOverrides']` array in `settings.php`, not a UI. No config schema, no services file, no drush commands, no plugin types.
- Provides one permission (`known overrides report`, `restrict access: true`) and one Administration ▸ Reports menu link.

## What you'd do → where

- **Declare which overrides to track, grant access, and read the report** →
  [configure/settings.md](configure/settings.md)
- **Understand the on-form highlighting, the admin warnings, and the report diff internals** →
  [hooks/highlighting.md](hooks/highlighting.md)

## Key facts (real machine names)

- Route: `known_overrides.report` → `/admin/reports/known-overrides`, `_permission: 'known overrides report'`,
  `_admin_route: TRUE`, `no_cache: TRUE`. Controller
  `Drupal\known_overrides\Controller\KnownOverridesController` (invokable `__invoke`).
- Permission: `known overrides report` (`restrict access: true`).
- Menu link: `known_overrides.report` under `system.admin_reports`.
- Settings key: `$settings['knownOverrides']` (read via `Settings::get('knownOverrides', [])`); nothing is
  stored in Drupal config.
- Hooks implemented: `hook_theme`, `hook_form_alter` (registers `#after_build` callback
  `known_overrides_form_after_build`), `hook_page_top`.
- Theme hook: `known_overrides_report` (template `known-overrides-report.html.twig`, preprocess
  `template_preprocess_known_overrides_report`; variables `report`, `overrides`).
