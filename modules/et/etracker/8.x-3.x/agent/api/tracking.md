<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the tracking script is emitted

All logic is procedural in `etracker.module`; constants in `src/Helper/Constants.php`
(`ETRACKER_JS_URL = https://code.etracker.com/code/e.js`, `ETRACKER_LIBRARY_NAME = etracker.js`,
`ETRACKER_FULL_LIBRARY_NAME = etracker/etracker.js`).

## 1. Library definition — `hook_library_info_build()`

Builds libraries dynamically from `etracker.settings`:

- **`etracker/etracker.js`** — one external JS asset (`ETRACKER_JS_URL`, `type: external`) with attributes:
  `type=text/javascript`, `id=_etLoader` (required by etracker), `charset=UTF-8`, `async=TRUE`,
  `data-block-cookies` / `data-respect-dnt` (`'true'`/`'false'` from `etracker_script_settings`), and
  **`data-secure-code` = the `account_key`**. If `etracker_scope_script === header`, `'header' => TRUE` is
  added so the loader renders in `<head>`.
- **`etracker/event_tracking`** — added only when any of `track_mailto`/`track_download`/`track_external`/
  `track_system_messages` is enabled; loads `js/etracker.js`, depends on `core/drupalSettings` and
  `etracker/etracker.js`.

Because attributes are baked into the library, `submitForm()` invalidates the `library_info` cache tag on save.

## 2. Attaching to a page — `hook_page_attachments()`

1. Merges the config's cache tags into `#cache[tags]`; returns early if `account_key` is empty.
2. Only proceeds when **both** `_etracker_path_should_be_tracked($config)` and
   `_etracker_user_should_be_tracked($config)` are TRUE.
3. Attaches `drupalSettings.etracker` = `{track_mailto, track_download, track_download_extensions,
   track_external, messages}`, then libraries `etracker/etracker.js` and `etracker/event_tracking`.
4. Builds `$et_variables` = `_btNoJquery=TRUE`, optional `et_areas` (breadcrumb titles), and `et_pagename`
   (resolved via `title_resolver`); **every value is `rawurlencode`d**, then rendered as an inline
   `html_head` `<script>` (`#tag => script`, `#value => "var name = ...;"` lines) keyed `etracker_tracking_script`.

### System-message events

When `track_system_messages` lists message types, each queued message of a selected type is added to
`drupalSettings.etracker.messages` as `{type: Json::encode(heading), text: Json::encode(strip_tags($message))}`
(tags stripped, JSON-encoded).

## 3. Visibility helpers

- `_etracker_path_should_be_tracked()` — compares the current path/alias (lower-cased) against
  `etracker_track_paths` with `path.matcher`; `all_pages` mode = track unless matched (XOR logic),
  `listed_pages` = track only if matched. Empty list ⇒ track all. Result cached per path via `drupal_static`.
- `_etracker_role_should_be_tracked()` — intersects the user's roles with `etracker_track_roles`; `all_roles`
  mode tracks unless the user has a listed role, `listed_roles` tracks only if they do (XOR).
- `_etracker_user_should_be_tracked()` — role check first; then if `etracker_track_user` is
  `no_customization` or the user lacks the opt permission → always track; otherwise reads the user's
  `user.data` opt-in/out, falling back to the configured default.
- `_etracker_get_breadcrumb_titles()` — builds the breadcrumb via the `breadcrumb` service; skips the front
  page and (in `breadcrumb_exclude_home` mode) the `<front>` link; returns already-sanitized link texts.

## 4. Client-side event JS — `js/etracker.js`

Runs when `drupalSettings.etracker` has any event flag. Delegated `mousedown`/`keyup`/`touchstart` listeners on
`body` inspect clicked `A`/`AREA` elements:

- `mailto:` links → `_etracker.sendEvent(new et_ClickEvent(...))`.
- href matching `\.(<extensions>)(\?|$)` → `et_UserDefinedEvent(href, 'Download')`.
- different-host links → `et_UserDefinedEvent('External link: ...', '')`.

It also replays each `drupalSettings.etracker.messages` entry as an `et_UserDefinedEvent(text, 'Message', type)`.
These `_etracker`/`et_*` globals come from the etracker loader (`e.js`).

## 5. CSP integration — `src/EventSubscriber/CspSubscriber.php`

Service `etracker.csp_subscriber` (`etracker.services.yml`). `getSubscribedEvents()` returns `[]` unless
`Drupal\csp\CspEvents` exists, so it is inert without the `csp` module. On `CspEvents::POLICY_ALTER`,
`onCspPolicyAlter()` appends `www.etracker.de` (constant `TRACKING_DOMAIN`) to `script-src` and
`script-src-elem` via `fallbackAwareAppendIfEnabled()`.

## Notes

- No server-side HTTP requests — the browser loads `e.js` directly from etracker; there is no SSRF/TLS/API-key
  surface in PHP.
- The account key is public by design (`data-secure-code`) and constrained to `\w{6,}`; the inline script
  contains only rawurlencoded titles and boolean/int flags.
