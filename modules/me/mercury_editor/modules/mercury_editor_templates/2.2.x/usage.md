<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mercury Editor Templates lets editors save a Mercury Editor section (a Layout Paragraphs component tree) as a reusable **template** and drop it back into any page, via a `me_template` content entity.

---

The submodule defines a `me_template` content entity type (revisionable, owner-tracked; base table `me_template`) that stores a saved section of Layout Paragraphs components. Editors save the currently selected component as a template through the `mercury_editor_templates.save_as_template` route (`/admin/mercury-editor/save-as-template/{layout_paragraphs_layout}/{uuid}`, `SaveAsTemplate` controller, permission "create mercury editor template") and later insert a stored template via `mercury_editor_templates.insert_template` (permission "use mercury editor templates"). An event subscriber on Layout Paragraphs' `LayoutParagraphsAllowedTypesEvent` injects published templates into the Mercury "add component" menu for users who hold the "use mercury editor templates" permission, respecting the layout's nesting depth. Templates are managed like content: a collection at `/admin/content/me-template`, add/edit/delete forms under `/me-template/*`, and a bundle-settings route `entity.me_template.settings` at `/admin/structure/me-template` that is the Field UI base route (so you can add fields to templates). It ships **seven permissions** (administer/overview/create/view/edit/delete/use) and no config schema of its own — templates are content, not config. Depends on `mercury_editor`.

---

- Save a designed hero section as a reusable template for other pages.
- Build a library of pre-styled section templates for editors to drop in.
- Let content authors insert a "call to action" block layout without rebuilding it.
- Standardise recurring page sections (feature grid, testimonial row) across a site.
- Speed up page creation by starting from an approved template.
- Restrict who can create templates vs who can merely use them via permissions.
- Publish/unpublish templates to control which appear in the add-component menu.
- Add custom fields to the me_template entity via its Field UI settings route.
- Manage all saved templates from the /admin/content/me-template overview.
- Edit an existing template's stored components and re-save.
- Delete obsolete section templates from the collection page.
- Give a marketing team a curated set of layouts to assemble landing pages.
- Anonymise or unpublish a user's templates when their account is cancelled.
- Reuse a complex nested Layout Paragraphs structure without copy-pasting.
- Keep template insertion within the layout's allowed nesting depth automatically.
- Grant "use mercury editor templates" to editors so templates show in their builder menu.
- View a single template's rendered output at its canonical /me-template/{id} page.
- Seed a new site section from a template created on another page.
- Provide a template overview for site builders under Structure.
- Control template administration with the "administer mercury editor template" permission.
