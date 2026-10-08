# consent_manager_dsr — settings & rendering

Thin `consent_manager` plugin (`id: dsr`, "Data Subject Rights"): one settings form stores a
consentmanager.net Code-ID; the shared base renders the vendor DSAR (data-subject-access-request)
form `<script>` through the generic block. Plugin type basics:
[../../../../../3.0.x/agent/plugins/plugin.md](../../../../../3.0.x/agent/plugins/plugin.md).

The DSR request form itself (its fields, verification, and any personal-data handling) is served
and processed entirely by consentmanager.net's remote `dsarform.php` script — this submodule only
embeds that script and holds no request data locally. There is no local route, controller, or
storage for subject requests; the only Drupal surface is the admin settings form below.

## Settings form
- Route `consent_manager_dsr.settings` → `/admin/config/consent-manager/dsr`, requirement
  `_permission: 'administer consent manager settings'` (parent permission, `restrict access: true`).
  Menu link under `consent_manager.admin_index`.
- `\Drupal\consent_manager_dsr\Form\SettingsForm` extends parent `SettingsBaseForm`;
  `getPluginType()` returns `dsr` → editable config `consent_manager_dsr.settings`, form id
  `consent_manager_dsr_settings_form`.
- Detail groups: **Install now** (onboarding popup), **Manual installation** (Code-ID / Host),
  plus an **Info** group reminding you to place the block.

## Config object `consent_manager_dsr.settings`
Schema: `config/schema/consent_manager_dsr.schema.yml` (`config_object`).

| key | type | required | notes |
|---|---|---|---|
| `codeid` | string | yes | consentmanager.net Code-ID (`dsarid`). Empty → `getCode()` returns FALSE and nothing renders. |
| `host` | string | no | Delivery host, hostname only. Blank → default `delivery.consentmanager.net`. Validated `FILTER_VALIDATE_DOMAIN | FILTER_FLAG_HOSTNAME`. |

Set without the UI:
```
drush config:set consent_manager_dsr.settings codeid 123456 -y
```
```php
\Drupal::configFactory()->getEditable('consent_manager_dsr.settings')
  ->set('codeid', '123456')
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['consent_manager_dsr']);
```
The form's `submitForm()` calls `Cache::invalidateTags(['consent_manager_dsr'])`.

## Rendering (block-based, `has_block: TRUE`)
- Exposed as generic-block derivative **`consent_manager:dsr`** (admin label "Data Subject
  Rights"). Place it in a region via Block layout or `drush`; nothing renders until placed.
- Block `build()` renders `#markup => $plugin->getCode()` with cache tag `consent_manager_dsr`;
  empty when no Code-ID.
- Inherited base `getCode()` fills `@codeid` / `@host` (HTML-escaped via `FormattableMarkup`):
  ```
  <div id="dsar"></div><script async src="https://@host/delivery/dsarform.php?dsarid=@codeid&type=script" type="text/javascript" data-cmp-ab="1"></script>
  ```

## "Install now" onboarding
The base form's **Install now** button attaches `consent_manager/settings` and
`drupalSettings.consent_manager = {type:'dsr', domain, lang}`, opens
`https://app.consentmanager.net/clientv2/onboarding` in a popup, and `js/settings.js`
(origin-checked) fills `codeid`/`host` and submits on completion.
