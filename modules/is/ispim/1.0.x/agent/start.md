<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Style Preview Image Manager (ispim) — agent index

**Adds an `ispim_preview_image` content entity so admins curate the sample images used to preview image styles.**

- **Version:** 1.0.x (1.0.0-alpha1)
- **Core:** ^10 || ^11 · **Depends:** file, image · **Package:** Media
- **Configure:** `entity.ispim_preview_image.collection` → `/admin/config/media/ispim-preview-image`
- **Settings route:** `entity.ispim_preview_image.settings_form` (perm `ispim.ispim_preview_image.settings.admin`).
- **Permissions:** dedicated settings admin perm + entity permissions via `PermissionProvider` (all `restrict access: true`).
- **Drush:** `PreviewImageCommands` — create preview-image entities from local files.
- **JS:** `ispim.preview-image.js` swaps the previewed image via `drupalSettings.ispim`.
- **Security:** all routes permission-gated; no anonymous/mutating public endpoints; no external calls. `createFile()` `file_get_contents()` reads an operator-supplied CLI path only (ispim/src/Commands/PreviewImageCommands.php:152). No findings.

See [configure/preview-images.md](configure/preview-images.md) and [drush/commands.md](drush/commands.md)
