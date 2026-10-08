# IMCE Private Public Buttons — agent index

Adds CKEditor 5 toolbar buttons and admin tabs that open the IMCE file manager against the **private**
and **public** file schemes (core IMCE's CKEditor integration handles only one default scheme). No
config page (`configure` null), no permissions of its own, no Drush. Depends on `imce` ^3.1.

- **The four CKEditor 5 plugins, the toolbar/admin-tab wiring, and where access is actually enforced** →
  [plugins/ckeditor5.md](plugins/ckeditor5.md)

Key facts:
- Plugins (`src/Plugin/CKEditor5Plugin/`, all extend `CKEditor5PluginDefault`): `imce_private_image`,
  `imce_private_link`, `imce_private_public_image`, `imce_private_public_link` — drag into a text
  format's CKEditor toolbar.
- Two local task tabs under *Admin › Content* → IMCE's `imce.page` route with `scheme: public` /
  `scheme: private` (`imce_private.links.task.yml`).
- `imce_private.module` alters `editor_link_dialog` / `editor_image_dialog` to attach the private-input
  library when `Imce::access()` passes.
- **Access is enforced by IMCE core, not here.** `/imce/{scheme}` uses `_custom_access` →
  `ImceController::checkAccess` → `Imce::access($user, $scheme)`, true only if the user's role has an
  IMCE profile for that scheme. This module sets no permissions and blocks nothing itself.
