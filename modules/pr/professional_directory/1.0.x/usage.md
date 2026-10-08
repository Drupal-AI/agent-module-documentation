<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Professional Directory provides a moderated directory of professionals: visitors self-register, an administrator validates or rejects each profile, and approved members get a private area where they can send and accept mutual contact requests.

---

Signup (`/professional-directory/signup`) is intentionally open (`_access: TRUE`) so prospective members can apply; it stores a `professional_directory` entity with an accreditation file upload and marks it unvalidated. The private area (`/professional-directory/private-area`, also `_access: TRUE`) redirects anonymous users to login and then loads only the *current* user's validated profile — an unvalidated or rejected account sees a "not yet validated" message, so no cross-user data leaks. Accreditation file downloads are guarded by a custom access callback (`AccreditationDownloadController::access`) that allows only administrators or the authenticated professional who owns a validated, non-rejected profile, then streams the file — preventing IDOR on uploaded documents. Admin management, moderation and settings all require `administer professional directory`. Mutual-contact logic and notifications are handled by `ProfessionalManager` and `InterestStorage`.

Set up by enabling the module (with file + link), configuring notifications and options at `/admin/config/professional-directory`, granting `access professional directory private area` to members, and moderating incoming signups from `/admin/content/professional-directory`.

---
- Let professionals self-register through a public signup form.
- Require an accreditation file upload at signup.
- Moderate profiles: validate or reject each application.
- Give approved members a private area page.
- Send and accept mutual contact requests between members.
- Redirect anonymous visitors from the private area to login.
- Restrict a member's private area to their own validated profile.
- Stream accreditation downloads only to owner or admin (no IDOR).
- Show approved profiles as cards in the private directory.
- Configure notification emails for signups and requests.
- Manage all profiles from the admin overview.
- Reject a profile and keep it out of downloads/listings.
- Redirect professional profile URLs via the event subscriber.
- List professionals with the custom list builder.
- Store contact interests via InterestStorage.
- Gate all administration behind `administer professional directory`.
- Grant private-area access with a dedicated permission.
- Collect professional PII (profile + accreditation) under moderation.
- Theme the directory cards and private area with provided templates.
- Let members browse only after their profile is validated.
