<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
My CKE Button lets you create custom text styles in a form and apply them with a dedicated button in the CKEditor toolbar.

---

The module provides an admin form at `/admin/config/content/myckebutton-styles` (`MyCKEButtonConfigForm`, gated by the `access myckebutton config` permission) where you define named styles, and a `CKEditorPlugin` (`src/Plugin/CKEditorPlugin/MyCKEButton.php`) that registers a toolbar button applying those styles inside CKEditor 4. Styles are stored as configuration (`ckeditor.plugin.myckebutton`) with a schema, and the button/JS are provided via the module's library.

Because it depends on the legacy `ckeditor` (CKEditor 4) module, it targets sites still on that editor rather than CKEditor 5. There are no server-side content routes beyond the config form; the styling is applied client-side in the editor. Access to define styles is limited to the configuration permission, and rendered markup goes through the text format's normal filtering.

---
- Give editors a one-click button for a site-specific text style.
- Define custom inline styles without editing CKEditor config by hand.
- Apply brand-approved formatting consistently across content.
- Add multiple named styles selectable from one toolbar button.
- Let non-technical admins manage editor styles via a form.
- Standardise callouts, highlights, or lead paragraphs.
- Keep custom styles in exportable configuration.
- Extend CKEditor 4 toolbars with bespoke styling.
- Enforce a house style for emphasis or annotations.
- Avoid teaching editors raw HTML/CSS for common styles.
- Restrict who can manage the styles with a dedicated permission.
- Ship the button per text format that includes the plugin.
- Provide quick formatting shortcuts for repeated patterns.
- Reduce inconsistent inline styling across authors.
- Maintain styling rules centrally instead of per-node.
- Support legacy CKEditor 4 sites needing custom buttons.
