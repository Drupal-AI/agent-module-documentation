<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Professional Directory (professional_directory) — agent index
**Moderated professional directory: public signup, admin validation, private member area and mutual contact requests.**

- **Version:** 1.0.x  **Core:** ^9.5 || ^10 || ^11  **Depends:** file, link
- **Entity:** `professional_directory` (`Profesional`) with accreditation file, `validated`/`rejected`/`user_id` fields.
- **Public routes (`_access: TRUE`):** `/professional-directory/signup` (apply), `/professional-directory/private-area` (redirects anon to login; loads only current user's validated profile).
- **Guarded download:** `/professional-directory/accreditation/{file}` via `AccreditationDownloadController::access` — admin OR the authenticated owner of a validated, non-rejected profile.
- **Admin routes (perm `administer professional directory`):** overview `/admin/content/professional-directory`, settings `/admin/config/professional-directory`.
- **Permissions:** `administer professional directory` (restricted), `access professional directory private area`.
- **Security:** handles member PII. `_access: TRUE` routes self-guard: private area is per-user (own validated profile only), signup is deliberately public, accreditation download enforces owner/admin — no IDOR observed. Admin surfaces permission-gated. Reviewed sound.

See [configure/setup.md](configure/setup.md)
