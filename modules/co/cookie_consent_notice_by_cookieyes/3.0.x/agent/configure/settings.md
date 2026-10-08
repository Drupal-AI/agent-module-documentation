# Cookie Consent Notice by CookieYes — configuration

## Config object `cookie_consent_notice_by_cookieyes.settings`

| Key | Type | Default (intended) | Meaning |
|---|---|---|---|
| `scripts` | string | `''` | The full CookieYes `<script>` snippet pasted from your CookieYes account. |
| `enable` | bool | `false` | Whether to inject the script on front-end pages. |

No config schema ships. Set via Drush (recommended given the form defect below):

```bash
ddev drush config:set cookie_consent_notice_by_cookieyes.settings enable 1 -y
ddev drush config:set cookie_consent_notice_by_cookieyes.settings scripts \
  '<script id="cookieyes" type="text/javascript" src="https://cdn-cookieyes.com/client_data/XXXX/script.js"></script>' -y
```

## Admin form (has a shipped defect)

- Intended route: `cookie_consent_notice_by_cookieyes.admin` →
  `/admin/config/development/cookie_consent_notice_by_cookieyes`.
- Permission: **`cookieyes_scripts_settings`** (`restrict access: TRUE`).
- Form class `Drupal\cookie_consent_notice_by_cookieyes\Form\BodyForm` (`ConfigFormBase`) with a
  fieldset containing the `enable` checkbox and the `scripts` textarea.
- **Defect:** `cookie_consent_notice_by_cookieyes.routing.yml` sets
  `_form: '\Drupal\cookieyes_scripts\Form\BodyForm'` — a class that does not exist (verified: the
  only class is under namespace `cookie_consent_notice_by_cookieyes`). Loading the settings page
  will error until the routing is patched to the correct class. Use `drush config:set` meanwhile.

## Default-config defect

`config/install/cookie_consent_notice_by_cookieyes.settings` is missing the `.yml` extension, so
Drupal does not import it on install; the config object starts empty (`[]`) rather than with
`scripts: ''` / `enable: false`. The `hook_page_attachments_alter()` guard (`empty($settings['enable'])`)
handles the empty state gracefully — nothing is injected until you set the values.

## Injection logic (`cookie_consent_notice_by_cookieyes_page_attachments_alter`)

1. Returns early if `enable` is empty, `scripts` is empty, or the current route is an admin route.
2. `preg_match('/src=(["\'])(.*?)\1/', $scripts, …)` extracts the script URL; if none is found,
   nothing is attached.
3. `preg_match('/id=(["\'])(.*?)\1/', …)` extracts the script `id` (default `cookieyes`).
4. Attaches one `html_head` `<script>` element: `src` = parsed URL, `type` = `text/javascript`,
   `id` = parsed id. (The help text says `<body>`, but the code attaches to `<head>`.)

The snippet is admin-authored (behind a `restrict access: TRUE` permission); this module only
loads the external CookieYes script, which does the actual banner/consent work.
