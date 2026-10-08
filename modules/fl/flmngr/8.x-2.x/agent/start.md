<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flmngr (flmngr) — agent index

Thin **bootstrap/integration** module that pairs the **Flmngr** file manager + image editor with
CKEditor. Package `CKEditor`. Core `^8 || ^9 || ^10 | ^11`. License GPL-2.0-or-later. Version
**8.x-2.15**.

- **Install/enable, what the install hook does, how it wires N1ED, where the backend lives** →
  [config/settings.md](config/settings.md)

## What it actually is

- **Hard dependency `drupal/n1ed`** (info.yml `dependencies: - drupal:n1ed`; composer `require`).
  All real functionality lives in **n1ed**, not here.
- flmngr's entire codebase: `flmngr.info.yml`, `flmngr.module` (only `flmngr_help()`), and
  `flmngr.install`. **Empty `flmngr.routing.yml`** and **empty `flmngr.permissions.yml`**. No
  `src/`, no `config/`, no `*.services.yml`, no `*.libraries.yml`, no config schema, no Drush.
- So flmngr provides **no routes, no controllers, no permissions, no services, no plugins** of its
  own. It exists to (a) pull in n1ed and (b) auto-configure n1ed for the Flmngr integration on
  install.

## The install hook (`flmngr.install`)

`flmngr_install()` edits the **`n1ed.settings`** config object (owned by n1ed, not flmngr):
- If N1ED's API key is still the default demo key `N1D8N1ED` and N1ED was installed <5 min ago,
  sets `apikey = FLMN24RR`, `integrationType = flmngr`.
- If `integrationType === 'flmngr'`, calls `flmngr_set_ckeditor_toolbar()` to append the buttons
  `Upload, Flmngr, Image, ImagePreview2, ImageGallery2` to each CKEditor 4 (`editor == ckeditor`)
  format that already has the `N1EDEco` plugin, into the last toolbar row (only buttons not
  already present).
- Sets `useFlmngrOnFileFields = TRUE`, calls `n1ed_update_text_formats(FALSE)`, saves config, and
  `drupal_flush_all_caches()`.
- Note: a branch for non-Flmngr keys is a `@todo` stub (would POST to `cloud.n1ed.com`) — currently
  a no-op.

## Where the file-manager backend really is (n1ed)

flmngr has no endpoint. The browse/upload/rename/delete backend is **n1ed's** — routes in
`n1ed.routing.yml`: `n1ed.flmngr` → `/flmngr` (`FlmngrController::flmngr`) and `n1ed.flmngrLegacy`
→ `/flmngr-legacy` (`FlmngrControllerLegacy::flmngr`), both gated by **`_permission: 'administer
flmngr files'`** plus **`_csrf_request_header_token: 'TRUE'`**. Server logic is
`n1ed\Flmngr\FlmngrServer` over local dirs `public://flmngr`, `public://flmngr-tmp`,
`public://flmngr-cache`. **Document/secure that surface under the `n1ed` module**, not here.

## Configuration

No config route in flmngr (`configure` = null). You configure Flmngr **per text format**:
Configuration → Content authoring → Text formats → a CKEditor format → the CKEditor config widget.
A "Flmngr" badge marks formats where it is enabled. Help page: `admin/help/flmngr`.
