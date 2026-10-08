<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, permissions, settings & how the bar works

## Install & enable

```bash
composer require drupal/debug_bar
drush en debug_bar -y
```

Requires PHP `>=8.3` and core `^10.3 || ^11.0`. Composer also pulls `symfony/event-dispatcher`,
`symfony/http-foundation` and `symfony/http-kernel` (`^6.4 || ^7.1`) — all already present in a
normal Drupal install. No Drupal module dependencies; if `dblog` happens to be enabled the bar adds
a log-overview link.

## Permissions (`debug_bar.permissions.yml`)

Both are marked `restrict access: true`:

- **`view debug bar`** — controls whether the toolbar is attached and shown at all. Grant only to
  developer/trusted roles; without it the library is never attached and no bar markup is injected.
- **`administer debug bar`** — access to the settings form only.

Some items add a second gate on top of `view debug bar`: the Drupal-version and log items also need
`access site reports`, and the PHP-version link plus the cron/cache actions also need
`administer site configuration`.

## Settings form (`SettingsForm`, route `debug_bar.settings`)

Path `/admin/config/development/debug-bar` (menu: *Configuration → Development → Debug bar*),
permission `administer debug bar`. It is a `ConfigFormBase` editing config object
**`debug_bar.settings`**, which has a single key:

| Key | Type | Default | Values |
|---|---|---|---|
| `position` | string | `bottom_right` | `top_left`, `top_right`, `bottom_left`, `bottom_right` |

Schema: `config/schema/debug_bar.settings.yml` (`config_object`, `position: string`). Install
default: `config/install/debug_bar.settings.yml` (`position: bottom_right`). The value is turned
into the CSS class `debug-bar_<position>` via `Html::cleanCssIdentifier()` in `DebugBarBuilder::build()`.

Config example:

```yaml
# debug_bar.settings
position: top_right
```

## How the bar is built and injected

Three cooperating services (`debug_bar.services.yml`):

1. **`DebugBarEventSubscriber::onKernelResponse()`** — for a main-request, non-redirect, non-AJAX
   response implementing `AttachmentsInterface` where the user has `view debug bar`, it calls
   `DebugBarBuilder::build()` and stores the rendered markup as the response attachment
   `debug_bar`.
2. **`DebugBarBuilder`** — `build()` renders the `debug_bar` theme (with `renderInIsolation()`),
   filtering `buildItems()` by each `DebugBarItem::$access`. Items and their gating are listed in
   `agent/start.md`. Timing/memory/db/cache values are emitted as placeholder tokens
   (`[execution_time]`, `[memory_usage]`, `[db_queries]`, `[anonymous_cache]`, `[dynamic_cache]`),
   not resolved here.
3. **`DebugBarMiddleware`** (priority 1001) — runs `Database::startLog('debug_bar')` at the start of
   the request, and after the kernel returns, if the response carries the `debug_bar` attachment,
   computes the real metrics (`microtime` vs `REQUEST_TIME_FLOAT`, the `debug_bar` query log count,
   `memory_get_peak_usage`, the `X-Drupal-Cache` / `X-Drupal-Dynamic-Cache` headers), `strtr`s them
   into the tokens, and `str_replace`s the bar before `</body>`. Doing the metric interpolation in
   the middleware keeps the numbers accurate even when the page body itself is served from cache
   (the event subscriber may run on a not-fully-bootstrapped instance).

Content-Length is only rewritten if the response already set it, to avoid breaking other response
modifiers (see drupal.org/node/3298551).

## Admin actions: Run cron / Clear caches

Handled in `DebugBarEventSubscriber::onKernelRequest()` (priority 250, after auth). The handler
returns immediately unless the user has **both** `administer site configuration` and
`view debug bar`. It reads `?token=…` from the query and:

- if `debug-bar-cron` is set and `csrfTokenGenerator->validate($token, DebugBarBuilder::CRON_KEY)`
  passes → `$this->cron->run()`, add a status message, redirect to `<current>`;
- if `debug-bar-cache` is set and the token validates against `CACHE_KEY` →
  `drupal_flush_all_caches()`, status message, redirect.

The bar builds those links with a fresh CSRF token (`csrf_token->get(CRON_KEY|CACHE_KEY)`), so the
GET actions are CSRF-protected and permission-gated.

## Frontend assets

Library `debug_bar` (`debug_bar.libraries.yml`) = `js/debug-bar.js` + `css/debug-bar.css`, deps
`core/drupal`, `core/once`; attached in `debug_bar_page_attachments()` only when the user has
`view debug bar`. The template `templates/debug-bar.html.twig` renders a toggler button and a
`<ul>` of items (each an `<a>` when it has a URL, else `<span>`); `template_preprocess_debug_bar()`
in `debug_bar.module` adds the `debug-bar__item` class, the icon background-image style from
`iconPath`, and the `title` tooltip attribute. `debug-bar.js` wires the toggle button.
