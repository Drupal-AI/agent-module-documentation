<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Video Embed Field Plyr (video_embed_field_plyr) — agent index

Two field formatters that render video through the bundled **Plyr.js** player instead of the
provider's default embed. Package `Media`. Core `^9 || ^10 || ^11`. PHP `>=7.4`. License
GPL-2.0-or-later. Version **2.0.0-rc2** (release candidate). No routes, no permissions, no
services, no config objects, no Drush, no submodules.

- **Both formatters, every setting, the Plyr libraries, and the Twig templates** →
  [fields/formatters.md](fields/formatters.md)

## What it actually is (from source)

Two `FormatterBase` plugins in `src/Plugin/Field/FieldFormatter/`, both using the shared trait
`PlyrSharedTrait`:

- **`PlyrEmbed`** — formatter id **`video_embed_field_plyr`**, label *"Video (plyr)"*,
  `field_types = { "video_embed_field" }`. Injects
  `video_embed_field.provider_manager`; `viewElements()` calls
  `loadProviderFromInput()`, `getIdFromInput()` and `renderEmbedCode(1920,1080,FALSE)` on the
  video_embed_field provider, then themes `video_embed_plyr`.
- **`PlyrOembed`** — formatter id **`video_oembed_field_plyr`**, label *"oEmbed Video Plyr"*,
  `field_types = { "link", "string", "string_long" }`. `isApplicable()` restricts it to fields
  on a **Media** bundle whose source is an `OEmbedInterface`. Uses core services
  `media.oembed.url_resolver`, `media.oembed.resource_fetcher`, `media.oembed.iframe_url_helper`
  and `media.settings`; only accepts `Resource::TYPE_VIDEO`; themes `video_oembed_plyr`.

## Dependencies (undeclared — read carefully)

The `.info.yml` declares **no `dependencies:`**. But by code:

- `PlyrEmbed` requires the contrib **`video_embed_field`** module (its field type + provider
  manager service) — the formatter cannot load without it.
- `PlyrOembed` requires core **`media`** (oEmbed source, resolver, fetcher, iframe helper).

So `dependent_modules` is `[]` in the manifest, but the embed formatter needs `video_embed_field`
enabled and the oEmbed formatter needs `media` enabled.

## Theme / libraries

- `hook_theme()` in `video_embed_field_plyr.module` registers `video_embed_plyr` and
  `video_oembed_plyr`; theme-suggestion hooks add provider-specific and background-specific
  suggestions (`…__youtube`, `…__background`, `…__background__youtube`).
- Libraries in `video_embed_field_plyr.libraries.yml`: `plyr-styles`, `modern`, `polyfilled`,
  `rangetouch`, `drupal`. **Plyr 3.7.8 + RangeTouch 2.0.1 are bundled in `assets/plyr/` and
  served locally** — the `remote:` cdn.plyr.io keys are Drupal library attribution metadata, not
  the served source.

## Configuration

- **No config object and no config schema** (there is no `config/` directory). All options are
  per-field-display formatter settings from `PlyrSharedTrait::defaultSettings()` — see
  [fields/formatters.md](fields/formatters.md).
