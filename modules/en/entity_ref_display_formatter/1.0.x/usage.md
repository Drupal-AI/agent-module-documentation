Entity Reference Display Formatter renders the referenced entities of an entity_reference (or entity_reference_revisions) field as horizontal tabs, vertical tabs, an accordion, or anchor links, using fields you choose as the tab title and body.

---

The module adds one field formatter, `entity_reference_display_formatter` ("Entity reference Display formatter"), selectable on any *Manage display* row for an `entity_reference` or `entity_reference_revisions` field. In the formatter settings you pick one or more fields of the referenced entity to use as the **title** and one or more as the **body**, order each set with a drag-and-drop weight table, and choose a **display style**: Horizontal Tab, Vertical Tab, Accordion, or Anchors. When the entity is viewed, each referenced item becomes one tab/accordion panel/anchor section; the chosen title fields are rendered into the clickable label and the chosen body fields into the panel content, each rendered with the field's own `full` view mode. The matching behaviour is provided by lightweight JS/CSS libraries (core `once` for horizontal tabs, jQuery UI tabs for vertical tabs, jQuery UI accordion for the accordion; anchors are pure CSS). It requires no configuration form, no permissions, and no extra modules to install, though the Vertical Tab and Accordion styles rely on the jQuery UI tabs / accordion libraries. Because it also targets `entity_reference_revisions`, it is commonly combined with Paragraphs to turn a multi-value paragraph field into a tabbed or collapsible interface without custom theming.

---

- Turn a multi-value Paragraphs field into a horizontal tabbed interface on a node.
- Present a list of referenced "section" nodes as an accordion (FAQ-style).
- Build a vertical-tab layout from referenced taxonomy terms or entities.
- Generate an on-page anchor navigation list from referenced content sections.
- Display a "Team members" entity-reference field as tabbed member profiles.
- Show product specification paragraphs as collapsible accordion panels.
- Render referenced "step" entities as sequential tabs in a how-to guide.
- Group related articles referenced from a landing page into tabbed panels.
- Convert a long single-page document (referenced sections) into anchored jump links.
- Display referenced event entities each in its own accordion panel.
- Use one field of the referenced entity (e.g. a heading) as the tab label and a body field as the panel.
- Combine several fields as the tab title by adding them all and ordering them by weight.
- Combine several fields as the panel body and control their stacking order by weight.
- Provide a FAQ page where each referenced question/answer paragraph is one accordion item.
- Show referenced "feature" paragraphs as horizontal tabs on a marketing page.
- Build a tabbed comparison from referenced product-variation entities.
- Create anchored table-of-contents-style navigation for referenced chapters.
- Render referenced media-caption entities as tabs beside a gallery.
- Present multilingual referenced content, rendering each item in the current request language when a translation exists.
- Lay out referenced "tab" paragraph types in a vertical-tab sidebar.
- Display referenced testimonial entities as an accordion of quotes.
- Turn referenced "policy" documents into anchored sections on a legal page.
- Show referenced course-module entities as horizontal tabs in an LMS-style display.
- Render referenced pricing-plan paragraphs as side-by-side vertical tabs.
- Build an anchored glossary from referenced term entities.
