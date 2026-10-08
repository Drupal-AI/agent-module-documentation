# Settings

Route `flush_single_image.settings.form` → `/admin/config/flush-single-image/settings`
(this is the module's `configure` link; also linked under Configuration » Content authoring).
Form: `Drupal\flush_single_image\Form\FlushSingleImageSettingsForm` (`ConfigFormBase`).
Permission: `administer flush_single_image`.

## Config object: `flush_single_image.settings`

| Key | Type | Meaning |
|---|---|---|
| `media_image_types` | map | Which `media_type` bundles the module treats as images. Value per key is the media-type id when enabled, or `0` when disabled. |

The form renders a required "Media image types" checkboxes element listing every `media_type`
entity; the submit handler saves the checked ids back into `media_image_types`. These types drive
the `hook_form_alter` widget on media edit forms (see [hooks/form-alter.md](../hooks/form-alter.md)).

Default install config (`config/install/flush_single_image.settings.yml`):

```yaml
media_image_types:
  image: image
  audio: 0
  document: 0
  remote_video: 0
  video: 0
```

Note: the module ships **no `config/schema/`**, so this config object is not schema-typed.

### Set via Drush / PHP

```bash
drush config:set flush_single_image.settings media_image_types.image image -y
```

```php
\Drupal::configFactory()->getEditable('flush_single_image.settings')
  ->set('media_image_types', ['image' => 'image', 'photo' => 'photo'])
  ->save();
```

## Configurable action defaults

The bulk **action** plugin `flush_single_image_action` is an installed config action
(`system.action.flush_single_image_action`, type `media`). Its default flush behavior (Unlink vs
Regenerate) is set at `/admin/config/system/actions/configure/flush_single_image_action`
(config key `fsi_action`). See [plugins/action.md](../plugins/action.md).
