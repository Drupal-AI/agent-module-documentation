# consent_manager_pcp — settings & rendering

Thin `consent_manager` plugin (`id: pcp`, "Privacy Policy Generator"): one settings form stores a
consentmanager.net Code-ID; the shared base renders the vendor privacy-policy `<script>` through
the generic block. Plugin type basics:
[../../../../../3.0.x/agent/plugins/plugin.md](../../../../../3.0.x/agent/plugins/plugin.md).

## Settings form
- Route `consent_manager_pcp.settings` → **`/admin/config/consent-manager/psp`** (note: path is
  `psp`, a vendor typo, while the machine name is `pcp`). Requirement
  `_permission: 'administer consent manager settings'` (parent permission, `restrict access: true`).
  Menu link under `consent_manager.admin_index`.
- `\Drupal\consent_manager_pcp\Form\SettingsForm` extends parent `SettingsBaseForm`;
  `getPluginType()` returns `pcp` → editable config `consent_manager_pcp.settings`, form id
  `consent_manager_pcp_settings_form`.
- Detail groups: **Install now** (onboarding popup), **Manual installation** (Code-ID / Host),
  plus an **Info** group reminding you to place the block.

## Config object `consent_manager_pcp.settings`
Schema: `config/schema/consent_manager_pcp.schema.yml` (`config_object`).

| key | type | required | notes |
|---|---|---|---|
| `codeid` | string | yes | consentmanager.net Code-ID (`cdid`). Empty → `getCode()` returns FALSE and nothing renders. |
| `host` | string | no | Delivery host, hostname only. Blank → default `delivery.consentmanager.net`. Validated `FILTER_VALIDATE_DOMAIN | FILTER_FLAG_HOSTNAME`. |

Set without the UI:
```
drush config:set consent_manager_pcp.settings codeid 123456 -y
```
```php
\Drupal::configFactory()->getEditable('consent_manager_pcp.settings')
  ->set('codeid', '123456')
  ->save();
\Drupal\Core\Cache\Cache::invalidateTags(['consent_manager_pcp']);
```
The form's `submitForm()` calls `Cache::invalidateTags(['consent_manager_pcp'])`.

## Rendering (block-based, `has_block: TRUE`)
- Exposed as generic-block derivative **`consent_manager:pcp`** (admin label "Privacy Policy
  Generator"). Place it on your privacy/legal page via Block layout or `drush`; nothing renders
  until placed.
- Block `build()` renders `#markup => $plugin->getCode()` with cache tag `consent_manager_pcp`;
  empty when no Code-ID.
- Inherited base `getCode()` fills `@codeid` / `@host` (HTML-escaped via `FormattableMarkup`):
  ```
  <div class="cmppolicy@codeid cmpstyleroot"></div><script src="https://@host/delivery/pcpinfo.php?cdid=@codeid&format=simple&lang=automatic" type="text/javascript" async></script>
  ```
  `lang=automatic` lets consentmanager.net localize the policy; the `cmppolicy<codeid>` /
  `cmpstyleroot` container classes are the styling hooks.

## "Install now" onboarding
The base form's **Install now** button attaches `consent_manager/settings` and
`drupalSettings.consent_manager = {type:'pcp', domain, lang}`, opens
`https://app.consentmanager.net/clientv2/onboarding` in a popup, and `js/settings.js`
(origin-checked) fills `codeid`/`host` and submits on completion.
