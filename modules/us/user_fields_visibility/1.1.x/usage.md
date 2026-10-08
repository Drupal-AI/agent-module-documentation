<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Fields Visibility allows users to decide which of their profile fields are visible.

---

User Fields Visibility lets **users choose which of their own profile fields are visible to others** — a
per-user privacy control over profile fields (email, phone, custom fields). It integrates with the Field
Permissions module (a hard dependency), provides its own permissions, in the Fields package.

Use it to give users profile-field privacy. It is an access-control/privacy feature and it is implemented
**correctly**: enforcement is a Field Permissions plugin (`hasFieldAccess`) that runs at the **field-access
layer**, so it is respected everywhere — rendered profiles, **JSON:API, REST and Views** alike (not just the
HTML profile page). The logic: admins (`administer users`) and the field's owner always see it; otherwise a
field is visible only if the owner marked it visible (fields default to visible until configured). The settings
form itself is gated (`administer users`, or `set own profile fields visibility` on one's own account). Because
access is enforced at the field layer, hidden values do **not** leak through the API — a common failure this
module avoids. Grant `set own profile fields visibility` to let users control their own fields.

---

- Let users set profile-field visibility.
- Give per-user profile privacy.
- Cover email/phone/custom fields.
- Depend on Field Permissions (hard dep).
- Provide its own permissions.
- Enforce via a Field Permissions plugin.
- Enforce at the FIELD-ACCESS layer.
- Be respected by JSON:API/REST/Views (not just HTML).
- Not leak hidden values through the API.
- Let admins/owner always see; others per owner's choice.
- Default fields to visible until configured.
- Gate the settings form appropriately.
- Handle field visibility.
- Hide fields.
- Configure the visibility.
- Control profile fields.
- Handle the privacy.
- Restrict fields.
- Grant the own-visibility permission.
- Provide profile-field privacy.
