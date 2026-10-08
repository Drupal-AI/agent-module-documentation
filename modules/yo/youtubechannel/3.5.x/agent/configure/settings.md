<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Youtube Channel settings

**Route:** `youtubechannel.settings` → `/admin/config/services/youtubechannel`
**Permission:** `administer site configuration` (core; no module-specific permission).
**Form:** `Drupal\youtubechannel\YoutubechannelSettingsForm` (`src/YoutubechannelSettingsForm.php`),
form id `youtubechannel_admin_settings`, a `ConfigFormBase`.
**Config object:** `youtubechannel.settings` (the form's only editable config name).

There is no `config/install` file and no `config/schema` — the object does not exist until
the form is saved once, and all five fields are marked `#required`, so the first save must
supply every value.

## Fields

| Config key | Form title | Type | Default (form fallback) | Notes |
|---|---|---|---|---|
| `youtubechannel_api_key` | Youtube Google API Key | textfield | `""` | Server-side Google API key for the YouTube Data API v3. |
| `youtubechannel_id` | Youtube Channel ID | textfield | `""` | The channel's `UC…` id (from the channel URL), not the human username. |
| `youtubechannel_video_limit` | Youtube Channel video limit | textfield | `5` | Number of videos to list; YouTube caps `maxResults` at 50. Becomes `maxResults` on the playlist call. |
| `youtubechannel_video_width` | Youtube Channel video width | textfield | `200` | Player/list width in px; printed as `#plain_text` into the block markup. |
| `youtubechannel_video_height` | Youtube Channel video height | textfield | `150` | Player/list height in px; printed as `#plain_text` into the block markup. |

The defaults above are the form's `#default_value` fallbacks when a key is empty; they are
not persisted until you save. `submitForm()` writes all five keys back to
`youtubechannel.settings` in one `->save()`.

## Set via Drush

```bash
drush config:set youtubechannel.settings youtubechannel_id UCxxxxxxxxxxxxxxxxxxxxxx -y
drush config:set youtubechannel.settings youtubechannel_video_limit 8 -y
# Keep the API key out of config exports — set it, then exclude/scrub as your workflow requires:
drush config:set youtubechannel.settings youtubechannel_api_key "$YOUTUBE_API_KEY" -y
```

## Set via PHP

```php
\Drupal::configFactory()->getEditable('youtubechannel.settings')
  ->set('youtubechannel_api_key', getenv('YOUTUBE_API_KEY'))
  ->set('youtubechannel_id', 'UCxxxxxxxxxxxxxxxxxxxxxx')
  ->set('youtubechannel_video_limit', 8)
  ->set('youtubechannel_video_width', 320)
  ->set('youtubechannel_video_height', 240)
  ->save();
```

Per this repo's convention the API key value belongs in an environment variable (e.g. via
`ddev dotenv set`) and should be injected rather than hard-coded into a committed config
export.

## After changing settings

The block content is built from the theme registry (see
[../blocks/youtubechannel-block.md](../blocks/youtubechannel-block.md)), so a settings
change is only reflected after a cache rebuild: `drush cr`.
