<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookiebot + GTM — configuration

Single config object **`cookiebot_gtm.cookiebot_gtm_config`**. The module ships **no config schema and
no `config/install` default** — the object exists only after the form is first saved
(`drush cget cookiebot_gtm.cookiebot_gtm_config` errors before that). One form, one dedicated
permission.

Form: `src/Form/CookiebotGtmConfigForm.php` (`ConfigFormBase`, id `cookiebot_gtm_config_form`).
Route `cookiebot_gtm.cookiebot_gtm_config_form` → `/admin/config/cookiebot_gtm`, permission
**`access cookiebot gtm config`** (`restrict access: TRUE`, so not granted to any role by default).
CSRF is handled by the Form API.

## Keys
- **`cbid`** (textfield, maxlength 255) — Cookiebot Domain Group Id, UUID form
  `00000000-0000-0000-0000-000000000000`. **Not format-validated.** Drives `data-cbid` on the
  Cookiebot script and the `/cookie-declaration` script URL.
- **`cookie_blocking`** (select, `auto`|`manual`, default `auto`) — becomes `data-blockingmode`.
- **`use_multilingual`** (checkbox) — when on, the current language is passed to the Cookiebot banner
  (`data-culture=<UPPER LANGID>`) and to the cookie-declaration page.
- **`use_multilingual_gtm_id`** (checkbox) — when on, the page uses the per-language id
  `gtm_id_<langid>` instead of `gtm_id`; reveals the per-language fieldset.
- **`gtm_id`** (textfield, maxlength 64) — GTM container id. **Validated** `^GTM-[A-Z0-9]{1,8}$` in
  `validateForm()`, **always** (even when the multilingual-id option is on).
- **`gtm_id_<langid>`** (per active language) — per-language container id. Validated with the same
  regex **only when `use_multilingual_gtm_id` is checked**.
- **`gtm_hostname`** (url field, maxlength 255) — override for the GTM host; empty ⇒
  `https://www.googletagmanager.com`. Validated as a URL by the `url` element only.
- **`gtm_environment_id`** (textfield) — GTM environment id → `gtm_preview` query param.
  **No validation.**
- **`gtm_environment_token`** (textfield) — GTM environment token → `gtm_auth` query param.
  **No validation.** The environment query is emitted only when both id and token are set;
  `cookiebot_gtm_prepare_query()` `json_encode`s each then trims the surrounding quotes.

## Google Consent Mode (details fieldset, `consent_mode_enabled`)
When `consent_mode_enabled` is on, `hook_page_attachments_alter()` emits an inline
`gtag("consent","default",{…})` default block and adds `data-consentmode-defaults="disabled"` to the
Cookiebot script. Each of these booleans maps to `granted` (checked) / `denied` (unchecked):
- **`ad_personalization`**, **`ad_storage`**, **`ad_user_data`**, **`analytics_storage`**,
  **`functionality_storage`**, **`personalization_storage`**.
`security_storage` is always `granted`; `wait_for_update: 500`; `ads_data_redaction` and
`url_passthrough` are set to `true`.

## Notes
- No Drush commands, no plugin types, no submodules.
- Because no schema is shipped, config export/import for this object is unvalidated (Drupal warns on
  schema-less config in development); it does not affect runtime.
