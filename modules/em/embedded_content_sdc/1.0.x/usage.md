Embedded Content: Single Directory Components lets editors insert any Single Directory Component (SDC) into a CKEditor 5 text field and fill in its props and slots.

---

This module is a bridge between Drupal core's Single Directory Components and the contributed Embedded Content module. On its own, Embedded Content gives editors a CKEditor 5 toolbar button that opens a dialog for inserting content produced by "embedded content" plugins. This submodule adds one such plugin, `sdc`, whose deriver enumerates every SDC component registered on the site (from themes and modules) and exposes each as a selectable option behind the button. When an editor picks a component, cl_editorial and the schema-forms library generate a mapping form from the component's `*.component.yml` prop and slot schema, so the editor fills in prop values and slot content without writing markup. The stored props and slots are rendered at display time through a `#type: component` render element, and slot values authored as rich text are rendered through the selected text format. The module ships no routes, permissions, services, or configuration of its own; which components an editor may insert, and who may use the button, are governed entirely by the Embedded Content button configuration and the text format / editor permissions of the parent module.

---

- Give site builders a way to surface theme-provided SDC components (cards, callouts, buttons, media objects) as editor-insertable rich-text embeds.
- Let content editors drop a design-system component into body copy without touching HTML or Twig.
- Reuse the same SDC components in templates and in free-form CKEditor content, keeping a single source of truth for markup.
- Insert a "call to action" button component with editor-supplied label and link props inside an article body.
- Add a highlighted callout / alert box component mid-article with a title prop and a rich-text slot.
- Embed a card component and map its heading, description, and image props from the mapping form.
- Provide a "quote" or "pull-quote" component that editors place inline in long-form content.
- Insert an accordion or tabs component and populate each slot with formatted text.
- Let editors add a statistics / KPI tile component with numeric and label props.
- Embed a video or media-object component whose props point at a URL or media reference.
- Offer a two-column or grid layout component whose slots hold editor-authored rich text.
- Add a testimonial component with author name, role, and quote props.
- Insert a pricing-table or feature-list component built as an SDC into a landing-page body field.
- Curate, per text format, exactly which SDC components are insertable by configuring the Embedded Content button's allowed plugins.
- Restrict component insertion to trusted roles by controlling which text formats include the Embedded Content filter and button.
- Preview a component with its mapped props live in the CKEditor editing view before saving.
- Standardize marketing components across a multisite by shipping them once as SDC and embedding them through this bridge.
- Replace ad-hoc inline HTML snippets that editors used to paste with governed, schema-validated components.
- Let editors compose landing pages inside a single rich-text field using a palette of design-system components.
- Fill a component slot with processed text (e.g. a formatted paragraph) that honors the site's text-format filters.
- Expose a "notice" or "banner" component so editors can add sitewide-styled announcements within content.
