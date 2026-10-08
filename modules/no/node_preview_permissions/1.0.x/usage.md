<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Preview Permissions sets permissions to use the node save preview.

---

Node Preview Permissions **gates access to node previews by permission** — replacing core's default
preview access check with a `use node preview` / `use <bundle> node preview` permission, so you can grant the
preview feature to roles (e.g. reviewers) without giving them edit access. It depends on core Node, provides
its own permissions.

Use it to control who can use node preview. It is an access/editorial feature and it is safe in an important
respect: a node **preview object is stored in the previewing user's own private tempstore** (session-scoped),
so this permission controls whether a user can use the preview feature **on their own preview** — it does not
let a permission-holder view **other** users' drafts (the preview data is per-session). The access check simply
returns `allowedIfHasPermissions(['use node preview', 'use <bundle> node preview'], 'OR')`. Grant the permissions
to the appropriate roles. It has no other access-control role.

---

- Gate node preview by permission.
- Provide use-node-preview permissions.
- Grant preview without edit access.
- Depend on core Node.
- Replace core's preview access check.
- Serve reviewers/editors.
- KNOW previews are session-scoped (own tempstore).
- Not let holders view others' drafts.
- Control preview-feature use per bundle.
- Grant the permissions to appropriate roles.
- Have no other access-control role.
- Configure the preview permissions.
- Handle preview access.
- Gate previews.
- Configure the permissions.
- Allow preview.
- Handle the access check.
- Permit preview.
- Grant preview.
- Provide preview permissions.
