Display Layout lets you assign a Drupal Layout API layout to any entity view-display (view mode) from the Manage display form, so fields are sorted into the layout's regions and rendered inside it without field groups.

---

Display Layout is a small, dependency-light module (core `layout_discovery` + `field_ui` only) that extends the standard *Manage display* form for content entities. It adds a "Display layout settings" details element where you pick any registered core Layout plugin (a one-column layout, two/three-column layouts, or any layout provided by a theme or module). Once a layout is chosen and saved, its regions replace the single "Content" region on the display, and you drag each field into a region using Field UI's normal region table. At render time the module moves each field's render array into its configured region and wraps the display in the layout's own markup, keeping the entity wrapper in place so caching, contextual links, and theme-hook suggestions still work. Layout selection is stored as a third-party setting (`display_layout.layout`) on the `entity_view_display` config entity, so it travels with configuration export/import. When Layout Builder is installed and enabled for a bundle, Display Layout steps aside and Layout Builder's own UI takes over; otherwise Display Layout's selector is available. It positions itself as a minimalist alternative to Display Suite (do not run both on the same site — their configuration does not map).

---

- Give an article's *Full content* view mode a two-column layout without installing Display Suite.
- Sort node fields into named regions (e.g. "left"/"right") straight from Manage display.
- Add a layout to the *Teaser* view mode so listing cards get a consistent structure.
- Use a theme-provided custom layout (with its own regions and template) for entity displays.
- Replace field-group-based column arrangements with real Layout API regions.
- Apply a layout to a media entity's display so image and caption fields sit side by side.
- Configure a taxonomy term display to render a header region and a body region.
- Give a Commerce product's default display a structured multi-region layout.
- Keep field ordering per-region rather than one flat list on Manage display.
- Assign different layouts to different view modes of the same content type.
- Export the chosen layout with the display config (`third_party_settings.display_layout.layout`) for deployment.
- Migrate a bundle to a new layout by changing one select value and re-dragging fields.
- Provide a lightweight layout mechanism on sites that cannot use Layout Builder's per-entity overrides.
- Move a field to the layout's "Disabled/Hidden" region to stop it rendering, as usual.
- Fall back gracefully: if a chosen layout is later removed, the display renders without layout wrapping rather than erroring.
- Combine with any custom layout plugin defined in code via `@Layout`/layout definition to expose it for view modes.
- Standardize entity output across a site using a shared set of layouts.
- Let site builders pick layouts without touching templates or writing preprocess code.
- Use the same layouts that Layout Builder would offer, since both read from the core Layout plugin manager.
- Keep the module's hook weight above Layout Builder's so its form-class override applies correctly after install.
