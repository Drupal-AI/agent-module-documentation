Display Builder is a unified, drag-and-drop visual builder that assembles Drupal displays (entity views, page layouts and Views displays) out of reusable Single Directory Components, blocks, fields and pattern presets.

---

Display Builder (by the UI Suite team) is a design-system-native replacement for three separate Drupal display tools: Layout Builder for entity view displays, the Block layout for whole pages, and the Views display-building UI. The core `display_builder` module defines the plugin infrastructure — a `display_buildable` plugin type for the kinds of display that can be built, an `island` plugin type for the builder's UI panels/toolbars, a `display_builder_instance` content entity that holds the working (draft) source tree, and a `display_builder_profile` config entity that decides which islands (panels) a given builder screen shows. Editing happens through HTMX API routes gated by entity access; a live preview renders each draft in an isolated iframe. Sources come from UI Patterns 2, so anything exposed as a UI Patterns source (components, blocks, fields, view results, menus) can be dropped into a display. The actual builder screens are provided by the submodules: `display_builder_ui` (manage profiles/presets/instances), `display_builder_entity_view` (build entity view displays and per-entity overrides), `display_builder_page_layout` (build whole-page layouts), and `display_builder_views` (build Views displays). It requires Drupal 11.4+ and UI Patterns 2, and integrates with `ui_styles`, `ui_icons` and `ui_skins` for styles, icons and CSS design tokens.

---

- Replace Layout Builder to visually build a bundle's entity view display (e.g. Article Full / Teaser) from components.
- Let editors override a single node's display on top of the bundle default, then revert it back.
- Build whole-page layouts (header/content/footer regions) as an alternative to placing blocks in theme regions.
- Design a Views display's output (rows, header, footer, empty, pager, feed icons, exposed form) with components instead of Views' own display UI.
- Drag Single Directory Components (SDC) from a component library panel onto a display and nest them in slots.
- Drop core/contrib blocks into a display via the block library panel, grouped and searchable.
- Compose reusable "pattern presets" (saved component sub-trees) and attach them into displays in one click.
- Save any selected node on a display as a new pattern preset for reuse elsewhere.
- Apply CSS utility classes (via ui_styles) to individual components directly in the builder, and copy/paste styles between nodes.
- Preview a display live in an isolated iframe with a viewport switcher (desktop/tablet/mobile) that reflows the real render.
- Use undo/redo history while building, and restore a display to its last published state.
- Work with a draft/publish workflow: build against a draft, then publish to make it live.
- Collaborate in near-real-time on the same instance using the server-sent-events (SSE) channel, so a second editor's changes refresh your panels.
- Restrict which builder profile an editor may use through per-profile "Use the … Display Builder profile" permissions.
- Curate each profile: enable/disable individual islands (component library, block library, presets, tree navigator, styles, viewport, collaboration, etc.) and exclude specific components or blocks.
- Bring a full design system into Drupal by pairing it with a UI Suite theme (Bootstrap, DaisyUI, DSFR, USWDS) and its SDC components.
- Insert design-token / CSS-variable driven styling (via ui_skins) and icons (via ui_icons) as first-class sources.
- Manage all display builder instances from an admin list at Structure → Display builder → Instances.
- Duplicate an existing page layout as a starting point for a new one.
- Add generic structural components (section, break, inline, link) as layout scaffolding around content.
- Use keyboard shortcuts exposed by islands to speed up building.
