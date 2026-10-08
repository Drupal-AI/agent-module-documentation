# Configure External Media services

Settings form: `\Drupal\external_media\Form\ExternalMediaSettings`
(form id `external_media_settings`), route **`external_media.settings`** at
`/admin/config/media/external-media` (link under *Configuration › Media*,
`external_media.links.menu.yml`). Requires permission `administer site configuration`.

Important: this is a plain `FormBase`, **not** a `ConfigFormBase`. All values are
stored in **State**, in the single array `\Drupal::state()->get('external_media.info')`,
keyed by plugin id. There is **no config object, no `config/install`, and no config
schema** — settings are not exported with the site's configuration and do not appear
in `drush config:export`.

## Per-service settings

The form loops every `ExternalMedia` plugin whose `classExists()` returns TRUE and
renders one vertical-tab per service with:

| Field (form key) | State key (under plugin id) | Meaning |
|---|---|---|
| Enable plugin (`<id>_enabled`) | `enabled` | Disabled services are hidden from File/Image fields. |
| Button label (`<id>_label`) | `button_label` | Label on the picker button; defaults to the plugin name. |
| …plus each plugin's `configForm()` fields | (plugin-specific, below) | Provider credentials/options. |

Provider-specific keys written by each plugin's `submitConfigForm()`/`setSetting()`:

| Plugin id | State keys it stores |
|---|---|
| `dropbox_chooser` | `dropbox_chooser` (Dropbox App Key) |
| `box_picker` | `box_picker` (Box Client ID) |
| `onedrive_picker` | `onedrive_picker` (Application/client ID) |
| `google_drive` | `client_id`, `app_id`, `view_id`, `view_type`, `scope`, `mine_only`, `nav_hidden`, `support_drives` (and `developer_key`) |

These identifiers are the browser-side app/client IDs each vendor SDK needs; the
picker dialogs and OAuth run entirely in the visitor's browser using the vendor JS
(`js/dropbox.js`, `js/google.js`, `js/onedrive.js`, `js/box.js`).

## Set values from code (State)

```php
$state = \Drupal::state();
$info = $state->get('external_media.info', []);
$info['dropbox_chooser']['enabled'] = 1;
$info['dropbox_chooser']['button_label'] = 'From Dropbox';
$info['dropbox_chooser']['dropbox_chooser'] = 'YOUR_DROPBOX_APP_KEY';
$state->set('external_media.info', $info);
// Or via a plugin instance (also invalidates the emw:<id> cache tag):
$plugin = \Drupal::service('plugin.manager.external_media')->createInstance('dropbox_chooser');
$plugin->setSetting('enabled', 1)->setSetting('button_label', 'From Dropbox');
```

Drush equivalent for a single scalar:
`drush state:set external_media.info '{"dropbox_chooser":{"enabled":1}}' --input-format=json`
(overwrites the whole array — prefer the PHP snippet to merge).

## Runtime notes

- `ExternalMediaBase::setSetting()`/`setSettings()` write State and invalidate the
  cache tag `emw:<plugin_id>`.
- The "Redirect URL" shown on a service tab (when the plugin's `setRedirectCallback()`
  returns non-empty — Google Drive, OneDrive) is `external_media.redirect_callback`
  built by `getRedirectUrl()`; it is the URL you register as the OAuth/redirect URI in
  the vendor's app console.
- Per-field widget options (button style, visible services, preview image style) are
  separate from this page — see [../fields/widgets.md](../fields/widgets.md).
