USWDS Ckeditor Integration Embed is a config-only glue submodule that ships a ready-made `uswds_paragraphs` text format and CKEditor editor wiring the parent module's USWDS components together with paragraph embeds.

---

The submodule contains no PHP — it is entirely `config/optional/*.yml`. Enabling it installs a `USWDS (Paragraphs)` text format (`filter.format.uswds_paragraphs`) with a curated `filter_html` allow-list (headings, media/entity/paragraph embeds, USWDS `<div>`/`<button>` accordion markup, tables) plus the parent's `filter_table_attributes` filter, and a matching `editor.editor.uswds_paragraphs` config that arranges a CKEditor toolbar including the USWDS grid, accordion, table items, and `paragraphs`/`paragraph_layout` embed buttons. It also ships two `embed.button.*` configs (Paragraphs, Paragraph Layout) that expose selected `uswds_*` paragraph types (accordion, alert, cards, process list, step indicator, summary box, 2-/3-column layouts) through the `paragraphs_entity_embed` button, plus default `embed.settings`, `entity_embed.settings`, and a `paragraph.embed` view mode. Because it depends on `uswds_paragraph_components` and `paragraphs_entity_embed` (not present on this documentation site), it is not enabled here; the configs are `config/optional`, so they only install when their dependencies are met. Use it as a turnkey starting point rather than building the USWDS paragraph text format by hand.

---

- Install a preconfigured `uswds_paragraphs` text format instead of assembling one manually.
- Get a CKEditor toolbar wired with USWDS grid, accordion, table, and paragraph-embed buttons.
- Expose selected USWDS paragraph types (accordion, alert, cards, process list, summary box) as embeds.
- Add a "Paragraphs" embed button filtered to USWDS component paragraph types.
- Add a "Paragraph Layout" embed button for 2-/3-column USWDS layout paragraphs.
- Provide editors a government-design-system authoring format out of the box.
- Ship a curated `filter_html` allow-list tuned for USWDS + embed markup.
- Include the parent's USWDS stacked-table attributes filter in the format.
- Bundle a `paragraph.embed` view mode for rendering embedded paragraphs.
- Serve as a reference for wiring paragraphs_entity_embed with USWDS components.
- Roll out a consistent USWDS content-authoring format across a multisite install via config.
- Skip manual editor/toolbar setup when standing up a new USWDS site.
- Let editors embed a USWDS accordion paragraph inside body content via the Paragraphs button.
- Let editors embed a USWDS alert or summary-box paragraph in rich text.
- Insert USWDS card / card-group paragraphs as embeds within a page body.
- Add step-indicator and process-list paragraphs to procedural content.
- Restrict the embed button to only the approved USWDS paragraph types (via `paragraphs_type_filter`).
- Install supporting `embed.settings` / `entity_embed.settings` defaults automatically.
- Combine media embeds and USWDS paragraph embeds in a single toolbar.
- Keep the format's allowed HTML aligned with the markup USWDS components emit.
- Rebuild the format quickly on a fresh environment by re-importing the optional config.
