<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DocCheck Basic — settings & config object

Admin form `SettingsForm` (`src/Form/SettingsForm.php`, form id `doccheck_basic.settings`) at
`/admin/config/people/doccheckbasic` (`administer site configuration`). Editable config object:
`config.doccheck_basic`. Schema: `config/schema/config.doccheck_basic.schema.yml`. Install defaults:
`config/install/config.doccheck_basic.yml`.

## Install / enable
1. `composer require drupal/doccheck_basic` (pulls `doccheck/oauth2-doccheck`).
2. `drush en doccheck_basic` — requires `node` and `block`.
3. Configure at the settings route, then place the "DocCheck Basic" block or link `/doccheck-login`.

## Config keys (`config.doccheck_basic`)
| Key | Type | Form field | Meaning |
|-----|------|-----------|---------|
| `dc_loginid` | text | "DocCheck Login-Client-ID" (required) | DocCheck login-client id; rendered into the login button. Default seed `12345678901234567890`. |
| `dc_client_secret` | text | "DocCheck Login-Client-Secret" | OAuth2 client secret; configure it so the callback verifies the DocCheck authorization `code` server-side via OAuth2. Set this for production use. |
| `dc_template` | string | "Button size" (required) | `button_small` / `button_medium` / `button_large`; the twig strips the `button_` prefix to set the web component `size`. Default `button_large`. |
| `dc_devmode` | boolean | "Development mode" | Shows a direct "Development mode login" link and skips the code check in the callback. For pre-launch only. Default `false`. |
| `dc_user` | integer | "Login as User" (required) | UID of the single Drupal account every DocCheck visitor is logged in as. The select excludes anonymous, administrator, and users with only the authenticated role — an extra role is required and must have view rights to the protected pages. Default `-1`. |
| `dc_noderedirect` | text | "Page login redirect" | Internal path (must start with `/`, run through `path_alias.manager`) that page logins land on; blank returns to `/doccheck-login`. |
| `dc_crawler_autologin` | boolean | "Automatic login" | Enables IP-based auto-login for the DocCheck search crawler. Default `false`. |
| `dc_crawler_ip` | sequence(string) | "DocCheck Search crawler IPs" (one per line) | Whitelisted crawler IPs. Entering literal `self` stores the submitter's `REMOTE_ADDR`. Default `['195.82.66.150']`. |

`submitForm()` clears three legacy keys (`dc_template_custom`, `dc_template_custom_width`,
`dc_template_custom_height`) on every save. `validateForm()` enforces the leading slash on
`dc_noderedirect` and requires at least one IP when autologin is on.

## Config-translation
`doccheck_basic.config_translation.yml` maps the settings form for the Config Translation module.

## Drush recipes (from README)
- Disable dev mode: `drush config-set config.doccheck_basic dc_devmode 0`
- Set login id: `drush config-set config.doccheck_basic dc_loginid <id>`

## Operating notes
- The block, `/doccheck-login`, and `/_dc_callback` are all uncacheable (`no_cache`, block max-age 0,
  and `page_cache_kill_switch` triggered at render) because a session value stores the requested URL.
- The module sets no permissions and blocks nothing on its own. You must give the `dc_user` account a
  dedicated role and grant that role node/view access (and block visibility) for the protected content.
  Keep that account's permissions minimal and protect its user-edit page (README recommends
  `userprotect`); pair with `r4032login` to send 403s to the login page.
