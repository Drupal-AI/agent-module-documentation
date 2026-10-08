<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up User Field Anonymize

## 1. Module settings — admin only
Route `user_field_anonymize.settings` at `/admin/config/people/user_field_anonymize` (permission **administer user field anonymize configuration**, restrict access). Stored in `user_field_anonymize.settings`:
- **Restrict to roles** — which roles/options (`restrict_to_roles`, plus special `enable_all_users` / `enable_admin_users`) users are allowed to grant data access to.
- **Field types** — map each field type to an anonymize plugin (`field_options[<type>].plugin_id`), e.g. `datetime → user_field_anonymize_date`, `image → user_field_anonymize_image`, everything else `user_field_anonymize_default`.

## 2. Enable anonymization on a field
Edit a **user** account field's config form. If a plugin exists for that field type, an **Anonymization** fieldset with **Enable anonymization** appears; the value is saved as third-party setting `user_field_anonymize.enabled` (plus any plugin value under `.value`).

## 3. Per-user allow-list
Each user visits the **Privacy settings** tab `/user/{user}/anonymize` (route `entity.user.anonymize_form`) — needs **set user profile anonymity** AND edit access (`user.update`) on that account. "Who can consult my data" checkboxes write the `allowed_options` base field. The same form is available via the **User Field Anonymize Form** block (block access = `set user profile anonymity`, always renders the *current* user's form).

## Access decision at display (`user_field_anonymize_user_allowed`)
For a viewer + target user: allowed if `any user` opted in, or viewer has an admin role and `only admin` set, or viewer's roles intersect the target's `allowed_options`. If not allowed and the field is anonymize-enabled, the plugin renders the masked value; base fields (no third-party settings) are forbidden outright. Default when the target set nothing: `authenticated` (so only anonymous viewers are masked).
