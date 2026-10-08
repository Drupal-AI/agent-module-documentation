<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Relationship Diagrams draws the site's entity types, bundles, fields and the references between them as an interactive in-browser diagram, so the data model can be seen at a glance rather than reconstructed one bundle at a time from Field UI.

---

Understanding an unfamiliar Drupal site means working out which entity types exist and how they point at each other, and Field UI answers that one bundle at a time. This module answers it all at once, which is why a diagram is one of the first things an agency wants when inheriting a site. Everything is generated dynamically from the live entity definitions, so the picture cannot drift from reality: `EntityRelationshipDiagramController::getMainDiagram()` at `/admin/structure/erd` walks the entity type manager, bundle info and field manager, emits nodes and reference/comment edges into `drupalSettings.erd`, and `js/main.js` renders them with JointJS. You search entities into the canvas, drag to draw relationships, toggle between human labels and machine names, cycle line styles, and save the canvas to SVG or PNG; an AJAX route (`erd.ajaxSave`) persists the arrangement to the State key `erd.graph` so a layout survives a reload. A settings form (`erd.settings`) filters what is included — exclude specific fields, restrict to a chosen property allow-list, or show only entity-reference fields. All three routes are gated by the single `administer erd` permission, and other modules can inject or adjust nodes via `hook_erd_entities_alter()`. Two operational caveats: the front-end libraries (JointJS 1.0.3, Lodash, svg-pan-zoom) load from a CDN, so the diagram will not render offline without editing `erd.libraries.yml`; and the module pulls in four contributed jQuery UI backport modules (`jquery_ui`, `jquery_ui_menu`, `jquery_ui_autocomplete`, `jquery_ui_resizable`) for components core dropped after Drupal 9. Core requirement is `^9.4 || ^10 || ^11`. For documentation that needs to leave the site, `content_model_documentation` exports and renders Mermaid diagrams; this one is the interactive, in-site view.

---

- See the site's entity relationships at a glance.
- Understand an inherited Drupal site.
- Show the data model to a new developer.
- Plan a refactor of entity references.
- Find which bundles reference a taxonomy term.
- Document the model for a client handover.
- Explore reference chains interactively on a canvas.
- Rearrange a diagram and keep the layout across reloads.
- Identify orphaned or unreferenced entity types.
- Explain the model to a non-technical stakeholder.
- Check the impact of removing a field before you do it.
- Review the model before a content migration.
- Spot unexpected or accidental reference relationships.
- Support an architecture review with a live picture.
- Teach Drupal's entity system using a real site.
- Restrict who can see the schema via the `administer erd` permission.
- Compare the built model against a written specification.
- Find circular references between bundles.
- Export the diagram to SVG or PNG for a slide or wiki.
- Filter the view down to only entity-reference fields.
- Hide noisy fields with the exclude list.
- Focus on a handful of properties with the include allow-list.
- Toggle machine names on to grab exact field IDs.
- Add custom labels/annotations to a diagram before exporting.
- Inject extra nodes from a custom module with `hook_erd_entities_alter()`.
