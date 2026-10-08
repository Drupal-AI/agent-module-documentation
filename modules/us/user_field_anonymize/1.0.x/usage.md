<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Field Anonymize replaces the displayed values of chosen user-account fields with placeholder ("anonymized") values for viewers whose role is not on the target user's allow-list.
---
This is display-time field-access control, not a destructive data wipe: the stored field values are untouched, but `hook_entity_field_access` (view) and render/Views hooks decide, per viewer, whether the real value is shown or a plugin-provided anonymized value is rendered instead. A site admin first enables anonymization on individual user fields (a checkbox added to the field-config edit form for user fields that have a matching plugin) and, at `/admin/config/people/user_field_anonymize`, chooses which roles/options users may grant access to and maps each field type to an anonymize plugin. Each user can then set their own "Who can consult my data" allow-list on a `/user/{user}/anonymize` privacy tab (also available as a block). Anonymize plugins (`user_field_anonymize_default`, `_date`, `_image`) are managed by a custom plugin manager and produce the masked build for a field type.

Access posture: the settings route requires `administer user field anonymize configuration` (restrict access: true); the per-user anonymize form requires both `set user profile anonymity` (restrict access: true) **and** `_entity_access: user.update` on the target user, so a user can only set anonymity on an account they may already edit — there is no unauthenticated or cross-user mutation path. Note the *default* allow-list when a user has set nothing is `authenticated`, i.e. by default only anonymous visitors are masked; admins (roles with `isAdmin()`) always see real values. A `random_int()` call in the settings form is only used to de-duplicate form keys, not for security.
---
- Mask selected user profile fields from unauthorized viewers
- Let each user choose which roles may see their data
- Enable per-field anonymization from the field-config edit form
- Configure allowed roles/options at the module settings page
- Map field types (date, image, default) to anonymize plugins
- Show anonymized placeholder values in user page displays
- Show anonymized values inside Views that list user fields
- Expose a self-service "privacy settings" tab per user
- Place the anonymize form as a block for the current user
- Keep the real field data stored while hiding it at display time
- Default-hide fields from anonymous visitors only (authenticated default)
- Always let admin-role users see the real values
- Grant "any user" visibility when a user opts in
- Support GDPR-style "who can see my profile data" controls
- Restrict the roles offered to users via the settings form
- Add new field-type support with a custom anonymize plugin
- Anonymize datetime/daterange fields via the date plugin
- Anonymize image fields via the image plugin
- Audit which user fields have anonymization enabled (third-party setting)
- Grant the *set user profile anonymity* permission to trusted roles only
