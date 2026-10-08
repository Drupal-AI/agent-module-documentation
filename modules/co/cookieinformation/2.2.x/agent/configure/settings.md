# Configure Cookie Information

Settings form: `/admin/config/system/cookie-information` (route `cookieinformation.settings`,
`CookieInformationSettingsForm`, permission `administer cookie information settings`). All values persist
in the `cookieinformation.settings` config object (schema `cookieinformation.schema.yml`).

## Settings keys

| Key | Form field | Meaning |
|---|---|---|
| `enable_popup` | Enable consent popup | Master switch; the popup script only loads when true (via `VisibilityService::checkEnabled`). |
| `enable_iab` | Enable IAB | Adds `data-tcf-v2-enabled="true"` + `data-tcf-version="2.2"` to the popup `<script>` (needs the IAB template on the platform). |
| `google_consent_mode` | Google Consent Mode | `''` (disabled), `v1`, or `v2`. Non-empty embeds `js/consent_mode[_v2].init.js` early (weight -200) and loads the `consent_mode`/`consent_mode_v2` library; `v2` also adds `data-gcm-version="2.0"`. |
| `block_iframes` | Block iframes | Enables client-side iframe blocking (needs `block_iframes_category` set too). |
| `block_iframes_category` | Iframe blocking category | `functional` / `marketing` / `statistic` (from `CategoryService`); category iframes must be consented to before they load. |
| `exclude_paths` | Exclude paths | Newline list, `*` wildcard, `<front>` supported; matched against both the internal path and its alias. |
| `exclude_admin` | Exclude admin pages | Suppress the popup on admin routes. |
| `exclude_uid_1` | Don't show for UID 1 | Suppress the popup for the superuser. |

## How the popup gets injected

`cookieinformation_page_attachments_alter()` runs `VisibilityService::checkAll()`; only if it returns
true is the `<script id="CookieConsent" src="https://policy.app.cookieinformation.com/uc.js"
data-culture="<lang>">` tag added to `html_head`. `data-culture` comes from `LanguageService::getId()`:
current interface language truncated to 2 chars, `no`/`nn` rewritten to `nb`, validated against a fixed
supported-language list, falling back to `en`.

## Visibility logic (`VisibilityService::checkAll`)

All of these must pass for the popup to show:

- `checkEnabled()` — `enable_popup` is true.
- `checkPermissions()` — user is **not** a non-UID-1 account holding `disable cookie information consent`
  (such users get **no** popup).
- `checkUser1()` — not (UID 1 **and** `exclude_uid_1`).
- `checkAdminRoutes()` — not (`exclude_admin` **and** current route is an admin route).
- `checkExcludePaths()` — current path (or its alias) does not match any `exclude_paths` pattern.

## Iframe blocking

When `block_iframes` + `block_iframes_category` are set, the module attaches the
`cookieinformation/iframes` library and passes `block_iframes_category` (+ translated label) in
`drupalSettings.cookieinformation`. `js/iframes.js` swaps each blocked iframe's `src` → `data-consent-src`
and adds `data-consent-category`, so iframes load only after the visitor accepts that category. Iframes
that already carry the consent attributes are left alone (assumed handled by a custom solution).

## Permissions

| Permission | Gates |
|---|---|
| `administer cookie information settings` | Access to the settings form / route. |
| `disable cookie information consent` | Any non-UID-1 role holding it is served pages **without** the consent popup (see `checkPermissions`). Use for staff/testing roles. |

## Set config with Drush (example)

```bash
ddev drush cset cookieinformation.settings enable_popup 1 -y
ddev drush cset cookieinformation.settings google_consent_mode v2 -y
ddev drush cset cookieinformation.settings block_iframes 1 -y
ddev drush cset cookieinformation.settings block_iframes_category functional -y
```

Requires an active Cookie Information subscription and the matching template configured on
go.cookieinformation.com (especially for IAB and GCM v2).
