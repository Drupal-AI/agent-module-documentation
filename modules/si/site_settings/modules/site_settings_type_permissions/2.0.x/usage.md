<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Settings and Labels Type Permissions turns the parent module's site-wide site-settings permissions into **per settings type** permissions, so a role can be allowed to edit one setting without being allowed to edit them all.

---

The submodule adds no UI, no config, no services and no routes: it is a dynamic permission callback plus three hooks. `SiteSettingTypePermissions::siteSettingTypePermissionsList()` (wired up through `permission_callbacks` in `site_settings_type_permissions.permissions.yml`) loops over every `site_setting_entity_type` config entity and generates eight permissions for each — view published, view unpublished, create, edit, delete, view revisions, revert revisions and delete revisions — named after the type machine name, e.g. `edit phone_number site setting`. `hook_ENTITY_TYPE_access()` for `site_setting_entity` then answers view/update/delete and the four revision operations by checking the **global** permission OR the type-specific one, statically caching the result per user, type, operation and (for view) published state; anything outside that operation list returns neutral. `hook_ENTITY_TYPE_create_access()` does the same for `create`, allowing the user if they hold either `add site setting entities` or `create <type> site setting`. Finally `hook_views_pre_render()` post-filters the `site_settings` View, dropping rows whose entity the current user cannot `view`, because Views table rows do not run entity access themselves. Note that because these hooks return **forbidden** (not neutral) when neither permission is held, enabling the submodule makes site-settings access strictly permission-driven for every non-admin role.

---

- Let a marketing role edit the "Social links" setting but not the "API endpoint" setting.
- Give a client edit rights to labels while keeping technical settings admin-only.
- Allow a role to create additional entries of one repeatable settings type only.
- Prevent editors from deleting settings while still allowing edits.
- Expose some settings to anonymous visitors and keep others unpublished and hidden.
- Grant a "content approver" role permission to view and revert revisions of one settings type.
- Restrict who may delete revisions of a sensitive setting.
- Keep the Site Settings overview usable for a role that may only see two of ten types.
- Filter the site settings Views listing per user so rows they cannot view disappear.
- Model a multi-team site where each team owns its own settings types.
- Combine a global `edit site setting entities` grant for admins with narrow per-type grants for editors.
- Delegate translation-team access to only the label settings.
- Lock down a "feature flag" setting to developers while opening copy settings to editors.
- Audit which roles can touch a specific settings type by grepping role permissions for its machine name.
- Give a support role read-only access to a settings type holding contact details.
- Allow a role to view unpublished (draft) values of one settings type before publication.
- Roll out per-type permissions incrementally by enabling the submodule after the types exist.
- Avoid writing a custom access handler for site settings.
- Keep `administer site setting entities` restricted while still delegating day-to-day edits.
- Ensure a newly created settings type immediately has its own eight permissions available.
