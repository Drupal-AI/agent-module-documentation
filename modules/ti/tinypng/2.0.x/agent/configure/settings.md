<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure TinyPNG

## Settings form

Route `tinypng.settings.form` → `/admin/config/tinypng` (under *Configuration → Media*).
Permission: **`administer tynipng`** (literal id, misspelled in the module). Form
`Drupal\tinypng\Form\SettingsForm` edits the `tinypng.settings` config object.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | TinyPNG/Tinify API key (required to compress anything; get at tinypng.com/developers) |
| `on_upload` | bool | `0` | compress **every** uploaded image on entity presave |
| `upload_method` | select | `upload` | `upload` = send bytes to TinyPNG (works on localhost); `download` = TinyPNG fetches the image by public URL (needs an internet-reachable site). Only relevant when `on_upload` is on. |
| `image_action` | bool | `1` | expose the per-image-style "Compress with TinyPNG" checkbox |

Read/write from drush:

```bash
drush cget tinypng.settings
drush cset tinypng.settings on_upload 1 -y
drush cset tinypng.settings upload_method download -y
```

```php
\Drupal::configFactory()->getEditable('tinypng.settings')
  ->set('api_key', 'YOUR_KEY')->set('on_upload', TRUE)
  ->set('upload_method', 'download')->set('image_action', TRUE)->save();
```

(There is no config schema entry for `tinypng.settings` itself; only the image-style
third-party mapping below is schema-defined.)

## Compress a specific image style's derivatives

When `image_action` is on **and** `api_key` is set, the image-style edit form
(`/admin/config/media/image-styles/manage/<style>`) shows a **"Compress with TinyPNG"**
checkbox (added by `tinypng_form_image_style_edit_form_alter()`). Ticking it stores:

```yaml
# image.style.<style>.third_party.tinypng
tinypng_compress: true
```

Schema: `image.style.*.third_party.tinypng` → `tinypng_compress` (boolean).

Set it programmatically:

```php
use Drupal\image\Entity\ImageStyle;
$style = ImageStyle::load('large');
$style->setThirdPartySetting('tinypng', 'tinypng_compress', TRUE);
$style->save();
// read: $style->getThirdPartySetting('tinypng', 'tinypng_compress');
// clear: $style->unsetThirdPartySetting('tinypng', 'tinypng_compress');
```

A route subscriber (`tinypng.route_subscriber`) overrides the image-style derivative
download route so flagged styles are compressed through TinyPNG as derivatives are generated
(`TinyPngImageStyleDownloadController`).

## Two ways to compress

1. **On upload** (`on_upload = 1`): `hook_entity_presave()` runs uploaded images through the
   `tinypng.image_handler` service — every image file is compressed once when saved.
2. **Per image style** (`tinypng_compress` on the style): only that style's generated
   derivatives are compressed, leaving the original untouched.

Both require a valid `api_key`; with an empty key nothing is sent to TinyPNG.
