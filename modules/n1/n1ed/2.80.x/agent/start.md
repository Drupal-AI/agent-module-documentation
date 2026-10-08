<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# N1ED — agent index

Cloud-backed CKEditor 4/5 add-on: N1ED visual editor + Flmngr file manager + ImgPen image editor. Editor
front-end loads from the N1ED CDN keyed by an API key. Ships a PHP file-manager backend under `public://flmngr`.
No info.yml `configure` route (config is per text format), config object `n1ed.settings`. No Drush.

- **Settings (`n1ed.settings`), the two config UIs, per-format enabling, install behavior, CDN/API key** →
  [configure/settings.md](configure/settings.md)
- **Permissions (`administer flmngr files`, `administer n1ed configuration`) and the Flmngr/config routes** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Enabled per text format via CKEditor plugin flag `enableN1EDEcoSystem = "true"` (CKEditor4 key `N1ED-editor`,
  CKEditor5 key `n1ed_flmngr_ckeditor5`). Install auto-enables it on `full`/`full_html`-style formats.
- API key stored at `n1ed.settings:apikey`; a hardcoded **demo** key (`N1D824RR` / `FLMN24RR`) is the shipped default.
- Flmngr backend routes: `/flmngr`, `/flmngr-legacy` (perm `administer flmngr files` + CSRF token). File-manager
  server code is `src/Flmngr/*`, operating on `public://flmngr`.
