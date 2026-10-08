<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup and moderation

## Enable & configure
1. `drush en professional_directory` (pulls `file`, `link`).
2. Settings at `/admin/config/professional-directory` (`SettingsForm`) — notification emails, options.
3. Grant `access professional directory private area` to member roles; keep `administer professional directory` to staff.

## Lifecycle
- **Apply:** `/professional-directory/signup` (`ProfesionalSignupForm`, public) creates an unvalidated `professional_directory` entity with an accreditation file.
- **Moderate:** `/admin/content/professional-directory` (`AdminOverviewForm`) — validate or reject.
- **Member area:** `/professional-directory/private-area` — anon → login; authenticated → only the caller's own validated profile (`loadValidatedProfessionalByUserId`). Unvalidated/rejected users get a notice.
- **Contact requests:** `PrivateAreaForm` + `ProfessionalManager`/`InterestStorage` handle mutual requests and notifications.

## File access (IDOR-safe)
`/professional-directory/accreditation/{file}` → `AccreditationDownloadController::access`: allowed only for
`administer professional directory` OR the authenticated user whose validated, non-rejected profile references that file id.
