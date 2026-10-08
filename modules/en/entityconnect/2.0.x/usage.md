<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Connect adds "add new content" (+) and "edit current content" (pencil) buttons to Entity Reference field widgets, so editors can create or edit the referenced entity inline and be returned to the original form with the new/edited entity selected.

---

The module targets any `entity_reference` field storage (not base fields) using the default Entity
Reference widgets. When a form with such a field is built, Entity Connect adds `entityconnect_submit`
buttons; pressing one caches the in-progress parent form in the user's **private tempstore** (keyed by a
random cache id) and redirects to `/admin/entityconnect/add/{cache_id}` or `/edit/{cache_id}`. Those
controller routes resolve the target entity type's real **core add/edit form route** (e.g. `node.add`,
`entity.<type>.edit_form`) and redirect the user there; after the user saves that core form, a return
flow (`/admin/entityconnect/return/{cache_id}/{cancel}`) restores the cached parent form and injects the
resulting entity id back into the reference field. Crucially, Entity Connect's own permissions only
control whether the **buttons are shown / the intermediate route is reachable** — the actual create and
edit happen on the standard core entity forms, which enforce their own entity-create/edit access. A
global admin form (`admin/config/content/entityconnect`, permission `administer entityconnect`) sets
default button/icon visibility, and each reference field can override this via
`third_party_settings.entityconnect`. The module ships permissions, a config schema, a custom access
check, a private-tempstore cache service, a custom submit render element, and a rich set of alter hooks
(`entityconnect.api.php`); it has no plugins and no Drush.

---

- Add a "+" button to an entity-reference field so editors can create the referenced entity inline.
- Add a pencil button to jump straight to editing the currently referenced entity.
- Return the editor to the original form (with the new entity pre-selected) after creating it.
- Let content authors create taxonomy terms on the fly from a term-reference field.
- Create a referenced node/user/media without leaving the parent content form.
- Enable the buttons globally by default, then hide them per field where unwanted.
- Disable the buttons globally by default, then enable them only on chosen reference fields.
- Show icons instead of text buttons for a more compact widget.
- Improve editorial UX for deeply nested content models with many reference fields.
- Edit an existing referenced entity to fix its data mid-authoring, then come back.
- Work with all default Entity Reference widgets (autocomplete, select, checkboxes/radios).
- Support multi-value reference fields (per-delta add/edit).
- Exclude specific forms from Entity Connect processing via `hook_entityconnect_exclude_forms_alter()`.
- Restrict which reference fields get buttons via `hook_entityconnect_ref_fields_alter()`.
- Alter the child (target) add/edit form via `hook_entityconnect_child_form_alter()`.
- Customise the value returned to the parent field via `hook_entityconnect_return_form_alter()`.
- Change the add/edit target or acceptable bundles via the field-attach/add-info alter hooks.
- Gate button visibility by role using the `entityconnect add button` / `entityconnect edit button` perms.
- Preserve an in-progress parent form safely per-user via private tempstore while the editor detours.
- Build guided content-entry flows where related entities are created step by step.
- Reduce context-switching when authoring content that references many other entities.
- Let editors add a referenced entity type that offers several bundles (choose-a-type list).
