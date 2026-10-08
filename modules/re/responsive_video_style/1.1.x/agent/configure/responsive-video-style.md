<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a Responsive video style

Admin listing lives at `/admin/config/media/video-styles/responsive` (route
`entity.responsive_video_style.collection`, the module's `configure` link), nested under the base
Video Style section as a menu child and local task of `entity.video_style.collection`. Everything
here requires the `administer responsive video styles` permission.

Prerequisite: create the Video styles first at `/admin/config/media/video-styles` (base Video Style
module). A Responsive video style only *references* existing Video styles.

## Create / edit form (`src/Form/ResponsiveVideoStyleForm.php`)

Add at `…/responsive/add`, edit at `…/responsive/{responsive_video_style}`, delete at
`…/responsive/{responsive_video_style}/delete` (core `EntityDeleteForm`). The form is heavily AJAX
driven; the mappings UI rebuilds when the breakpoint group or strategy changes.

1. **Label** + **machine name** (`id`, locked after creation).
2. **Breakpoint group** (`breakpoint_group`) — any registered breakpoint group; the bundled
   **Responsive Video** group is available by default. Changing the group clears existing mappings.
   A stored-but-now-missing group stays selectable, labelled `@group (missing breakpoint group)`.
3. **Responsive strategy** (`responsive_strategy`), required:
   - **Multiple sources in one video** = `source` — for providers (e.g. ImageKit) that deliver true
     alternate source URLs/derivatives in one `<video>`.
   - **Separate video variants by breakpoint** = `variant` — for providers (e.g. local file) where
     the style mainly changes player-level rendering, not the media file.
4. **Breakpoint mappings** — per breakpoint of the chosen group, add one or more Video styles
   (`video_style_mappings`, each `{breakpoint_id, video_style, weight}`). Ordered by breakpoint
   weight then style weight (tabledrag).
5. **Fallback sources/variants** (`fallback_video_styles`, each `{video_style, weight}`) — used when
   no breakpoint matches. **At least one fallback is required** (validation error otherwise).

### `source`-strategy only (one shared `<video>`)

The form shows extra sections (hidden for `variant`, where each variant carries its own player
settings):

- **Dimensions**: `width`, `height` (pixels; 0/empty = omit the attribute).
- **Poster image settings**: informational — the rendered video uses **one** shared poster, taken
  from the configured fallback styles first, then mapped styles in order until one is found.
- **`<video>` tag settings** (`video_tag_settings`): `controls` (default on), `autoplay`, `loop`,
  `muted`, `playsinline`, `preload` (`none`|`metadata`|`auto`, default `metadata`), and
  **Fallback text** (empty = default translatable "Your browser does not support the video tag.").

## Validation rules (`validateForm`)

- A strategy must be selected; at least one fallback is required.
- **All selected Video styles must match the chosen responsive strategy** (each provider's
  `getResponsiveStrategy()`), and **all must use the same render mode** (`getRenderMode()`).
- A non-`native` (provider-rendered) render mode **requires the `variant` strategy**.
- For `variant`: only **one** Video style per breakpoint and only **one** fallback style.

## Stored shape (schema `responsive_video_style.schema.yml`)

`video_tag_settings` (mapping of the booleans + `width`/`height` int + `preload` string +
`fallback_text` text), `fallback_video_styles` (sequence of `{video_style, weight}`), and
`video_style_mappings` (sequence of `{breakpoint_id, video_style, weight}`). `Entity` normalizes
tag settings (`preload` constrained to the three values; width/height clamped to ≥0) and recomputes
config dependencies for the breakpoint group's providers and every referenced Video style
(`ResponsiveVideoStyleSupport::calculateDependencies`).

Any save/delete/rename of a `responsive_video_style.*` config object invalidates the
`video_style_delivery` cache tag — see [../api/builder.md](../api/builder.md).

After creating a style, attach it to a field display — see [../fields/formatter.md](../fields/formatter.md).
