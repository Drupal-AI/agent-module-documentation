<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Group Metadata moves one specifically-named Field Group into the entity edit form's right-hand "advanced" sidebar — the same vertical-tabs column core uses for authoring information and the revision log — so the form separates the main content from its metadata without any configuration of its own.

---

Drupal entity forms (node, term, user, custom entities) render a `$form['advanced']` vertical-tabs group in a right-hand column and stack everything else in one long list. This module extends that treatment to a Field Group: at pre-render time `FieldGroupMetadataPreRenderer::preRender()` looks for a group whose machine name is exactly `group_metadata`, relocates it into `advanced` with `#weight -1000` (so it sorts above core's tabs), and copies the form's save/preview `actions` into the sidebar too. The trigger is entirely convention-driven — there is **no admin UI, no settings, no permissions and no routes**; the only requirement is that you create a Field Group (via the `field_group` module, on **Manage form display**) named `group_metadata`. Any other group name is ignored. It fires on every entity form that has such a group **except** forms whose id begins with `media_`, which are deliberately skipped. A `hook_module_implements_alter()` pushes this module's `hook_form_alter()` to the end of the list so it runs after `field_group` has already built the groups. The change is purely presentational: field storage, validation, widgets and access are untouched, so the module is safe to install or remove at any time (removing it just leaves the group in the main content area). It depends on `field_group ~3.0 || ~4.0`, targets `^8 || ^9 || ^10 || ^11`, and its `composer.json` sets `"minimum-stability": "dev"` — worth knowing when resolving versions in a strict project. Which group is "metadata" travels with the form-display config in `drush cex`, not with this module.

---

- Move a group of metadata fields into the node form's advanced sidebar.
- Separate editorial fields (title, body) from operational ones (review date, internal ref).
- Shorten a long content-editing form without deleting any fields.
- Match core's authoring-information / revision-log sidebar layout for your own fields.
- Group taxonomy, workflow and scheduling fields together in the sidebar.
- Reduce scrolling on a content type with many fields.
- Apply the sidebar treatment to a taxonomy term form.
- Apply it to a user profile edit form.
- Apply it to a custom content entity's edit form.
- Keep the save/preview buttons reachable at the top of the sidebar.
- Improve an editor's focus on the primary content.
- Give a migrated or legacy content type a cleaner form.
- Reduce onboarding friction on a busy form.
- Keep the layout change presentational only (no data model impact).
- Export the arrangement with the form display via configuration management.
- Install and uninstall freely without risk to content.
- Reuse field_group's existing Details/Tab group configuration.
- Standardise metadata placement across multiple content types (all use `group_metadata`).
- Deliberately exclude media library forms from the relocation.
- Highlight the fields editors use most by demoting the rest to the sidebar.
