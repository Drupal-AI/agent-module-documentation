IMCE Private Public Buttons adds CKEditor 5 toolbar buttons and admin task tabs that open the IMCE file manager against the private and public file schemes, so editors can insert links and images from the non-default filesystem.

---

Core IMCE and its CKEditor integration browse a single (usually public) file scheme. This small add-on exposes both schemes: it defines four CKEditor 5 plugins — Imce Private Image, Imce Private Link, Imce Public Image, Imce Public Link (`src/Plugin/CKEditor5Plugin/*.php`, all extending `CKEditor5PluginDefault`) — each of which you drag into a text format's toolbar so the editor's image/link picker opens IMCE at `private://` or `public://`. It also adds two local task tabs ("IMCE public" and "IMCE private") under *Admin › Content* pointing at IMCE's `/imce/{scheme}` page, and alters the core `editor_link_dialog` and `editor_image_dialog` forms to attach IMCE-private input behavior when `Imce::access()` passes. The JS (`js/plugins/ckeditor5/imce_private.ckeditor5.js`) builds on IMCE's own `window.imceInput` helper. Crucially, this module **sets no permissions and enforces no access itself** — access to each scheme is decided server-side by IMCE core: the `/imce/{scheme}` route's `_custom_access` handler calls `Imce::access($user, $scheme)`, which returns true only if the user's role has an IMCE profile assigned for that scheme (configured at *Admin › Config › Media › IMCE*). So the private buttons only work for users whose roles are granted a private-scheme IMCE profile, and private file downloads still go through Drupal's private-file access pipeline. The project README recommends the "Private files download permission" module for setting private filesystem access rules. Requires IMCE ^3.1.

---

- Add a CKEditor 5 button to insert images stored in the private (`private://`) filesystem.
- Add a CKEditor 5 button to insert links to private files.
- Add CKEditor 5 buttons for public-scheme images and links when private is the default scheme.
- Let editors browse the private file directory from within the rich text editor.
- Attach files from a non-default file scheme in body text without leaving the editor.
- Provide "IMCE private" / "IMCE public" admin tabs to open the file manager for each scheme.
- Reference private documents (PDFs, etc.) in content while keeping them behind private-file access.
- Insert private images into WYSIWYG content on a site that stores uploads privately.
- Give specific roles a private-file browser button gated by their IMCE profile assignment.
- Keep public and private file browsing available side-by-side in the same editor.
- Support editorial workflows where draft/embargoed assets live in the private filesystem.
- Build text formats where private and public image insertion are separate, clearly labeled buttons.
- Open IMCE against `public://` explicitly even when the site default scheme is private.
- Integrate private-file browsing into the standard editor image/link dialogs.
- Reuse IMCE's existing per-scheme, per-role profile configuration for editor file access.
- Surface private-file management to content editors without granting broad admin permissions.
- Combine with "Private files download permission" to control who can download the browsed private files.
- Provide a consistent file-picker experience across public and private schemes for authors.
