<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Responsive video style field formatter

`src/Plugin/Field/FieldFormatter/ResponsiveVideoStyleFormatter.php` — formatter id
**`responsive_video_style`**, label "Responsive video style", `field_types: ['file']`.

## Applicability

`isApplicable()` delegates to
`VideoFormatterApplicability::appliesToSingleValueMediaVideoSourceField($field_definition)` (from the
base `video_style` module). In practice it only offers itself on a **single-value media video source
field** (the file reference that a Media video bundle uses as its source), not every `file` field.

## Settings

One setting: `responsive_video_style` (default `''`) — the Responsive video style config entity ID.
`settingsForm()` renders a required `select` of all `responsive_video_style` entities (sorted by
label). If none exist yet it shows a hidden element plus an `item` with a link to the Responsive
video styles collection. `settingsSummary()` prints `Responsive video style: <label|None>`.

## What it renders (`viewElements`)

1. Bails early (returns `[]`) when the field item list is not an entity-reference list, no style is
   configured, the style can't be loaded, or no referenced `FileInterface` is found
   (`extractReferencedFile()` reads `items->first()->entity`).
2. Calls `responsive_video_style.builder`
   `buildRenderData($file, $style, $baseVideoAttributes)` — base `<video>` attributes are passed only
   for the `source` strategy (`getBaseVideoAttributes()`); `variant` carries per-variant attributes.
3. Bails if render data is empty, or if the strategy is `source` with no `sources`, or `variant`
   with no `variants`.
4. Builds the render element:
   - `variant` strategy → `#theme => 'responsive_video_style_variants'` with `#variants`,
     `#fallback_text`, and attaches the `responsive_video_style/frontend` library (client-side
     variant switching).
   - `source` strategy → `#theme => 'responsive_video_style'` with `#sources`, `#attributes` (from
     `$style->getVideoTagAttributes($posterUrl)`), `#fallback_text`.
5. Applies cacheability: the file, the responsive style, `render_data['cache_tags']`, and the
   builder's returned `cacheability` object. (The builder also adds `url.site`, `breakpoints`, the
   `video_style` list cache tags, and per-asset tags.)

See [../theming/templates.md](../theming/templates.md) for the markup and
[../api/builder.md](../api/builder.md) for how sources/variants are composed. There is no custom
widget — the field uses its normal file/media widget; this module only adds the display formatter.
