<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Override Media Options allows non-admin users to override the default publishing options for media items they have permission to edit.

---

Override Media Options lets non-administrator users override the default publishing options (such as
published status) for media items they are permitted to edit — analogous to core's "override node
options" behaviour but for media. Normally only administrators can change certain media publishing
settings; this module grants that ability, gated by its own permissions, to users who already have edit
access to the media. It depends on core Media and is configured at `override_media_options.settings`; it
is in the Permissions package.

Use it to delegate media-publishing control to appropriate roles without full media administration. It is
an access-delegation feature: it grants specific override capabilities via permissions, scoped to media
the user can already edit — so verify the permissions are assigned to the right roles (granting override
of published status effectively lets those users publish/unpublish media). Confirm the delegation matches
your intended trust model.

---

- Let non-admins override media publishing options.
- Delegate media-publish control.
- Grant options-override via permission.
- Scope to media the user can edit.
- Analogous to override node options.
- Depend on core Media.
- Configure at override_media_options.settings.
- Verify permission assignments.
- Grant publish/unpublish of media.
- Delegate without full media admin.
- Match the intended trust model.
- Gate override by permission.
- Respect existing edit access.
- Confirm role assignments.
- Override default media options.
- Allow status changes on media.
- Provide access delegation.
- Control media publishing per role.
- Configure the override permissions.
- Delegate media options.
