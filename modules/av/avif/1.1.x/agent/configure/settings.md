# Configure Avif

Settings form `Drupal\avif\Form\SettingsForm` (form id `avif_settings_form`), route
`avif.settings_form` at `/admin/config/media/avif`, permission `administer site configuration`.
Menu link `avif.settings_form` sits under `system.admin_config_media` (Configuration » Media » Avif).

Config object: **`avif.settings`** (schema `config/schema/avif.schema.yml`, type `config_object`).

| Key | Type | Form element | Default | Notes |
| --- | --- | --- | --- | --- |
| `processor` | string | select | *(none installed)* | Plugin id of the `AvifProcessor` to use. The select also offers `undefined`; any value not matching an installed plugin disables conversion (the service logs an error and returns FALSE). Shipped option: `imagemagick`. |
| `quality` | integer | number (min 1, max 100) | `60` | AVIF encode quality. `config/install/avif.settings.yml` ships only `quality: 60`; `processor` is unset until the form is saved. |

The quality change applies to **new** derivatives only; flush image styles (UI, `drush image:flush`,
or clearing the styles directory) to re-encode existing ones. The form's `submitForm()` casts and saves
both values: `->set('quality', (int) …)->set('processor', (string) …)`.

## Set it without the UI

```php
\Drupal::configFactory()->getEditable('avif.settings')
  ->set('processor', 'imagemagick')
  ->set('quality', 60)
  ->save();
```

```bash
drush config:set avif.settings processor imagemagick -y
drush config:set avif.settings quality 60 -y
```

The `Avif` service reads `quality` and `processor` from `avif.settings` in its constructor, so a config
change takes effect on the next request that instantiates it.
