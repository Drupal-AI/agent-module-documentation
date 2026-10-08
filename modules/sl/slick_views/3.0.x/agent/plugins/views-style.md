# Slick Views style plugins

Two `@ViewsStyle` plugins (in `src/Plugin/views/style/`):

| id | Label | Class |
|---|---|---|
| `slick` | Slick Carousel | `SlickViews` |
| `slick_grouping` | Slick Grouping | `SlickGrouping` |

Both extend `SlickViewsBase`. They are **not** new plugin *types* — they implement core Views'
style plugin type, so they show up in a View display's **Format** picker.

## Use it (Views UI)
1. Create/edit a View, add a display.
2. **Format → Settings** → choose *Slick Carousel* (or *Slick Grouping*).
3. In the style settings pick a Slick **Optionset** (defined at the Slick module's
   `/admin/config/media/slick`) — this drives slides-to-show, autoplay, arrows, dots,
   breakpoints, lazy load, etc.
4. Optionally set an **image/media field**, a **caption**, an **overlay**, and a secondary
   optionset for a synced thumbnail nav carousel (`asNavFor`).
5. Row style is typically *Fields* or *Content*; each row becomes a slide.

## Grouping options (config schema `slick_extended_views`)
Stored under the style's options; keys:
- `grouping` — sequence of `{ field, rendered, rendered_strip }`; split rows into groups by a
  field (optionally by its rendered output, optionally stripping tags).
- `grouping_limit` — max items per group.
- `grouping_optionset` — optionset used for the outer/group-level carousel (enables a nested
  "carousel of carousels").

## Rendering / theming
`render()` calls `renderGrouping()` then delegates to the Slick manager
(`$this->manager->build()`), which uses the **slick** module's theme hooks
(`slick`, `slick_wrapper`) and library. If image fields use the **Blazy** formatter,
`checkBlazy()` wires lazy-load + lightbox galleries automatically. To customize markup,
override the slick templates from the Slick/Blazy modules rather than anything here.

Options are saved inside the View, so exporting the View config carries the carousel setup.
