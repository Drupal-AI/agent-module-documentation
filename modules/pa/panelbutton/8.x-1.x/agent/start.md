<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Panel Button (panelbutton) — agent index

**Utility CKEditor 4 plugin that provides the shared floating-panel UI required by other CKEditor button plugins (e.g. Color Button).**

- **Version:** 8.x-1.x (info.yml `8.x-1.5`)
- **Core:** ^8 || ^9 || ^10 (Drupal 10 contrib, CKEditor **4** only — CK4 removed from D10 core)
- **Dependencies:** `ckeditor` (contrib CK4); external `panelbutton` JS lib (v4.5.6+) in `/libraries`.
- **Plugin:** `src/Plugin/CKEditorPlugin/PanelButton.php`; exposes no buttons itself — a dependency for other plugins.

**Security:** editor-plugin dependency only; no routes, permissions, config, or request handling.
