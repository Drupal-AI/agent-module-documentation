<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings, config UIs, install behavior

## Config object `n1ed.settings`
Set on install (`n1ed_install`) and via the UIs/controllers:
- `apikey` (string) — N1ED cloud API key. Default is a shipped demo key `N1D824RR` (or `FLMN24RR` for the
  Flmngr integration). Set a real key to unlock cloud services. Written by `POST /admin/config/n1ed/setApiKey`
  (form field `n1edApiKey`) or by editing config.
- `integrationType` (string) — `n1ed` | `flmngr` | `txt42`; resolved by calling
  `https://cloud.n1ed.com/a/<apikey>/config-integration-type.json` and cached.
- `useFlmngrOnFileFields` (bool, default TRUE) — attach the Flmngr file manager to core `image_image` /
  `file_generic` widgets (only for users with `administer flmngr files`).
- `useLegacyFlmngrBackend` (bool, default FALSE) — use `/flmngr-legacy` instead of `/flmngr`.
- `version` (string) — pin an N1ED editor version, blank = latest. Set via advanced form.
- `urlCache` (string) — custom cache server URL, blank = caching disabled. Set via advanced form.
- `installedAt` (int), `token` (nullable) — internal.

## Where you actually configure it
- **Primary (per text format):** *Configuration → Content authoring → Text formats*
  (`/admin/config/content/formats/manage/<format>`). N1ED lives inside the CKEditor toolbar/plugin config.
  Enabling toggles the plugin flag `enableN1EDEcoSystem` (`"true"`/`"false"`). The Text Formats overview
  (`filter.admin_overview`) shows an N1ED/Flmngr badge on enabled formats.
- **Advanced form:** `/admin/config/content/n1ed` (`n1ed.config`, form `N1EDConfigForm`, permission
  `administer site configuration`) — only `version` and `urlCache`. Warns it is for advanced users.

## Install / update behavior (`n1ed.install`)
- `n1ed_install()` creates `public://flmngr`, `public://flmngr-tmp`, `public://flmngr-cache`,
  sets the demo `apiKey`, then runs `n1ed_update_text_formats(TRUE)`.
- `n1ed_update_text_formats()` auto-attaches N1ED to formats whose editor is `ckeditor`/`ckeditor5` and that
  are NOT restricted by `filter_html`/`filter_html_escape` (i.e. Full-HTML-style). For `full`/`full_html` it
  will even disable those filters to attach. It also reorders N1ED formats to the top of the format list.

## CKEditor 5 plugin
`n1ed_flmngr_ckeditor5` (`Plugin/CKEditor5Plugin/N1ED`): injects `flmngr.apiKey`, `urlFileManager`
(`n1ed.flmngr` route), and `urlFiles` (`public://flmngr` path) into the editor via `getDynamicPluginConfig()`.
Config schema: `ckeditor5.plugin.n1ed_flmngr_ckeditor5` (single `enableN1EDEcoSystem` string).

Note: the module contacts `cloud.n1ed.com` and loads editor assets from the N1ED CDN; it is not self-hosted.
