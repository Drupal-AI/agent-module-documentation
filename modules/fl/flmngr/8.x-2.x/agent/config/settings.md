<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flmngr — install, configuration, and integration

Flmngr (`flmngr`) is an integration shell. It has **no routing, permissions, services, plugins, or
config schema of its own** — `flmngr.routing.yml` and `flmngr.permissions.yml` are both empty and
there is no `src/` or `config/` directory. Everything below is what flmngr *does* (an install-time
config edit) and *where the actual features live* (the `n1ed` dependency).

## Install / enable

- `composer require drupal/flmngr` — Composer pulls in **`drupal/n1ed`** (`require` in
  `composer.json`; also `dependencies: - drupal:n1ed` in `flmngr.info.yml`, so Drupal enables n1ed
  as a dependency). Core requirement `^8 || ^9 || ^10 | ^11`; package `CKEditor`.
- `drush en flmngr -y`. Enabling flmngr enables n1ed too. No CKEditor dependency is declared in
  info.yml on purpose (a comment explains N1ED supports CKEditor 4 and 5 and Drupal has no optional
  module deps), so CKEditor is treated as an optional runtime dependency.

## What `flmngr_install()` does (`flmngr.install`)

The install hook mutates the **`n1ed.settings`** config object (config owned by n1ed):

1. Reads N1ED's current API key via `n1ed_get_api_key("CKEditor")` and `installedAt`.
2. If the key is still the demo key `"N1D8N1ED"` **and** N1ED was installed within the last 5
   minutes (i.e. flmngr brought it in), sets `apikey = "FLMN24RR"` and `integrationType = "flmngr"`.
3. If `integrationType === "flmngr"`, calls `flmngr_set_ckeditor_toolbar()` (below). Otherwise, for
   a non-Flmngr key with a `token`, there is only a `@todo` comment to call
   `https://cloud.n1ed.com/api/v1/conf/set-flmngr-enabled` — **no request is actually made**.
4. Calls `n1ed_update_text_formats(FALSE)` (n1ed) to fix text-format info.
5. Sets `useFlmngrOnFileFields = TRUE` (so the file manager attaches to file/image field widgets).
6. Saves config and runs `drupal_flush_all_caches()`.

Also logs (via `error_log`) the N1ED install time and current time — an informational trace.

### `flmngr_set_ckeditor_toolbar()`

Iterates `filter_formats()`; for each format with an editor where `editor == "ckeditor"` (CKEditor
4) and whose settings contain the `plugins.N1EDEco` key, it ensures these buttons are on the
toolbar: `Upload`, `Flmngr`, `Image`, `ImagePreview2`, `ImageGallery2`. Any missing ones are
appended as a new button group named `Flmngr` in the **last** toolbar row, then the editor is
saved. This only touches CKEditor 4 formats; CKEditor 5 toolbars are configured manually (add the
Flmngr buttons inside the Full HTML format — see the help page).

## Configuration (runtime)

- flmngr has **no settings route** (`configure` is null; nothing in `*.links.menu.yml`).
- You configure Flmngr **per text format**: Configuration → Content authoring → **Text formats**
  (`filter.admin_overview`). Formats where Flmngr is enabled show a **"Flmngr"** badge; open a
  format and use the CKEditor configuration widget to change options, then Save.
- Recommendation from `flmngr_help()`: enable Flmngr in formats used by administrators / article
  editors (e.g. Full HTML), disable it in restricted formats (comments, etc.).
- Help page: `admin/help/flmngr` (`flmngr_help()` in `flmngr.module`) — About / Installation /
  Configuration / Using file manager / Troubleshooting text, linking to https://flmngr.com/docs.

## Where the features and the file-manager backend live (n1ed)

flmngr exposes no endpoint. The browse/upload/manage backend and the CKEditor plugins are all in
**`n1ed`**:

- Routes (`n1ed.routing.yml`): `n1ed.flmngr` → `/flmngr` (`Drupal\n1ed\Controller\FlmngrController::flmngr`)
  and `n1ed.flmngrLegacy` → `/flmngr-legacy` (`FlmngrControllerLegacy::flmngr`). Both require
  **permission `administer flmngr files`** and a **CSRF request-header token**
  (`_csrf_request_header_token: 'TRUE'`). Config/admin routes require `administer n1ed configuration`
  / `administer site configuration`.
- The controllers call `Drupal\n1ed\Flmngr\FlmngrServer::flmngrRequest()` against local storage
  dirs resolved with `file_system->realpath()`: `public://flmngr` (files), `public://flmngr-tmp`
  (temp), `public://flmngr-cache` (cache).
- Permissions (`n1ed.permissions.yml`): `administer flmngr files` ("Manage files and images") and
  `administer n1ed configuration` ("Change N1ED settings"). flmngr itself defines none.
- File-field attachment: `Drupal\n1ed\N1edFileField` (gated by `useFlmngrOnFileFields`, which the
  flmngr install hook turns on). CKEditor plugins: `Drupal\n1ed\Plugin\CKEditor5Plugin\N1ED` and
  `Drupal\n1ed\Plugin\CKEditorPlugin\N1ED`. Config form: `Drupal\n1ed\Form\N1EDConfigForm` at
  `/admin/config/content/n1ed`.

To audit or document the file-manager route permissions, allowed extensions, path handling, and
storage, look at the **`n1ed`** module — that is where the controllers and `FlmngrServer` live.
