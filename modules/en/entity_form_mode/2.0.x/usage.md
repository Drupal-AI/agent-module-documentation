<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Form Mode selects which form display an entity edit form uses, automatically, rather than always using the default.

---

Drupal supports several form modes per entity type and gives almost no way to reach them: create a "Quick edit" or "Editor" form display in the Field UI, and then discover that nothing routes to it without a custom form alter or a contrib module. So the feature exists and is unused, and sites instead give every role the same enormous form — a content type with forty fields presented identically to the person who writes the article and the person who sets the SEO metadata, with the fields each of them does not need hidden by CSS or simply endured. Choosing the form mode by context turns that into configuration: a simplified form for authors, the full one for editors, a minimal one for a front-end submission. Version **2.0.3** on core `^10 || ^11`, no dependencies. The point that matters most, and is the easiest to get wrong: **a form mode is not access control**. A field omitted from a form display is not saved from that form, which looks like a restriction and is not one — the field remains readable and writable through JSON:API, REST, a migration, a different form mode, a webform or `drush`. If the requirement is that a role must not change a value, that is **field-level access** (`hook_entity_field_access` or `field_permissions`), and a form mode is the wrong tool. Used for its actual purpose — reducing what a person has to look at — it is a genuine improvement in editorial experience.

---

- Give authors a simplified edit form.
- Show editors the full form.
- Route to a form mode automatically.
- Reduce a forty-field form for one role.
- Use a minimal form for front-end submission.
- Choose a form display per role.
- Improve editorial focus.
- Use different forms for create and edit.
- Show SEO fields only to SEO editors.
- Make existing form modes reachable.
- Reduce editor training burden.
- Simplify a complex content type.
- Support a multi-team editorial workflow.
- Use a quick-edit form mode.
- Reduce scrolling on a long form.
- Support a moderator's review form.
- Present relevant fields per context.
- Improve first-time editor experience.
