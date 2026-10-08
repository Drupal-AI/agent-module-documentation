<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, config object & CMP injection

Enable: `drush en usercentrics`. Configure at `/admin/config/user-interface/usercentrics/settings`
(route `usercentrics.admin`, form `src/Form/SettingsForm.php`, `_permission: administer usercentrics`).
The Data Processing Services ordering table lives at the parent path (route
`usercentrics.admin.order_form`) — see [../entities/dps-app.md](../entities/dps-app.md).

## Config object `usercentrics.settings`

Single config object, edited only by `SettingsForm` (`getEditableConfigNames()`). Schema:
`config/schema/usercentrics.schema.yml`; install defaults: `config/install/usercentrics.settings.yml`.

| Key | Type | Default | Form tab | Meaning |
|-----|------|---------|----------|---------|
| `enabled` | bool | `true` | CMP | Master on/off. |
| `settings_id` | string | `''` | CMP | Usercentrics settings ID; emitted as `data-settings-id` on the loader. Empty ⇒ CMP not injected. |
| `tcf_enabled` | bool | `false` | CMP | Adds `data-tcf-enabled` (IAB TCF). |
| `preview` | bool | `false` | CMP | Adds `data-version="preview"`. |
| `disable_tracking` | bool | `false` | CMP | Adds `data-disable_tracking`. |
| `sdp_enabled` | bool | `false` | SDP | Also inject Smart Data Protection blocker (`privacy-proxy.usercentrics.eu/latest/uc-block.bundle.js`). |
| `show_toggle_button` | bool | `true` | Button | Attach `usercentrics/ui` (floating "Manage consents" button). |
| `toggle_button_icon` | string | `''` | Button | Optional icon URL → `drupalSettings.usercentrics.logoPath`, used as the button's CSS `background-image`. |
| `debug` | bool | `false` | Advanced | Log every checked/rewritten library, script, attachment to the `usercentrics` logger channel. |
| `exclude_admin_paths` | bool | `true` | Advanced | Suppress CMP on admin routes (via `router.admin_context`). |
| `exclude_admin_role` | bool | `false` | Advanced | Suppress CMP for users whose role `isAdmin()`. |
| `auto_decorate_js_alter` | bool | `true` | Advanced | Enable `hook_js_alter` gating. |
| `auto_decorate_page_attachments` | bool | `true` | Advanced | Enable `hook_page_attachments_alter` gating. |
| `auto_decorate_library_info_alter` | bool | `true` | Advanced | Enable `hook_library_info_alter` gating. |
| `exclude_urls` | sequence<string> | `[]` | Advanced | Regex patterns (no delimiters). On a match: CMP hidden AND resources stay blocked. |
| `disable_urls` | sequence<string> | `[]` | Advanced | Regex patterns. On a match: CMP hidden AND resources NOT blocked. |

`SettingsForm::submitForm()` splits the two textareas on newlines, `array_map('trim', …)` then
`array_filter(...)` before saving. The form shows a warning if no non-administrator role holds
`use usercentrics` (i.e. anonymous visitors can't operate the banner yet).

## Enable / access gate (`UsercentricsHelper`)

`hook_page_attachments()` and each alter hook short-circuit unless all pass:

- `isEnabled()` — `enabled` true AND `settings_id` non-empty; returns false on admin routes when
  `exclude_admin_paths`, and false for admin-role users when `exclude_admin_role`.
- `hasAccess()` — current user has the `use usercentrics` permission.
- `onDisabledUri()` — request URI matches any `disable_urls` pattern (always also matches
  `^\/media\/oembed`, so the oEmbed iframe route is skipped by design).
- `onExcludedUri()` — request URI matches any `exclude_urls` pattern.

URL patterns are wrapped as `'/' . $pattern . '/'` and run through `preg_match` against
`$request->getRequestUri()` — admin-authored regexes, no user input.

## CMP script injection (public, in `usercentrics_page_attachments()`)

The loader is added as a render array, **not** string-concatenated markup:

```php
$cmp = [
  ['#tag' => 'script', '#attributes' => [
     'src' => 'https://app.usercentrics.eu/browser-ui/latest/loader.js',
     'type' => 'text/javascript',
     'data-settings-id' => $settings_id,
     'id' => 'usercentrics-cmp', 'async' => 'async',
  ]], 'usercentrics-cmp',
];
array_unshift($page['#attached']['html_head'], $cmp);
```

`data-settings-id`, and the conditional `data-tcf-enabled` / `data-version` / `data-disable_tracking`
flags, are attribute values on a core `#tag => 'script'` element (rendered via `HtmlTag`/`Attribute`,
which escapes attribute values). The `src` is a fixed usercentrics.eu URL. Matching `preconnect`/
`preload` `<link>`s are appended. When `sdp_enabled`, the SDP blocker script + its preconnect/preload
are added the same way (prepended so Usercentrics loads first). The config object is added as a
cacheable dependency so editing settings invalidates page caches.
