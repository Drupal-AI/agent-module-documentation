# Configure lightGallery global settings

One admin settings form holding the lightGallery **license key** (lightGallery 2.x is commercially
licensed and refuses to run without a valid key). Per-display appearance is set on the field formatters
instead — see [../fields/formatters.md](../fields/formatters.md).

- Route: `lightgallery.admin.settings` → `/admin/config/user-interface/lightgallery`
- Form: `Drupal\lightgallery\Form\SettingsForm` (extends `ConfigFormBase`), form id `lightgallery_settings_form`
- Menu link: `lightgallery.admin.settings` under `system.admin_config_ui`
- Access: permission `configure lightgallery`
- Config object: `lightgallery.settings`

## Config object & schema

| Key | Type | Notes |
|---|---|---|
| `license_key` | string | Required. Schema constraints: `NotBlank` and Regex `/^[A-Z0-9]+(-[A-Z0-9]+)+$/` (uppercase A–Z / 0–9 groups joined by hyphens). Install default `0000-0000-000-0000`. |

The form field uses `#config_target => 'lightgallery.settings:license_key'`, so saving writes straight
to the config object. At render time `template_preprocess_lightgallery()` reads
`lightgallery.settings:license_key` and passes it to lightGallery as the `licenseKey` init option, and
adds the cache tag `config:lightgallery.settings` to any gallery.

## Set it with Drush / PHP

```bash
drush config:set lightgallery.settings license_key 'XXXX-XXXX-XXX-XXXX' -y
```

```php
\Drupal::configFactory()
  ->getEditable('lightgallery.settings')
  ->set('license_key', 'XXXX-XXXX-XXX-XXXX')
  ->save();
```
