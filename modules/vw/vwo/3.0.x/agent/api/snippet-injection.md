<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VWO (Wingify) — snippet injection & services

How the Smart Code gets onto the page, plus the two services and the helper class. Source:
`vwo.module`, `src/VwoSmartCode.php`, `src/AccountInfo.php`, `src/VwoHelp.php`, `vwo.services.yml`.

## Injection: `vwo_page_attachments(&$attachments)`

`hook_page_attachments()` in `vwo.module` decides, per request, whether to attach the snippet:

1. Uses a `drupal_static('vwo_state', …)` guard so it only adds once.
2. Reads `vwo.settings`; **returns immediately if `id` is null.**
3. If `filter.enabled != 'on'` and nothing else flagged `state['add']`, returns (manual-include mode).
4. When filtering is on, evaluates the filters as boolean AND, adding cache contexts as it goes:
   - **Per-user opt-out** (`filter.userconfig` != `nocontrol`, authenticated user): default from
     `optin`/`optout`, overridden by the user's stored `user.data` value `vwo:userconfig`; adds the
     `user` cache context.
   - **Content type** (`filter.nodetypes`): current route's `node` must be one of the types, else drop;
     adds `url.path`.
   - **Roles** (`filter.roles`): current user must have one of the roles; adds `user.roles`.
   - **Path** (`filter.page.list`): `listinclude`/`listexclude` matched via `path.matcher` against the
     current path and its alias; or `usephp` runs `php_eval()` **only if the `php` module exists**;
     adds `url.path`.
5. If still adding, resolves the host via `AccountInfo` (fetching once if needed), merges the config's
   cache tags, and attaches to `#attached['html_head']`:
   - **async** (`loading.type == 'async'`): a `preconnect` `<link>` to
     `VwoSmartCode::getPreconnectUrl()`, then an inline `<script>` (id from
     `VwoSmartCode::getScriptElementId()`, `data-cfasync="false"`) whose body is
     `VwoSmartCode::getAsyncScript($id, $timeout, $isWingify)`. `drupalSettings.vwo` gets `{id, timeout_setting, testnull}`.
   - **sync**: a `<script src>` from `VwoSmartCode::getSyncScriptUrl($id, $isWingify)` (i.e.
     `https://<host>/tag/<id>.js`); no extra cache contexts.

`state['cache_contexts']` are merged into `#cache['contexts']` so the anti-cache-poisoning varies correctly.

## `VwoSmartCode` (static helper, `src/VwoSmartCode.php`)

Chooses host/branding from an `$isWingify` bool:

- `getPreconnectUrl($isWingify)` → `https://edge.wingify.net` or `https://dev.visualwebsiteoptimizer.com`.
- `getSyncScriptUrl($accountId, $isWingify)` → `https://<host>/tag/<accountId>.js`.
- `getScriptElementId($isWingify)` → `wingifyCode` or `vwoCode`.
- `getAsyncScript($accountId, $timeout, $isWingify)` → the V3.0 inline bootstrap
  (`window._wingify_code`/`window._vwo_code` … `version = 3.0`, `settings_tolerance = <timeout>`,
  body-hide anti-flicker style, nonce-aware `addScript`). `account_id` and the timeout are interpolated
  as numbers (the account ID is validated numeric before storage).

## `AccountInfo` service (`vwo.account_info`, `src/AccountInfo.php`)

Constructed with `@config.factory` and `@http_client`. Detects whether an account ID belongs to the
newer Wingify platform:

- `needsFetch()` — true when `id` is set but `is_wingify_account` is still `null`.
- `fetchAndSaveAccountInfo($accountId)` — GETs `https://edge.wingify.net/accInfo?a=<id>` (only for a
  numeric id), decodes JSON, and saves `coll_url` (`data['collUrl']`) and
  `is_wingify_account` (`!!data['wd']`) into `vwo.settings`. On any error/empty body it returns `''`
  and stores nothing.
- `isWingifyAccount()` — true only when config `is_wingify_account === TRUE`.
- `clearAccountInfo()` — nulls `coll_url` and `is_wingify_account`.

## `VwoHelp` service (`vwo.help`, `src/VwoHelp.php`)

Returns static promotional help HTML: `getSettingsUpdatedHelp()` (a "Get Started for Free" banner) and
`getReportHelp()` (a "Wingify Dashboard" block). Injected into the Settings form.

## Per-user opt-out UI (`vwo_form_user_form_alter`)

When `filter.userconfig` != `nocontrol` and `id` is set, the module adds a "Wingify" checkbox
("Include Wingify A/B testing") to `user_form`; the submit handler `_vwo_form_user_form_alter_submit`
stores the choice in `user.data` under module `vwo`, key `userconfig`, keyed by uid. This is what the
per-user filter in `hook_page_attachments()` reads.

## Manual inclusion

With visibility processing disabled (`filter.enabled = 'off'`), another module can flag the snippet
for a given render; the module's help text references a `wingify_include_js()` template pattern
(see the project's examples).
