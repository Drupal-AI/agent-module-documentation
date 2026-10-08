<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, block placement & operation

## Install / enable

No external dependencies or libraries. Requires PHP >= 8.1 and Drupal `^10 || ^11 || ^12`.

- `drush en dga_feedback` (or Extend UI → Custom → DGA Feedback).
- `hook_install()` (`dga_feedback.install`) logs a notice and seeds every default key of
  `dga_feedback.settings` (bilingual strings + numeric limits) that is not already set.
- `hook_schema()` creates the `dga_feedback` table with indexes on
  `(entity_type, entity_id)`, `user_id`, `created`, and `is_useful`.
- Uninstall (`hook_uninstall()`) drops the `dga_feedback` table.
- `dga_feedback_update_10001()` backfills the `data_retention_days` setting (default `0`).

## Displaying the widget

The widget is a **block**, not a formatter or field. Place it via Structure → Block layout,
region of your choice; the plugin id is `dga_feedback_block` (admin label "DGA Feedback
Widget", category "Custom"). Use the block's standard visibility conditions (content types,
pages, roles) to scope where it appears.

`DgaFeedbackBlock::build()` (`src/Plugin/Block/DgaFeedbackBlock.php`):
- Computes a normalized `url` for the current page: prefers the path alias, strips any
  `/xx` language prefix, trims trailing slashes (`/` for the front page).
- Detects node context via `current_route_match` (`node` parameter) to key statistics by
  entity when available, else by URL (`DgaFeedbackService::getStatistics` /
  `getStatisticsByUrl`).
- Resolves the active language (entity → URL prefix → route → language manager, forced into
  `en`/`ar`) and builds a `texts` array of all widget/validation strings from config.
- Returns `#theme => 'dga_feedback_widget'` and attaches library
  `dga_feedback/feedback_widget` (`js/feedback.js`, `css/feedback.css`).

## Front-end JS flow (`js/feedback.js`)

The widget POSTs a JSON body to `/dga-feedback/submit` with header
`X-Requested-With: XMLHttpRequest` (required by the controller). On success it shows the
success message and updated statistics, then auto-resets after `refresh_delay` ms. Live
stats can be refreshed via `GET /dga-feedback/refresh-block`.

## Admin toolbar & menu

- `hook_page_attachments()` attaches `dga_feedback/toolbar_icon` for users with
  `access toolbar`, and always attaches `dga_feedback/admin_menu_fix`. For anonymous users
  it best-effort exposes a session CSRF token in `drupalSettings.csrfToken` (silent on
  failure).
- `hook_menu_links_discovered_alter()` / `hook_preprocess_menu()` add the SVG toolbar icon
  class to the `dga_feedback.admin` menu link.
- `hook_local_tasks_alter()` removes the redundant parent tab from the local-task set.
- Menu links (`dga_feedback.links.menu.yml`) and local tasks (`dga_feedback.links.task.yml`)
  build the DGA Feedback → Dashboard / Settings / Translations structure. Each uses a custom
  menu-link/local-task class under `src/Plugin/Menu/**` whose titles come from the
  `menu_title_*` config keys (bilingual).

## Cron / retention

`hook_cron()` reads `data_retention_days`; if `> 0` it calls
`DgaFeedbackService::purgeExpiredSubmissions($days)`, deleting rows older than
`now - days*86400` and logging the count. `0` (default) keeps data indefinitely.
