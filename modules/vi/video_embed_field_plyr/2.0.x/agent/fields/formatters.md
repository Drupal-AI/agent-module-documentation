<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two Plyr formatters

## Install & enable

```bash
composer require drupal/video_embed_field_plyr
drush en video_embed_field_plyr -y
```

The `.info.yml` declares **no dependencies**, so Drupal will not pull anything in for you. In
practice:

- to use **`video_embed_field_plyr`** ("Video (plyr)") you must also have contrib
  **`video_embed_field`** enabled (it provides the `video_embed_field` field type and the
  `video_embed_field.provider_manager` service the formatter injects);
- to use **`video_oembed_field_plyr`** ("oEmbed Video Plyr") you must have core **`media`**
  enabled and a Media type with an oEmbed (Remote video) source.

No permissions, no routes, no Drush commands, no config objects of its own.

## Formatter 1 — PlyrEmbed (Video Embed Field)

`src/Plugin/Field/FieldFormatter/PlyrEmbed.php`, id **`video_embed_field_plyr`**,
`field_types = { "video_embed_field" }`.

`viewElements()` per delta:

1. `$provider = $this->providerManager->loadProviderFromInput($item->value)` — resolves the
   video_embed_field provider (YouTube/Vimeo) from the stored URL. If none, renders
   `#theme => 'video_embed_field_missing_provider'`.
2. `$embedCode = $provider->renderEmbedCode(1920, 1080, FALSE)` — the max width/height are
   hard-coded (a `// Should this be configurable?` note).
3. Builds `#theme => 'video_embed_plyr'` with `#videoId => $provider::getIdFromInput($item->value)`,
   `#url`, `#provider`, and `#attributes` (`allow="autoplay"`, a `Html::getUniqueId()` id, class
   `video-embed-field-plyr`).
4. `attachPlyrLibraries()` (see below).

The **video id and provider are extracted by the video_embed_field provider plugins**, not by this
module. Output is placed into HTML attributes in `templates/video-embed-plyr.html.twig`, so Twig
auto-escapes it.

## Formatter 2 — PlyrOembed (core oEmbed)

`src/Plugin/Field/FieldFormatter/PlyrOembed.php`, id **`video_oembed_field_plyr`**,
`field_types = { "link", "string", "string_long" }`.

`isApplicable()` returns TRUE only when the field's target entity type is **`media`** and the
media bundle's source implements `OEmbedInterface` — so this formatter shows up only on the oEmbed
URL field of a Remote-video media type.

`viewElements()` per delta:

1. Reads the field's main-property value as `$iframeURL`; skips empty values.
2. `max_width = 1920`, `max_height = 1080` (hard-coded).
3. `$this->urlResolver->getResourceUrl($iframeURL, …)` then
   `$this->resourceFetcher->fetchResource(...)` — core's oEmbed resolver/fetcher (validates the
   URL against the registered provider list). `ResourceException` → logs to the `media` channel
   and skips.
4. Non-video resources → `"@url is not a supported video source."` markup, skipped.
5. For **vimeo/youtube** providers it re-parses the iframe `src` out of `$resource->getHtml()`
   via `parseUrlFromIframeSource()` (adds `autoplay=1&background=1&mute=1` query params when
   background mode is on).
6. If `media.settings:iframe_domain` is set, the iframe `src` is routed through the core
   **`media.oembed_iframe`** proxy route with a validated `getHash()` (core's isolation). If it
   is not set, the provider iframe URL is used directly.
7. Builds `#theme => 'video_oembed_plyr'` with a `#type => html_tag` **iframe** (`frameborder=0`,
   `scrolling=FALSE`, `allow="autoplay"`, width/height from the resource), `#provider`, and
   `#attributes`. Applies `CacheableMetadata` from the resource + `media.settings` cache tags.

## Shared behaviour — PlyrSharedTrait

`src/Plugin/Field/FieldFormatter/PlyrSharedTrait.php` supplies `defaultSettings()`,
`settingsForm()`, `settingsSummary()`, and the render helpers for both formatters.

### `attachPlyrLibraries($element, $delta)`

- Sets `#plyr_settings` = `buildPlyrDrupalSettings($provider)` (the JSON config the template emits
  into `data-plyr-config`).
- Always attaches `…/video_embed_field_plyr.plyr-styles` and `…/video_embed_field_plyr.drupal`.
- Attaches `…polyfilled` if `advanced.polyfilled`, else `…modern` (the Plyr JS build).
- Attaches `…rangetouch` if `advanced.rangetouch`.

### Building the Plyr config

- `buildDefaultPlyrSettings()` — iterates the formatter settings; the `controls` fieldset is
  flattened to an array of the enabled button names; each other truthy scalar setting becomes
  `true`; adds `youtube => {noCookie}` (`youtubeNoCookie()`).
- `buildBackgroundPlyrSettings()` (when `advanced.background` is on) — forces `background=true`,
  `clickToPlay=false`, `hideControls=true`, empty `controls`, `autoplay/muted/loop`,
  `volume=0`, keyboard focus/global off, etc.

### `defaultSettings()`

```php
'autoplay'    => FALSE,
'loop'        => FALSE,
'resetOnEnd'  => TRUE,
'hideControls'=> TRUE,
'controls' => [
  'play-large' => FALSE, 'play' => TRUE, 'restart' => FALSE, 'fast-forward' => FALSE,
  'progress' => TRUE, 'current-time' => TRUE, 'duration' => FALSE, 'mute' => TRUE,
  'volume' => TRUE, 'settings' => TRUE, 'captions' => FALSE, 'airplay' => FALSE,
  'fullscreen' => TRUE, 'pip' => FALSE,
],
'advanced' => [ 'polyfilled' => FALSE, 'rangetouch' => TRUE, 'background' => FALSE ],
'youtube'  => [ 'noCookie' => FALSE ],
```

### Settings form fields

`settingsForm()` renders checkboxes for `autoplay`, `loop`, `resetOnEnd`, `hideControls`; a
**Plyr Controls** fieldset (play, play-large, restart, fast-forward, mute, airplay, pip,
fullscreen, progress, volume, current-time, duration, settings); an **Advanced** fieldset
(background playback, IE11 polyfilled build, RangeTouch); and a **YouTube** fieldset (no-cookie
player). `settingsSummary()` prints the active globals + enabled controls (or "Background playback
mode / Disabled" when background is on).

There is **no config schema** for these settings (no `config/` directory), so strict config-schema
tooling may flag the view-display config even though it saves and works.

## Libraries (`video_embed_field_plyr.libraries.yml`)

| Library | Contents | Source |
|---|---|---|
| `plyr-styles` | `assets/plyr/plyr.css` | bundled (attrib. cdn.plyr.io 3.7.8, MIT) |
| `modern` | `assets/plyr/plyr.min.js` | bundled Plyr 3.7.8 JS |
| `polyfilled` | `assets/plyr/plyr.polyfilled.min.js` | bundled IE11 build |
| `rangetouch` | `assets/plyr/rangetouch.min.js` | bundled RangeTouch 2.0.1, MIT |
| `drupal` | `assets/drupal.video-embed-field-plyr.js` | this module's initializer |

**All served locally from `assets/plyr/`.** Each library's `remote:` cdn.plyr.io / github URL is
Drupal's required attribution for a vendored external asset — it is not fetched at runtime.

`assets/drupal.video-embed-field-plyr.js` (`Drupal.behaviors.videoEmbedFieldPlyr`) selects every
`[data-plyr-config]` element, ensures it has an id, and runs `new Plyr(element)`, keeping the
instances in `Drupal.plyrInstances`.

## Templates & theme suggestions

- `templates/video-embed-plyr.html.twig` — outer `<div {{ attributes }}>` wrapping a
  `<div data-plyr-provider data-plyr-embed-id data-plyr-config>` (embed mode, old Plyr setup).
- `templates/video-oembed-plyr.html.twig` — `<div {{ attributes }} data-plyr-config>` containing
  the rendered `{{ iframe }}` (progressive-enhancement mode).
- Both emit `data-plyr-config="{{ plyr_settings|json_encode }}"`; both carry a comment showing how
  to `merge` extra Plyr options (e.g. a local `blankVideo`, `loadSprite:false`) in a theme
  override.
- Suggestions (`video_embed_field_plyr.module`): `video_embed_plyr__<provider>` and, when
  background mode is on, `…__background` and `…__background__<provider>` (same pattern for the
  oembed template).

## Enable it on a field (config equivalent)

```bash
# Video Embed Field type field on a node:
drush cset core.entity_view_display.node.article.default \
  content.field_video.type video_embed_field_plyr -y

# oEmbed URL field on a Remote-video media type:
drush cset core.entity_view_display.media.remote_video.default \
  content.field_media_oembed_video.type video_oembed_field_plyr -y
drush cr
```

## Notes / caveats

- Only **YouTube and Vimeo** are handled in practice; self-hosted MP4 is not implemented despite
  Plyr supporting it.
- `max_width`/`max_height` are hard-coded to 1920×1080 in both formatters.
- Background mode is described in the source as best-effort ("as much as Vimeo or YouTube allows")
  and was primarily tested on the oEmbed template.
- The release is **2.0.0-rc2**, a release candidate.
