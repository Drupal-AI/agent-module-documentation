<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Field Create Link provides an autocomplete entity-reference widget that shows a "Create @bundle" button beside the field so editors can open the referenced entity's add form.

---

Entity Reference Field Create Link ships a single field widget, **Autocomplete (with create link)**, that extends Drupal core's entity-reference autocomplete widget. On any `entity_reference` field it renders the normal autocomplete input plus one action button per allowed target bundle, each linking to that bundle's entity add form (opened in a new browser tab). It resolves the correct core route for the field's target entity type — `node.add` for nodes, `entity.taxonomy_term.add_form` for taxonomy terms, and `entity.media.add_form` for media — so an editor who cannot find an existing entity to reference can create one without abandoning the form they are on. Supported target types are limited to **node, taxonomy term, and media**; other entity types render the plain autocomplete with no create button. The module depends only on core Field, adds no routes, permissions, services, or configuration of its own, and stores no settings beyond those inherited from the core autocomplete widget.

---

- Let content editors create a new node to reference directly from an autocomplete reference field.
- Add a "Create Tags" button next to a taxonomy-term reference field for on-the-fly vocabulary term creation.
- Add a "Create Image" button beside a media reference field so authors can add media without leaving the node form.
- Reduce round trips when authoring content that references entities not yet created.
- Swap the stock "Autocomplete" reference widget for the create-link variant on any node type's Manage form display.
- Give each allowed target bundle its own labelled create button (e.g. "Create Article" and "Create Page" on a multi-bundle reference).
- Open the entity add form in a new tab so the in-progress form is preserved.
- Speed up editorial workflows where referenced taxonomy terms are frequently missing.
- Provide inline term creation as a lighter alternative to a full inline-entity-form setup.
- Help authors of event, recipe, or catalog content quickly spin up referenced categories.
- Streamline building relationships between content types during initial site population.
- Let editors create referenced media assets (image, video, document) from within a host form.
- Improve authoring UX on reference fields that point at seldom-populated bundles.
- Offer a create shortcut only for the bundles the field is actually configured to accept.
- Keep the familiar autocomplete matching behaviour while adding creation shortcuts.
- Apply per-field: enable the widget only on the reference fields where inline creation helps.
- Support single- and multi-value entity-reference fields (the buttons appear once per field).
- Use on taxonomy-term reference fields as an alternative to the core "Autocomplete (Tags style)" free-tagging widget when you want an explicit full add form.
- Guide new editors toward creating structured referenced content rather than free text.
- Reduce context switching for teams building interlinked node structures.
- Provide a discoverable creation entry point for media libraries referenced from articles.
- Complement autocomplete matching for large vocabularies where the needed term may not yet exist.
- Fit sites on Drupal 9, 10, 11, or 12 that want a low-dependency create shortcut on reference fields.
