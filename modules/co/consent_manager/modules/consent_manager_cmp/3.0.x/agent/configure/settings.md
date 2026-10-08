# consent_manager_cmp — settings & code injection

## Settings form
`src/Form/SettingsForm.php` (extends `SettingsBaseForm`, `getPluginType()` = `cmp`), route
`consent_manager_cmp.settings` at `/admin/config/consent-manager/cmp`, permission
`administer consent manager settings` (restrict access). Config object `consent_manager_cmp.settings`
(schema in `config/schema/consent_manager_cmp.schema.yml`):

| Key | Widget | Notes |
|---|---|---|
| `blocking` | select | `automatic` (auto-blocking) or `semi-automatic`. Required. |
| `codeid` | textfield | consentmanager.net Code-ID. Required; no code emitted without it. |
| `host` | textfield | Delivery host; blank → `delivery.consentmanager.net`. Validated as hostname. |
| `cdn` | textfield | CDN host; blank → `cdn.consentmanager.net`. Validated as hostname. |
| `custom_code` | textarea | Free HTML, prepended before the vendor script. Emitted **unescaped**. |

Plus the inherited "Install now" button (opens consentmanager.net onboarding popup; `js/settings.js`
auto-fills `codeid`/`host` on `postMessage` from `https://app.consentmanager.net`).

## Code templates (`src/Plugin/ConsentManager/Cmp.php`)
`getCode()` returns `FALSE` unless `codeid` is set, else `new FormattableMarkup($custom_code .
$default_code, ['@codeid'=>…, '@host'=>host ?: DEFAULT_HOST, '@cdn'=>cdn ?: DEFAULT_CDN])`:
- `AUTOMATIC_CODE` (blocking = automatic):
  `<script ... data-cmp-ab="1" src="https://@cdn/delivery/autoblocking/@codeid.js" data-cmp-host="@host" data-cmp-cdn="@cdn" data-cmp-codesrc="0"></script>`
- `SEMI_AUTOMATIC_CODE` (blocking = semi-automatic):
  `<script ... data-cmp-ab="1" src="https://@cdn/delivery/js/semiautomatic.min.js" data-cmp-cdid="@codeid" data-cmp-host="@host" data-cmp-cdn="@cdn" data-cmp-codesrc="0"></script>`

`@codeid/@host/@cdn` are escaped by `FormattableMarkup`; `custom_code` is the template string itself,
so it is NOT escaped.

## Where the code is injected (`consent_manager_cmp.module`)
Both handlers skip admin routes (`router.admin_context->isAdminRoute()`):
- `hook_page_attachments()` — when `blocking === 'automatic'` and `getCode()` truthy, appends the code
  to `$attachments['#attached']['html_head']` (id `consent_manager_cmp`), cache tag
  `consent_manager_cmp`.
- `hook_preprocess_html()` — when `blocking !== 'automatic'`, sets
  `$variables['page_top']['consent_manager_cmp']` with the markup + cache tag.

The `cmp` plugin is `has_block: FALSE`, so it is injected directly (not placeable as a block).

## Config migration
Parent `consent_manager_update_10001/10002` install this submodule and migrate legacy
`consent_manager.settings` (cdid/host/cdn/custom_code/blocking_mode) into `consent_manager_cmp.settings`.
