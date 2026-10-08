<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Cookie Control — settings, routes & permissions

## Install / enable

```bash
drush en civiccookiecontrol -y
```

`hook_install` (`civiccookiecontrol.install`) runs `civiccookiecontrol_install_html_format()`
(installs a "Cookie Control HTML" filter format + editor from `config/optional/`, choosing the
ckeditor5/ckeditor/noeditor variant that matches the enabled editor) and flushes caches.
`hook_uninstall` deletes the three config objects plus the editor/format config and clears the
module's private tempstore. `hook_update_N` functions `8210`–`8415` migrate config across widget
versions 8.2→9.9.

## Permission

Single permission (`civiccookiecontrol.permissions.yml`): **`administer civiccookiecontrol`**.
It gates every configuration screen. There is no separate "view" permission — the widget renders
to all visitors via page attachments, not via a route.

## Config objects

Names are centralised in `src/CCCConfigNames.php` (read it instead of hard-coding):

| Constant | Config name | Purpose |
|---|---|---|
| `COOKIECONTROL` | `civiccookiecontrol.settings` | Main widget settings (~90 keys) |
| `IAB` | `civiccookiecontrol.iab` | IAB TCF v1 (legacy, widget v8) |
| `IAB2` | `civiccookiecontrol.iab2` | IAB TCF v2 vendor/panel text |

Schema: `config/schema/civiccookiecontrol.schema.yml` (+ per-entity schema files). Install defaults:
`config/install/civiccookiecontrol.settings.yml`, `.iab.yml`, `.iab2.yml`.

Key `civiccookiecontrol.settings` fields (see the install YAML for the full list):
- `civiccookiecontrol_api_key` (string) — the Civic **site key** (public, domain-locked).
- `civiccookiecontrol_api_key_version` (int `8`|`9`) — selects which CDN script + config builder.
- `civiccookiecontrol_product` — `COMMUNITY` | `PRO` | `PRO_MULTISITE` | `CUSTOM`.
- `civiccookiecontrol_mode` (`GDPR`), `_layout`, `_initial_state`, `_widget_position`,
  `_widget_theme` — widget presentation.
- `_locale_mode` (`browser`|`drupal`) — how alt-language locales are chosen.
- `_privacynode` / `_ccpa_privacynode` — node IDs whose canonical URL becomes the statement link.
- Text keys (`_title_text`, `_intro_text`, `_notify_*`, `_accept_*`, `_reject_*`, …) and branding
  colour keys feed the widget `text` / `branding` objects.
- Cookie behaviour: `_consent_cookie_expiry`, `_same_site_cookie` / `_same_site_value`,
  `_secure_cookie`, `_cc_cookie`, `_sub_domains`, `_encode_cookie`, `_log_consent`.
- `_onload` — raw JS wrapped as `function(){…}` and eval'd client-side on load.

## Routes (`civiccookiecontrol.routing.yml`)

| Route | Path | Access |
|---|---|---|
| `cookiecontrol.admin_overview` | `/admin/config/system/cookiecontrol` | `_permission: administer civiccookiecontrol` |
| `cookiecontrol.iab1` | `…/iab1` | `_iab1_access_check` |
| `cookiecontrol.iab2` | `…/iab2` | `_iab2_access_check` |
| `entity.cookiecategory.collection` | `…/cookiecategory` | `_iab2_enabled_access_check` |
| `entity.necessarycookie.collection` | `…/necessarycookie` | `CookieControlAccess::checkAccess` |
| `entity.excludedcountry.collection` | `…/excludedcountry` | `CookieControlAccess::checkAccess` |
| `entity.altlanguage.collection` | `…/altlanguage` | `CookieControlAccess::checkAccess` |
| `entity.<type>.add/edit/delete_form` | `…/<type>/…` | `_permission: administer civiccookiecontrol` |

Access services (`civiccookiecontrol.services.yml`, classes in `src/Access/`):
- `CookieControlAccess::checkAccess` → allowed iff `administer civiccookiecontrol` **and**
  `checkApiKey()` (a valid, validated API key exists).
- `IAB2EnabledAccess` (`_iab2_enabled_access_check`) → for the cookiecategory collection: on
  widget v8 delegates to IAB1 access; on v9 requires the permission + valid key + IAB2 **off**
  (categories are unused when TCF v2 is enabled).
- `IAB1Access` / `IAB2Access` gate the legacy/v2 IAB settings forms.

Every collection/settings route ultimately requires `administer civiccookiecontrol`; the custom
checks additionally require a validated licence, so unlicensed admins see only the licence step.

## Settings wizard

`CivicCookieControlSettings extends ConfigFormBase` (`getEditableConfigNames()` →
`civiccookiecontrol.settings`) is a multi-step form. `CCCStepsManager` (service, injected with
`CCCLicenseInfo` + `CCCSettings`) picks the step: if `CookieControlAccess::checkApiKey()` is false
it starts on `CCCLicenseInfo` (enter key/version/product), otherwise on `CCCSettings` (full
customisation). `CCCLicenseInfo::checkApiKey()` and `CivicCookieControlSettings::validateForm()`
both call `CCCFormHelper::validateApiKey()` to confirm the key/product against Civic before saving.
`submitValues()` writes each `civiccookiecontrol_*` value and deletes the
`civiccookiecontrol_config` cache. Statement node IDs are validated to exist (`validateStatementNode`).
