<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
N1ED is a cloud-backed add-on that supercharges CKEditor (4 and 5) with the N1ED visual/Bootstrap editor, the Flmngr file manager, and the ImgPen image editor, loading the editor front-end from the N1ED CDN using an API key.

---

On install the module attaches itself to "full"-style text formats (those without `filter_html`/`filter_html_escape` restrictions) by setting the CKEditor plugin flag `enableN1EDEcoSystem = true`, and creates `public://flmngr`, `public://flmngr-tmp`, and `public://flmngr-cache` directories for the Flmngr file manager. It stores its settings in `n1ed.settings` (`apikey`, `integrationType`, `useFlmngrOnFileFields`, `useLegacyFlmngrBackend`, `version`, `urlCache`). The editor's JavaScript is loaded from `cloud.n1ed.com`/CDN and keyed by the API key; a shipped **demo** key is used until you link a real N1ED account. The module also provides a **Flmngr file-manager backend** at the routes `/flmngr` and `/flmngr-legacy` (permission `administer flmngr files`), a self-contained PHP file-manager server (`src/Flmngr/*`) that lists, uploads, renames, moves, copies, deletes, and resizes files under `public://flmngr`. Optionally (`useFlmngrOnFileFields`) it wires Flmngr into core image/file field widgets. Main configuration is per text format under *Configuration → Content authoring → Text formats* using the N1ED/CKEditor widgets; a secondary advanced form lives at `/admin/config/content/n1ed`. It works with both CKEditor 4 (legacy) and CKEditor 5 (`n1ed_flmngr_ckeditor5` plugin). Note: the online N1ED ecosystem features require the cloud service and a valid key; the module contacts `cloud.n1ed.com` to resolve the integration type.

---

- Add the N1ED visual/Bootstrap page builder to a rich-text (Full HTML) format's CKEditor.
- Give editors a full file manager (Flmngr) inside CKEditor for browsing and uploading images/files.
- Provide in-browser image editing (crop, rotate, effects) via ImgPen in the editor.
- Insert responsive images and Bootstrap grid/components into WYSIWYG content.
- Attach the Flmngr file manager to core image and file field widgets (`useFlmngrOnFileFields`).
- Link a free/paid N1ED cloud account by setting a real API key to unlock online services.
- Configure N1ED per text format, enabling it only on formats meant for trusted content editors.
- Use N1ED with CKEditor 5 via the `n1ed_flmngr_ckeditor5` plugin (upload / insert / edit-image toolbar items).
- Keep compatibility with existing CKEditor 4 setups on older sites.
- Manage uploaded files (rename, move, copy, delete, resize) from a single file-manager UI.
- Pin the N1ED editor to a specific version, or track latest, via the advanced settings form.
- Point N1ED at a custom cache server URL (or disable caching) in advanced settings.
- Toggle between the new and legacy Flmngr backend.
- Show an "N1ED"/"Flmngr" badge next to formats where the ecosystem is enabled on the Text Formats list.
- Auto-bubble N1ED-enabled formats to the top of the format selector on edit forms.
- Build landing-page-style content inside a node body without a separate page builder module.
- Provide a fullscreen editing mode for long-form content authoring.
- Store file uploads under a dedicated `public://flmngr` directory tree.
