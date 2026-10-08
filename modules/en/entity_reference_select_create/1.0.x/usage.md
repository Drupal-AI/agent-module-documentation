<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Select Create is a field widget that puts a modal "Create" button next to an entity reference select list so editors can create a new referenced entity inline.

---

Entity Reference Select Create ships one field widget, "Select list with create button", for `entity_reference` fields. It renders the standard core select/dropdown of existing referenceable entities and appends an AJAX button that opens a modal containing the target entity's own creation form. When the editor saves the modal, the dialog closes, the newly created entity is appended to the select list as a pre-selected option (no page reload), and the reference is stored when the host form is finally saved. The widget extends core's `OptionsSelectWidget`, so it inherits all normal select behavior; on top of that it adds three settings — which target bundle to create, which form mode to render in the modal, and the button label. Creation runs through the standard entity form for the chosen form mode and respects the current user's create access. It requires only Drupal core (no contrib dependencies) and runs on Drupal 10 and 11.

---

- Let editors create a new taxonomy term directly from a term-reference select field.
- Add missing referenced content without leaving the current node edit form.
- Create a new custom entity inline while filling in a reference field.
- Speed up authoring flows where the referenced entity often does not exist yet.
- Replace the "save, leave, create, return, re-select" workflow with a single modal.
- Reference a brand-new author, tag, or category on the fly during content entry.
- Populate a select list of referenced entities that starts empty on a fresh site.
- Give a simplified modal form (a dedicated form mode) that shows only the fields editors need.
- Restrict inline creation to a specific bundle when a field allows several target bundles.
- Provide a friendlier alternative to autocomplete for small, curated reference sets.
- Let a paragraph or media reference offer inline creation of the referenced item.
- Rename the create button per field (e.g. "Add Event", "New Speaker").
- Keep the editor on one screen when building linked content structures.
- Add a create option to a select list used inside a modal-heavy admin UI.
- Reduce context switching for editors managing reference-heavy content models.
- Auto-select the just-created entity so the editor does not have to find it in the list.
- Support any entity type that has an entity form and a creation form.
- Offer inline creation for node, taxonomy, user, or contributed-entity references.
- Use a custom form mode to expose extra fields only during inline creation.
- Fall back gracefully to the default form when a configured form mode has no form class.
- Enable inline creation per field via Manage form display, with no custom code.
- Keep the referenced-entity creation permission-gated to the current editor.
