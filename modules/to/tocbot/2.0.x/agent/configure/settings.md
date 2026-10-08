# Tocbot settings (config `tocbot.settings`)

- **UI:** `/admin/config/content/tocbot` (route `tocbot.settings`, form
  `Drupal\tocbot\Form\SettingsForm`, permission *administer site configuration*).
- **Config object:** `tocbot.settings`. Keys are snake_case; the block maps each to the matching
  camelCase Tocbot API option (see `TocbotHelper::$settingsOptions`). No config schema ships, so
  values are stored untyped (numbers are kept as strings, e.g. `min_activate: '3'`).
- **Drush:** `drush config:set tocbot.settings <key> <value>` / `drush config:get tocbot.settings`.

## Module-behavior keys

| Key | Tocbot option | Default | Purpose |
|---|---|---|---|
| `extra_body_class` | extraBodyClass | `toc-is-active` | CSS class added to `<body>` when the TOC activates (blank = none). |
| `min_activate` | minActivate | `'3'` | Only build the TOC when the page has **≥ this many** matching headings. |
| `create_auto_ids` | createAutoIds | `1` | If on, JS slugs each heading's text into an `id` so anchors work without another module. |

## Core Tocbot API keys (selectors)

| Key | Tocbot option | Default | Purpose |
|---|---|---|---|
| `toc_selector` | tocSelector | `.js-toc-block` | Where the TOC is rendered (the block outputs this element). |
| `content_selector` | contentSelector | `#content` | Container scanned for headings. **Must match your theme's content wrapper.** |
| `heading_selector` | headingSelector | `h2, h3, h4, h5, h6` | Which headings become entries. |
| `ignore_selector` | ignoreSelector | `.visually-hidden` | Headings matching this are skipped. |
| `has_inner_containers` | hasInnerContainers | `0` | For headings inside positioned inner wrappers. |

## List / class keys

`link_class` (linkClass `toc-link`), `extra_link_classes`, `active_link_class`
(`is-active-link`), `list_class` (`toc-list`), `extra_list_classes`, `is_collapsed_class`
(`is-collapsed`), `collapsible_class` (`is-collapsible`), `list_item_class` (`toc-list-item`),
`collapse_depth` (collapseDepth `0`), `ordered_list` (orderedList `0` → set truthy for `<ol>`).

## Scroll / position keys

`scroll_smooth` (`1`), `scroll_smooth_duration` (`420`), `scroll_smooth_offset` (`0`),
`headings_offset` (`1`), `throttle_timeout` (`50`), `position_fixed_selector` (`.js-toc-block`),
`position_fixed_class` (`is-position-fixed`), `fixed_sidebar_offset` (`auto`).

> Note: the settings form also renders an `includeHtml` checkbox, but `includeHtml` is **not** in
> `TocbotHelper::getSettingsOptions()`, so it is **not** saved to config or passed to Tocbot — a
> known quirk; changing it has no effect.

## CDN vs local library

`TocbotHelper::getLibrary()` returns `tocbot/internal.tocbot` when both
`/libraries/tocbot/dist/tocbot.min.js` and `/libraries/tocbot/dist/tocbot.css` exist on disk;
otherwise `tocbot/external.tocbot` (CDN `cdnjs.cloudflare.com/.../tocbot/4.32.2/`). Drop the library
files in `web/libraries/tocbot/dist/` to serve them locally (offline / stricter CSP).
