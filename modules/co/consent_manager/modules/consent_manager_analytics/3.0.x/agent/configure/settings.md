# consent_manager_analytics — settings & rendering

Thin `consent_manager` plugin (`id: analytics`, "Privacy-Friendly Website Analytics"): one settings
form stores a consentmanager.net Code-ID; unlike the block-based products this submodule injects the
vendor "trackless" analytics `<script>` itself on every non-admin page. Plugin type basics:
[../../../../../3.0.x/agent/plugins/plugin.md](../../../../../3.0.x/agent/plugins/plugin.md).

## Settings form
- Route `consent_manager_analytics.settings` → `/admin/config/consent-manager/analytics`,
  requirement `_permission: 'administer consent manager settings'` (parent permission,
  `restrict access: true`). Menu link under `consent_manager.admin_index`.
- `\Drupal\consent_manager_analytics\Form\SettingsForm` extends parent `SettingsBaseForm`;
  `getPluginType()` returns `analytics` → editable config `consent_manager_analytics.settings`,
  form id `consent_manager_analytics_settings_form`.
- Detail groups: **Install now** (onboarding popup) and **Manual installation** (Code-ID / Host).
  No "place a block" info group — this product renders itself (below).

## Config object `consent_manager_analytics.settings`
Schema: `config/schema/consent_manager_analytics.schema.yml` (`config_object`).

| key | type | required | notes |
|---|---|---|---|
| `codeid` | string | yes | consentmanager.net Code-ID. Empty → `getCode()` returns FALSE and nothing is injected. |
| `host` | string | no | Delivery host, hostname only. Blank → default `delivery.consentmanager.net`. Validated `FILTER_VALIDATE_DOMAIN | FILTER_FLAG_HOSTNAME`. |

Set without the UI:
```
drush config:set consent_manager_analytics.settings codeid 123456 -y
```
```php
\Drupal::configFactory()->getEditable('consent_manager_analytics.settings')
  ->set('codeid', '123456')
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['consent_manager_analytics']);
```
The form's `submitForm()` calls `Cache::invalidateTags(['consent_manager_analytics'])`.

## Rendering (self-injected, `has_block: FALSE`)
- `consent_manager_analytics_preprocess_html()` (in `.module`) runs on every non-admin route
  (skips when `router.admin_context` reports an admin route). It builds the `analytics` plugin,
  and if `getCode()` is non-empty places `#markup => code` into `page_bottom` with cache tag
  `consent_manager_analytics`. No block to place.
- Inherited base `getCode()` fills `@codeid` / `@host` (HTML-escaped via `FormattableMarkup`):
  ```
  <script src="https://@host/trackless/delivery/@codeid.js" async type="text/javascript"></script>
  ```
  The `trackless` delivery path is the cookieless/privacy-friendly variant.
- `hook_install` (`consent_manager_analytics_install()`) sets the `consent_manager_cmp` module
  weight to 100 so the banner code orders after analytics.

## "Install now" onboarding
The base form's **Install now** button attaches `consent_manager/settings` and
`drupalSettings.consent_manager = {type:'analytics', domain, lang}`, opens
`https://app.consentmanager.net/clientv2/onboarding` in a popup, and `js/settings.js`
(origin-checked) fills `codeid`/`host` and submits on completion.
