CKEditor 5 Bootstrap Accordion adds a toolbar button that inserts and edits a Bootstrap 5 accordion directly inside CKEditor 5, plus a companion text-format filter that adds the runtime Bootstrap attributes needed for the accordion to work on the rendered page.

---

The module ships a TypeScript-built CKEditor 5 plugin (`js/build/bootstrapAccordion.js`, declared in `ckeditor5_bootstrap_accordion.ckeditor5.yml`) providing an **Accordion** toolbar item that inserts an accordion widget, adds/removes accordion items, and toggles "open first item" / "open all". It leans on CKEditor 5's General HTML Support (GHS) and a clipboard pipeline, and the allowed markup is the set of `<div>`/`<a>` elements with `accordion*` classes and a `data-accordion-id` attribute declared under `drupal.elements`. In the stored markup each accordion carries only structural classes and `data-accordion-id`; the runtime Bootstrap wiring is added at render time by the **Accordion enabler** filter (`filter_bootstrap_accordion`, `src/Plugin/Filter/BootstrapAccordion.php`, a `TYPE_TRANSFORM_IRREVERSIBLE` filter). That filter parses the HTML with `Html::load`/DOMXPath and, for each `div[data-accordion-id].accordion`, assigns ids and adds `data-bs-toggle`, `data-bs-target`, `aria-expanded`, `aria-controls`, and (unless "stay open") `data-bs-parent` to the buttons and collapse panes. There is **no config form, no permissions, no schema, and no Drush** — setup is purely: enable the module, drag the Accordion button onto a text format's CKEditor 5 toolbar at `admin/config/content/formats`, and enable the "Accordion enabler" filter on that format. The site theme must load Bootstrap 5's CSS/JS for the accordions to display and animate on the front end (not needed in the editor). Developers can extend the toolbar by altering the `bootstrapAccordion.toolbarItems` CKEditor config; accordion-in-accordion nesting is supported.

---

- Let editors insert a Bootstrap 5 accordion into rich-text content without writing HTML.
- Add or remove accordion items from the CKEditor toolbar.
- Configure an accordion to open its first item by default.
- Configure an accordion where all items can stay open at once.
- Build FAQ sections as collapsible accordions in body fields.
- Create nested (accordion-in-accordion) collapsible content.
- Produce accessible collapsibles with `aria-controls`/`aria-expanded` set automatically.
- Keep stored markup clean (structural classes only) and add Bootstrap attributes at render.
- Enable the Accordion button on a specific text format's CKEditor 5 toolbar.
- Turn on the "Accordion enabler" filter so accordions function on the rendered page.
- Reuse an existing Bootstrap 5 theme's CSS/JS with no extra front-end assets.
- Style accordions by overriding Bootstrap 5 CSS variables in the theme.
- Provide collapsible documentation/help sections in page content.
- Add expandable product-detail panels on content pages.
- Let content authors reorder or delete accordion panes visually.
- Support multiple independent accordions in a single field.
- Extend the accordion toolbar with a custom CKEditor 5 plugin via `toolbarItems` config.
- Restrict accordion markup to a chosen text format by only enabling the filter there.
- Migrate collapsible content authoring off bespoke HTML snippets.
- Keep editing accordions inline (tab navigation works inside the widget).
