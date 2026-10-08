Entity Bootstrap Accordion Tab Formatter is a field formatter that renders the targets of an entity-reference field as Bootstrap accordion panels or tabs.

---

Entity Bootstrap Accordion Tab Formatter provides one field formatter (`entity_bs_accordion_tab_formatter`) for `entity_reference` and `entity_reference_revisions` fields — so it works with Paragraphs as well as node/media/term references. On the host entity's *Manage display*, you pick, per referenced bundle, which field supplies each panel's **title** and which field(s) supply its **body**, plus a **style** field on the host entity that decides at render time whether the set is shown as an "accordion" (first panel open), "accordion_closed" (all collapsed), or "tab" layout. Bodies can be rendered through a chosen view mode, and field order can follow that view mode's display weights. A site-wide settings form selects the Bootstrap markup version (3, 4 or 5), which switches both the emitted attributes and the Twig template used. The theme must supply Bootstrap's own CSS/JS; for Bootstrap 3 tabs the external Bootstrap Responsive Tabs library is also required. It is purely a display feature and defines no permissions or content entities of its own.

---

- Display a Paragraphs field as a Bootstrap accordion.
- Display referenced nodes as tabbed sections.
- Turn an entity-reference field into collapsible panels.
- Let editors switch a component between accordion and tabs via a "style" field.
- Show a set of FAQ paragraphs as an accordion with the first item open.
- Render an "accordion_closed" layout where every panel starts collapsed.
- Use a paragraph's title field as the accordion/tab header.
- Combine several fields of each referenced entity into one panel body.
- Render body fields through a specific view mode (e.g. "teaser").
- Order panel body fields by a view mode's configured field weights.
- Present product features as Bootstrap 5 tabs that collapse to an accordion on small screens.
- Build tabbed specification sections from referenced entities.
- Choose the heading level (h2–h6) used for accordion titles via a host field.
- Target Bootstrap 3, 4 or 5 markup site-wide from one settings form.
- Reuse the same reference field as tabs on one display and an accordion on another.
- Show referenced media items as accordion panels.
- Group related content entities under tabbed navigation.
- Render entity_reference_revisions (Paragraphs) targets with per-bundle title/body mapping.
- Display translated referenced entities in the current interface language.
- Present a step-by-step guide as sequential accordion panels.
- Show team members or profiles as tabs.
- Build a tabbed dashboard of referenced report entities.
- Render nested reference structures as Bootstrap components without custom Twig.
