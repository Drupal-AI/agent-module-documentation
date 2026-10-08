<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Navigation — agent index

Makes the Webform wizard progress bar/tracker clickable both ways and re-surfaces per-page
validation errors. Enabled per webform (no global config page, `configure` null). Depends on
`webform` + `webform_submission_log`. No permissions, no Drush.

- **Enable it on a webform: third-party settings, the required handler, auto-forced settings** →
  [configure/settings.md](configure/settings.md)
- **The `webformnavigation.helper` service, the `webformnavigation_log` table, error/visit logging** →
  [api/helper.md](api/helper.md)

Key facts:
- Two switches (Webform third-party settings, key `webformnavigation`): `forward_navigation`,
  `prevent_next_validation`, plus `additional_error_message` (set in
  `hook_webform_third_party_settings_form_alter`). Schema:
  `webform.settings.third_party.webformnavigation`.
- Submission handler plugin id **`webform_navigation`** (`WebformNavigationHandler`,
  cardinality single) must be added on the webform for forward navigation to work.
- `hook_webform_presave` forces `draft=all`, sets `purge`/`purge_days=365`, `wizard_progress_link=TRUE`
  when `forward_navigation` is on.
- Overrides theme hooks `webform_progress_bar` / `webform_progress_tracker` to add `page_classes`
  (`is-active`/`has-errors`/`is-complete`, `webform-progress-bar__page--*`). CSS libraries:
  `webformnavigation.progress.bar`, `webformnavigation.progress.tracker`.
