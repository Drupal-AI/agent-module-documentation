<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupella File Manager (dfm) — agent index

**Ajax drag-drop file manager at `/dfm/{scheme}` gated by per-role, per-scheme `dfm_profile` config entities; integrates with CKEditor5/BUEditor/file fields.**

- **Version:** 2.1.x
- **Core:** ^9.3 || ^10 || ^11
- **Routes:** `dfm.page` `/dfm/{scheme}` (`_custom_access: DfmController::checkAccess` → `Dfm::access` = user has a profile for the scheme); `dfm.admin` `/admin/config/media/dfm` (`_permission: administer dfm`); `dfm_profile` add/edit/delete/duplicate (entity access).
- **Config entity:** `dfm_profile` (`admin_permission = administer dfm`; stores folder rules + perms in `conf`). Settings: `dfm.settings` (`roles_profiles`, `merge_folders`, `abs_urls`, `textareas`).
- **Engine:** file operations run in a bundled library (`library/core/Dfm.php`) loaded by `Dfm::userFm()`; `DfmDrupal` plugin hooks sync `file_managed`, quotas and body references.
- **Traversal guard:** `Dfm::regularPath()` rejects `\`, `.` and `..` segments; optional chroot jail.
- **Security:** admin routes permission-gated; `/dfm` access requires an assigned profile (fail-closed by default: `roles_profiles` empty). Uploads run core validators + `allow_insecure_uploads`; DB uses parameterized queries. Assigning a profile to anonymous/authenticated exposes file ops to them.

See [configure/profiles.md](configure/profiles.md)
