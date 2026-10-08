# Configure the VVJS Views format

No admin settings page. Configuration is entirely the Views **style (Format) options** of the
`views_vvjs` plugin.

## Enable it on a View

1. Create/edit a View. Set **Format** → *Views Vanilla JavaScript Slideshow*.
2. Set **Show** → *Fields* (each row = one slide).
3. For **hero mode**, the first field is the hero background; put a
   `<div class="vvjs-separator"></div>` field between background and overlay content.
4. Open the format settings and configure the options below. Save.

Config is stored on the View display as `display_options.style: { type: views_vvjs, options: {…} }`;
schema is `views.style.views_vvjs`.

## Option reference (schema `config/schema/vvjs.schema.yml`)

| Key | Type / allowed | Meaning |
|---|---|---|
| `time_in_seconds` | int (ms) | Autoplay interval; `0` disables autoplay. |
| `enable_looping` | bool | Loop back to the first slide after the last. |
| `start_index` | int ≥ 1 | Which slide shows first. |
| `arrows` | `none` / `arrows-sides` / `arrows-sides-big` / `arrows-top` / `arrows-top-big` | Prev/next arrow placement. |
| `navigation` | `none` / `dots` / `numbers` | Bottom navigation style. |
| `scrollable_dots_width` | int 0–700 (px) | Width for scrollable dots/numbers (many slides). |
| `animation` | `none` / `a-zoom` / `a-fade` / `a-top` / `a-bottom` / `a-left` / `a-right` | Slide entrance animation (7 presets). |
| `transition_type` | `instant` / `crossfade-classic` / `crossfade-staged` / `crossfade-dynamic` | How one slide replaces the next. |
| `transition_duration` | int 200–2000 (ms) | Crossfade duration. |
| `show_play_pause` | bool | Show play/pause button. |
| `show_slide_progress` | bool | Show the RAF progress bar. |
| `show_total_slides` | bool | Show the "X of Y" counter. |
| `pause_on_hover` | bool | Pause autoplay on mouse hover. |
| `enable_swipe` | bool | Touch/pointer swipe (RTL-aware). |
| `enable_keyboard` | bool | Arrow / Space / Home / End keys. |
| `enable_deeplink` | bool | Shareable per-slide URL hash (needs dots or numbers). |
| `deeplink_identifier` | string | Hash prefix, e.g. `gallery` → `#gallery-3` (auto-lowercased, spaces→hyphens; reserved words rejected). |
| `hero_slideshow` | bool | Enable hero mode (first field = background). |
| `overlay_position` | `d-full`, `d-middle`, `d-left`, `d-right`, `d-top`, `d-bottom`, `d-top-left`, `d-top-right`, `d-bottom-left`, `d-bottom-right`, `d-top-middle`, `d-bottom-middle` | Hero overlay placement (12 options). |
| `overlay_bg_color` | hex `#RRGGBB` | Hero overlay color. |
| `overlay_bg_opacity` | float 0–1 | Hero overlay opacity. |
| `min_height` | int 1–200 (vw) | Slideshow minimum height. |
| `max_content_width` | int 1–100 (%) | Max content width. |
| `max_width` | int 1–9999 (px) | Max slideshow width. |
| `available_breakpoints` | one of `576`/`768`/`992`/`1200`/`1400` | Responsive breakpoint set to load. |
| `enable_css` | bool | Load the bundled CSS library; disable to fully self-theme. |
| `unique_id` | int | Internal per-instance identifier (auto). |

Defaults come from `VvjsConstants` in `definePatternOptions()` (e.g. navigation defaults to dots). The
`animation`/`arrows`/`navigation`/`overlay_position`/`transition_type` values are validated by the schema
`Choice` constraints above; hex color and opacity by `Regex`/`Range`.

## Tokens in Views text areas

In a header/footer/empty text area with **Use replacement tokens from the first row**, Twig tokens like
`{{ title }}` do not work — use `[vvjs:field]` / `[vvjs:field:plain]` instead (first row only). See
[../api/js.md](../api/js.md).
