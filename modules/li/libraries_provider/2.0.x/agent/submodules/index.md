<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Libraries Provider UI (`libraries_provider_ui`)

The base `libraries_provider` module has no UI, route, or permission — it only rewrites library definitions. Enable `libraries_provider_ui` to manage overrides from the admin interface.

- **Depends on:** `libraries_provider`, `form_options_attributes` (`^2`).
- **`configure`** route: `entity.library.collection`.

## Routes (`libraries_provider_ui.routing.yml`) — all require `administer libraries`
- `entity.library.collection` — `/admin/structure/libraries` — list of all managed libraries (`_entity_list: library`).
- `entity.library.add_form` — `/admin/structure/libraries/add/{from_library}` — create an override entity from a library's declared defaults.
- `entity.library.edit_form` — `/admin/structure/libraries/manage/{library}` — edit an override.
- `entity.library.delete_form` — `/admin/structure/libraries/manage/{library}/delete` — "Revert library to defaults" (deletes the config entity).

A menu link under `system.admin_structure` ("Libraries") is added.

## Permission
`administer libraries` — "Configure how third-party assets are loaded regarding versions, CDNs, etc." (`libraries_provider_ui.permissions.yml`). This is the only permission in the project and it is powerful: it controls where the site's front-end JS/CSS is loaded from. It is **not** flagged `restrict access: true`. Grant it only to trusted administrators.

## How the entity gets its forms
The `library` config entity is defined in the base module (`src/Entity/Library.php`) but its handlers are attached by the submodule at runtime: `src/EventSubscriber/EntityBuild.php` listens on `EntityHookEvents::ENTITY_TYPE_BUILD` and sets the add/edit form (`LibraryForm`), delete form (`LibraryDeleteForm`), list builder (`LibraryListBuilder`), link templates, and `admin_permission => administer libraries`.

## The edit form (`src/Form/LibraryForm.php`)
- **Source** — select of every `LibrarySource` plugin; unavailable sources are disabled with an explanatory message, and each option carries `data-library-source-versions` (JSON of that source's versions).
- **Version** — select populated from the chosen source's available versions; `js/libraryForm.js` repopulates it client-side when the source changes.
- **Minified** — `always` / `never` / `when aggregating` (links to the performance settings page).
- **Variant** — shown only if the library declares `variants_available`; option URLs surface a "learn more" description (updated client-side).
- **Replaces** — checkboxes of other library entities this one supersedes.
- **Custom options** — shown only if the library declares `custom_options`; either lists unmet requirements or renders a textfield per SASS variable (with original/computed values from the JSON schema). Empty overrides are stripped on save.

`LibraryListBuilder` merges saved entities with synthesised (unsaved) entities for every managed-but-not-yet-overridden library, showing Name / Version / Source / Enabled, with "Override default configuration", "Edit library", and "Revert library to defaults" operations. `LibraryController::libraryTitle()` renders the entity label as the edit-page title (filtered through `Xss::getHtmlTagList()`).

## Notes
- Source and Version are core `select` elements with server-side `#options` validation, so a submitted value must be one of the plugin-provided ids/versions — an admin cannot type an arbitrary CDN URL or version string through this form.
- Saving or deleting an override clears the library-discovery cache.
