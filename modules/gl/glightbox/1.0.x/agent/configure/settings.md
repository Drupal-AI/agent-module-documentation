<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global GLightbox settings

Form route **`glightbox.admin_settings`** at **`/admin/config/media/glightbox`** (permission
`administer site configuration`), writing the config object **`glightbox.settings`**.

## Config groups

```yaml
# glightbox.settings (defaults shown)
custom:
  activate: 0
  open_effect: zoom          # zoom | fade | none
  close_effect: zoom
  slide_effect: slide        # slide | fade | zoom | none
  width: '98%'
  height: '98%'
  videosWidth: '960px'
  close_on_outside_click: true
  more_text: 'See more'
  more_length: 60            # caption chars before "See more" truncation
  desc_position: bottom      # bottom | top | left | right
  loop: false
  zoomable: true
  draggable: true
  preload: true
  autoplay_videos: true
  autofocus_videos: false
advanced:
  unique_token: 0            # give each entity a unique gallery id
  compression_type: minified # minified | source
plyr:
  enabled: true
  controls: "['play-large','play','progress','current-time','mute','volume','captions','settings','pip','airplay','fullscreen']"
  settings: "['captions','quality','speed','loop']"
  # …many more Plyr options (ratio, seek_time, volume, muted, blank_video, icon_url, …)
```

Read/set:

```bash
drush cget glightbox.settings custom
drush cget glightbox.settings custom.width
# set via the form, or:
drush cset glightbox.settings custom.loop 1 -y
```

Note: booleans set with bare `true`/`false` via `drush cset` can be miscast (a non-empty string is
truthy). Prefer `1`/`0`, the settings form, or the config API for boolean keys.

## Disabling per request

The `glightbox.activation_check` service returns inactive when the request has `?glightbox=no`, so
appending `?glightbox=no` to a URL renders the images without wiring up the lightbox.

## Libraries

`glightbox.attachment` attaches the assets and, via `hook_library_info_alter()`, prefers locally
installed libraries under `/libraries` (GLightbox, DOM Purify, Plyr) over the CDN. Install the
`levmyshkin/glightbox`, `levmyshkin/dom_purify`, and `levmyshkin/plyr` packages (or drop the
libraries into `/libraries`) for it to work.
