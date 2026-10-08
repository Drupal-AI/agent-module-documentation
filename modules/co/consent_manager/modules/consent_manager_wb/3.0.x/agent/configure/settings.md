# consent_manager_wb — settings & rendering

Thin `consent_manager` plugin (`id: wb`): one settings form stores a consentmanager.net Code-ID,
and the shared base renders the vendor whistleblowing-form `<script>` through the generic block.
Plugin type basics: [../../../../../3.0.x/agent/plugins/plugin.md](../../../../../3.0.x/agent/plugins/plugin.md).

## Settings form
- Route `consent_manager_wb.settings` → `/admin/config/consent-manager/wb`, requirement
  `_permission: 'administer consent manager settings'` (permission defined by the **parent**
  module, `restrict access: true`). Menu link `consent_manager_wb.settings` under
  `consent_manager.admin_index`.
- `\Drupal\consent_manager_wb\Form\SettingsForm` extends parent `SettingsBaseForm`;
  `getPluginType()` returns `wb`, so its editable config is `consent_manager_wb.settings` and its
  form id is `consent_manager_wb_settings_form`.
- Two open detail groups: **Install now** (onboarding popup, below) and **Manual installation**
  (the Code-ID / Host fields). An **Info** group reminds you to place the block.

## Config object `consent_manager_wb.settings`
Schema: `config/schema/consent_manager_wb.schema.yml` (`config_object`).

| key | type | required | notes |
|---|---|---|---|
| `codeid` | string | yes | consentmanager.net Code-ID / whistleblower id (`wbid`). Empty → `getCode()` returns FALSE and nothing renders. |
| `host` | string | no | Delivery host, hostname only (no scheme). Blank → default `delivery.consentmanager.net`. Validated with `FILTER_VALIDATE_DOMAIN | FILTER_FLAG_HOSTNAME`. |

Set without the UI:
```
drush config:set consent_manager_wb.settings codeid 123456 -y
```
```php
\Drupal::configFactory()->getEditable('consent_manager_wb.settings')
  ->set('codeid', '123456')
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['consent_manager_wb']);
```
The form's `submitForm()` calls `Cache::invalidateTags(['consent_manager_wb'])`.

## Rendering (block-based, `has_block: TRUE`)
- Exposed as a derivative of the parent's generic block: plugin id **`consent_manager:wb`**,
  admin label "Whistleblowing Tool", category "consentmanager". Place it in a region via Block
  layout (`/admin/structure/block`) or `drush` — nothing shows until the block is placed.
- The block's `build()` renders `#markup => $plugin->getCode()` with cache tag
  `consent_manager_wb`; empty build when no Code-ID.
- Inherited base `getCode()` fills the template's `@codeid` / `@host` placeholders via
  `FormattableMarkup` (values HTML-escaped):
  ```
  <div id="whistleblower"></div><script async src="https://@host/delivery/whistleblowerform.php?wbid=@codeid&type=script" type="text/javascript" data-cmp-ab="1"></script>
  ```

## "Install now" onboarding
The base form's **Install now** button attaches library `consent_manager/settings` and
`drupalSettings.consent_manager = {type:'wb', domain:<current host>, lang:<default langcode>}`,
then opens `https://app.consentmanager.net/clientv2/onboarding` in a popup. On completion the
popup posts a message back; `js/settings.js` verifies the origin, fills the matching fields, and
submits — auto-populating `codeid`/`host`.
