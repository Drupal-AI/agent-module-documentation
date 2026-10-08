Element Class Formatter is a collection of field formatters that add one or more CSS classes directly to the rendered field element (the `<a>`, `<img>`, list `<ul>`, label, or wrapper tag) rather than to the field's outer wrapper markup.

---

Unlike Field Formatter Class (which adds classes to a field's wrapper), this module extends core's own formatters so the class lands on the element itself, which is otherwise hard to reach from Twig. It ships twelve formatters selectable per field on *Manage display*, each adding an "Element class" text field (a space-separated set of classes) plus formatter-specific options: `link_class` and `link_ally_class` (links, the latter with separate visible + screenreader text and a wrapper tag), `link_list_class` and `string_list_class` and `list_string_list_class` and `entity_reference_list_label_class` (render a multi-value field as a real `<ul>`/`<ol>` list with a class), `image_class` (extends the core image formatter), `file_link_class`, `email_link_class`, `telephone_link_class`, `entity_reference_label_class` (linked or plain label with a tag), and `wrapper_class` (wrap plain text/long text in a chosen tag such as `div`/`span`/`p`/`h1`–`h5`, optionally linked to the entity, with summary/trim options). Each formatter's settings are stored in the field component of the relevant `entity_view_display` config entity and validated by the module's config schema (e.g. `field.formatter.settings.link_class`). The classes are added via a small set of reusable traits (`ElementClassTrait`, `ElementLinkClassTrait`, `ElementEntityClassTrait`, `ElementListClassTrait`), which you can reuse to build your own class-adding formatter. There is no admin/settings page, no permissions, and no Drush — it is pure display configuration. The `element_class_formatter_responsive_image` submodule adds the same treatment to Responsive Image fields.

---

- Add a Bootstrap `btn btn-primary` class to a Link field's anchor tag.
- Add `rel="nofollow"` and a class to outbound link fields.
- Turn a multi-value link field into a classed `<ul>` navigation list.
- Render a multi-value text/list field as an `<ol>` with a CSS class.
- Add a utility class (e.g. `img-fluid`) directly to an image field's `<img>` element.
- Wrap a plain-text field in an `<h2 class="card-title">` via the wrapper formatter.
- Wrap a text field in a `<div>` and link it to its parent entity with a link class.
- Add a class to a Telephone field's `tel:` link.
- Add a class to an Email field's `mailto:` link.
- Add a class to a File field's download link, optionally showing size/type.
- Add a class to an Entity Reference field's label, linked or as a plain tag.
- Render a list of entity-reference labels as a classed list.
- Provide accessible links with separate visible text and screenreader-only text (`link_ally_class`).
- Give editors control of element classes without touching Twig templates.
- Standardise button/link styling across content types via display config.
- Output a `text_with_summary` field's summary wrapped in a classed element.
- Trim and wrap long text in a classed tag for teaser displays.
- Apply a heading tag + class to a string field used as a card title.
- Add classes needed by a CSS/JS framework straight onto field elements.
- Export the classed display as config for consistent deployment across environments.
- Build a custom class-adding formatter by reusing the module's traits.
- Add classes to responsive image fields (via the responsive image submodule).
- Avoid a wrapper-only class approach when the framework needs the class on the element.
