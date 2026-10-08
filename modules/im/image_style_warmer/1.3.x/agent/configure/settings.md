<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure which image styles are warmed

Config object: **`image_style_warmer.settings`** (schema `config_object`). Two keys, each a
map of `image_style_id => image_style_id` (checkbox values from the settings form):

```yaml
initial_image_styles:    # generated synchronously at end of the request (service destruct())
  thumbnail: thumbnail
  medium: medium
queue_image_styles:      # generated later by the cron QueueWorker
  large: large
```

Empty defaults ship in `config/install/image_style_warmer.settings.yml` (`{ }` for both).

## UI

Route `image_style_warmer.settings` → `/admin/config/development/performance/image-style-warmer`
(link is under *Configuration › Development › Performance*). Requires permission
**`administer site configuration`**. The form (`ImageStyleWarmerSettingsForm`) shows two
checkbox groups built from `image_style_options(FALSE)`:

- **Initial image styles** → saved to `initial_image_styles`. Created immediately when a file
  is saved (upload/update), in the same request.
- **Queue image styles** → saved to `queue_image_styles`. Queued to
  `image_style_warmer_pregenerator` and created on the next cron run.

The submit handler stores only the checked styles (`array_filter`), so unchecked styles are
removed from the list.

## Scriptable (drush)

```bash
# Read current config
drush cget image_style_warmer.settings

# Set initial styles to thumbnail + medium, queue style to large
drush cset -y image_style_warmer.settings initial_image_styles.thumbnail thumbnail
drush cset -y image_style_warmer.settings initial_image_styles.medium medium
drush cset -y image_style_warmer.settings queue_image_styles.large large
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('image_style_warmer.settings')
  ->set('initial_image_styles', ['thumbnail' => 'thumbnail', 'medium' => 'medium'])
  ->set('queue_image_styles', ['large' => 'large'])
  ->save();
```

## Behaviour notes

- Scope is **site-wide**: the lists apply to every permanent image file, not per field.
- Only **permanent** files that validate as images are warmed (temporary files are skipped).
- Generation is **idempotent** — a derivative that already exists on disk is not rebuilt.
- On uninstall the module deletes the `image_style_warmer_pregenerator` queue; on install it
  sets the module weight to 10 so its file hooks run after other modules'.
