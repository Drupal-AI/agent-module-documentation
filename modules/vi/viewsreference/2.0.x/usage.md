Views Reference Field adds a `viewsreference` field type (an extension of core's entity reference) that lets editors pick a View and display, then embed its rendered output inside any fieldable entity such as a node, block, or paragraph.

---

Out of the box Drupal can embed a View only through a Views block or a hand-placed block, which is rigid for editorial layouts. Views Reference makes a View a first-class field value: you add a "Views reference" field to a content type or paragraph, and editors select a View + display via an autocomplete widget. The field stores the target View, the chosen `display_id`, and a serialized `data` blob of per-instance settings. The formatter then renders the selected display in place. Which extra controls editors get is configurable per field through **ViewsReferenceSetting** plugins — the module ships plugins for contextual filter arguments, a title override, a custom header, and pager/limit/offset overrides, and you can add your own. Site builders restrict which View display plugin types (block, page, etc.) are selectable, optionally preselect a list of allowed Views, and toggle which settings appear. A lazy-builder formatter renders the View in a placeholder for better cacheability, and token support lets arguments derive from the current route (e.g. the current node). Because it builds on entity reference, values are revisionable, translatable, and exportable like any field.

---

- Add a "Views reference" field to a content type so editors embed a listing on a page.
- Let content authors pick which View and display appears in a region without touching Views admin.
- Embed a View inside a Paragraph for flexible layout building.
- Pass the current node ID as a contextual filter argument to a referenced View.
- Override a referenced View's title per placement.
- Inject a custom header above an embedded View.
- Override the pager, items-limit, or result offset for one embed instance.
- Restrict a field so only `block` display Views can be selected.
- Preselect a curated allow-list of Views editors may choose from.
- Enable only specific setting controls (argument, title, pager) on a given field.
- Build a "related content" block driven by an editor-selected View.
- Render multiple different Views on a single node via a multi-value field.
- Use the lazy-builder formatter to keep host-entity cache tags clean.
- Reference a View from configuration and export the default value with the field.
- Provide token-based arguments so one View serves many contextual pages.
- Add a custom ViewsReferenceSetting plugin to expose a new per-embed control.
- Alter the list of available setting plugins via the info alter hook.
- Let a landing-page builder assemble sections from reusable Views.
- Embed a slideshow or carousel View chosen per node.
- Give decoupled/normalized output of which View + display a field points to.
- Theme the embedded View's title via the `viewsreference__view_title` template.
- Show a loading placeholder while a lazy-rendered View resolves.
- Reuse one View across many entities with different arguments each time.
- Swap the displayed View seasonally by editing the field, not code.
- Translate which View is referenced per language on multilingual sites.
