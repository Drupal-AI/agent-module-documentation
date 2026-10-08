<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Navigation + supplies a shared, pluggable editing interface — an Edit Mode, a Photoshop-style tool toolbar, mode/sidebar plugin types, drag-to-upload media and per-user hotkeys — that the +Suite page-building modules (Edit+, Layout Builder+) plug into instead of each inventing its own toolbar.

---

Core's Navigation module replaced the old Toolbar; Navigation + extends that left sidebar into an editing surface. It defines three plugin types. **Modes** (`ModePluginManager`, `ModeInterface`, `#[Mode]`) replace the whole Navigation UI with a different top bar and toolbar — the module ships one, **Edit Mode** (`Plugin/Mode/Edit`), which makes the core Edit/Layout tabs obsolete. **Tools** (`ToolPluginManager`, `ToolInterface`, `#[Tool]`) are the buttons inside a mode's toolbar; the built-in `Pointer` tool is the neutral default and modules like Edit+ add editing tools. **Sidebars** (`SidebarPluginManager`, `SidebarInterface`, `#[Sidebar]`) contribute left/right panels bound to a mode and/or tool, revealed client-side via cookies so the wrappers never re-render on a mode switch. The whole UI is assembled by `NavigationPlusUi`, which preprocesses the `navigation`, `top_bar` and `field` theme hooks.

Editing happens against a tempstore (via `tempstore_plus`) so changes are staged before a Save commits them, and everything is wrapped so an AJAX call to `LoadEditablePage` can rebuild a page with editing attributes without a full reload. Editors can drag media files onto dropzones to create or replace media (`MediaUpload`), assign their own keyboard shortcuts, and, per content type/bundle, a site builder decides which modes are enabled and what the initial mode/default tool is (stored as `navigation_plus` third-party settings on the bundle). Three permissions separate the concerns: `use toolbar plus edit mode` (editors), `configure toolbar plus modes` (who decides which modes exist where), and `administer Navigation + configuration` (the settings page at `/admin/config/content/plus-suite`, which just sets the UI accent colors).

Two practical points. It is **Drupal 11 only** and depends on core `navigation` plus `twig_events` and `tempstore_plus`, so adopting it is a stack decision rather than a lone module install — in most real sites it arrives because `lb_plus`/`edit_plus` (the +Suite) require it. And its submodule `navigation_plus_entity_workflow` is **deprecated**: its functionality moved into the main module and it is slated for deletion.

---

- Turn core's Navigation sidebar into a page-editing surface.
- Provide one editing toolbar shared by several tool modules (Edit+, LB+).
- Enter and leave an "Edit Mode" on a content page.
- Register a custom editing tool as a `#[Tool]` plugin.
- Register a whole custom UI as a `#[Mode]` plugin (e.g. a Help mode).
- Add a left/right sidebar panel bound to a mode or tool via `#[Sidebar]`.
- Enable or disable editing modes per entity type and bundle.
- Configure a mode per bundle (e.g. its default tool) from the bundle edit form.
- Set the initial mode a bundle opens in after its first save.
- Give editors keyboard shortcuts (hotkeys) for switching tools.
- Let each editor save their own hotkeys and media file associations.
- Drag a file from the desktop onto a page to create a new media block.
- Drag a file onto an existing media to replace it in place.
- Stage edits in a tempstore and commit or discard them from the top bar.
- Reload a page over AJAX with all editing markup applied (`LoadEditablePage`).
- Edit a Layout Builder-managed block in isolation (`BlockPluginEdit`).
- Theme the editing UI accent colors site-wide.
- Track which view mode an entity is being edited in (`ViewModeTracker`).
- Integrate an editing flow with Workspaces so edits stay in one workspace.
- Separate who may edit from who may configure which modes exist.
- Build a consistent WYSIWYG editing experience across +Suite modules.
- Retire the deprecated `navigation_plus_entity_workflow` submodule.
- Audit which modes and tools a site has enabled per bundle.
