<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Debug Bar (debug_bar) — agent index

A floating front-end toolbar that shows per-request debug/performance info (execution time, memory,
DB query count, cache status, Drupal/PHP version, last cron, Git branch) plus quick links and admin
cron/cache actions. Package `Development`. Core `^10 || ^11`, PHP `>=8.3`. License GPL-2.0-or-later.
Version 3.0.0-rc2. No Drupal module dependencies (soft-integrates with `dblog` if present).

- **Install, permissions, the settings form, and how the bar is built/injected** →
  [config/settings.md](config/settings.md)
- **Adding your own items with `hook_debug_bar_items_alter()`** → [api/items-alter.md](api/items-alter.md)

## What it actually is

- No entities, no plugin types, no Drush. It ships three services (`debug_bar.services.yml`):
  - `debug_bar.middleware` — `DebugBarMiddleware` (http_middleware, priority 1001). Calls
    `Database::startLog('debug_bar')`, then after the response is built interpolates the placeholder
    tokens `[execution_time]`, `[db_queries]`, `[memory_usage]`, `[anonymous_cache]`,
    `[dynamic_cache]` and `str_replace`s the bar markup in before `</body>`.
  - `debug_bar.event_subscriber` — `DebugBarEventSubscriber`. On RESPONSE (for non-redirect,
    non-AJAX main HTML responses, permission `view debug bar`) attaches the built bar. On REQUEST
    (priority 250) handles the admin cron/cache-clear actions.
  - `debug_bar.builder` — `DebugBarBuilder`. Assembles the `DebugBarItem[]` list and renders the
    `debug_bar` theme via `renderInIsolation()`.
- One config object `debug_bar.settings` (single key `position`, default `bottom_right`; schema in
  `config/schema/debug_bar.settings.yml`).
- Two permissions (`debug_bar.permissions.yml`), both `restrict access: true`:
  `view debug bar` (who sees the bar) and `administer debug bar` (settings form access).
- One route `debug_bar.settings` → `/admin/config/development/debug-bar` (`SettingsForm`), menu link
  under *Configuration → Development*.
- Theme hook `debug_bar` (`templates/debug-bar.html.twig`) + preprocess in `debug_bar.module`;
  library `debug_bar` (`js/debug-bar.js`, `css/debug-bar.css`, deps `core/drupal`, `core/once`),
  attached in `debug_bar_page_attachments()` only when the user has `view debug bar`.
- Data value object `Drupal\debug_bar\Data\DebugBarItem` (id, content, iconPath, access, weight, url,
  attributes, title). Extension hook `hook_debug_bar_items_alter()` (`debug_bar.api.php`).

## Items and their gating (from `DebugBarBuilder::buildItems()`)

- Always (with `view debug bar`): home link, execution time, peak memory MB, DB query count, cache
  status, login/user/logout link.
- `access site reports`: Drupal version (→ system.status), watchdog log link (if `dblog` enabled).
- `administer site configuration` (the item's `is_admin`): PHP version (→ system.php), **Run cron**,
  **Clear caches**. Git branch item shows only when `.git/HEAD` is readable.
- Each item is filtered by its `access` bool; the cron/cache links carry a CSRF token
  (`csrf_token->get(CRON_KEY|CACHE_KEY)`), validated on the REQUEST event before acting.
