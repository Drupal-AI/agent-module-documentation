<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mercury Editor replaces Drupal's standard entity edit form with a full-screen, drag-and-drop page builder (a live-preview canvas plus an "edit tray") built on Layout Paragraphs and Style Options.

---

Mercury Editor is an editorial UX layer over `layout_paragraphs`: for each bundle you enable, it swaps the normal node/term/block-content edit form for its own edit screen at `/mercury-editor/{entity}`, where components (paragraphs) are inserted, dragged, and styled with instant preview in an iframe. Which bundles use it is stored in the single config object `mercury_editor.settings` under the `bundles` map (e.g. `bundles.node.landing_page: landing_page`); the same config holds the edit-tray theme (`edit_screen_theme`), mobile preview presets, dialog defaults, and tray width. It registers a `mercury_editor` entity form handler (via `hook_entity_type_build`) for supported entity types, a param converter and custom controllers/routes that replace the Layout Paragraphs builder routes, a theme negotiator for the editor screen, and an AJAX middleware/dialog system (its own `openMercuryDialog`/`closeMercuryDialog` commands). Configuration lives at `/admin/config/content/mercury-editor` (route `mercury_editor.settings`, permission "administer site configuration") with sub-forms for Skip-create-form, Menu, and Dialog/UI settings. It ships no permissions of its own and no Drush; access is governed by core "administer site configuration" plus the underlying Layout Paragraphs/entity permissions. Two submodules extend it: **Mercury Editor Templates** (reusable section templates as a `me_template` entity) and the **deprecated** Mercury Editor Inline Editor (superseded by `mercury_editor_live_edit`).

---

- Give editors a drag-and-drop, live-preview page builder instead of a long stacked node form.
- Enable Mercury Editor on a "Landing page" content type for marketing pages.
- Build multi-section layouts from Layout Paragraphs components with instant visual feedback.
- Insert, reorder, duplicate, and delete components on a canvas without page reloads.
- Apply Style Options (spacing, colours, backgrounds) to sections and components visually.
- Preview a page at mobile widths using configurable device presets (e.g. iPhone 12 Pro).
- Add custom mobile preview presets in `name|width|height` format on the settings form.
- Use a dedicated admin theme (e.g. Gin) for the edit tray via `edit_screen_theme`.
- Widen or narrow the editing tray with the `dialog_tray_width` setting.
- Skip the create form for chosen paragraph types so components insert immediately.
- Author taxonomy terms and block-content entities with the same builder (supported bundles).
- Keep changes in a private tempstore so edits are previewed before saving the entity.
- Provide a Layout Builder-style experience without using core Layout Builder.
- Standardise component styling across a site using Style Options presets.
- Replace the default node edit route so "Edit" opens the Mercury canvas.
- Configure dialog width/height/behaviour defaults for component edit modals.
- Save a reusable section as a template with the Mercury Editor Templates submodule.
- Let editors drop pre-built section templates into a page to start faster.
- Group builder menu components for a tidier "add component" list.
- Roll out consistent page-building UX to many content types from one settings page.
- Integrate with Entity Browser / Media Library modals inside the builder.
- Disable contextual links in the preview so the canvas stays clean.
- Migrate an existing paragraphs-based content type to a modern editing experience.
