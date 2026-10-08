<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nyan cat progress bars (nyan) — agent index

**Replaces Drupal's progress bar (batch/AJAX) with a customizable Nyan-cat animation.**

- **Version:** 2.0.x
- **Core:** ^9.3 || ^10
- **Depends:** none
- **Configure:** `/admin/config/system/nyan` (route `nyan.config`, permission `administer nyan`, `restrict access: true`).

**Surface:** settings form (`NyanSettingsForm`); config `nyan.nyansettings`; a JS/CSS library that restyles the progress bar. No content routes.

**Security:** purely cosmetic; no data handling or external calls. Configuration behind `administer nyan`.
