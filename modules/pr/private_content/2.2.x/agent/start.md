<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Private Content — agent index

Marks individual nodes **private** so only users with permission (plus the author) can view or
edit them; hides private nodes everywhere, including listings. Adds a revisionable `private`
base field to nodes and a per-content-type privacy mode. **No settings page / configure route**
(`configure: null`); config is a node-type third-party setting. Enabling it turns on Drupal's
node-grants system, so a **node access rebuild** is required. It only ever *removes* access,
never adds it, and never restricts a node's own author.

- **Per-content-type privacy modes, the `private` field, bulk actions, how to set it** →
  [configure/privacy.md](configure/privacy.md)
- **The access model: node grants realms, the three hooks, isPrivate/isLocked/getDefault, rebuilds** →
  [api/access-model.md](api/access-model.md)
- **The three permissions and exactly what each gates** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: content-type mode at `node.type.<bundle>.third_party.private_content.private`
(0=Disabled/always public, 1=Enabled/public default, 2=Enabled/private default,
3=Hidden/always private). Grant realms `private_view` (gid 1 = "access private content") and
`private_author` (gid = author uid). Permissions: `mark content as private`,
`edit private content`, `access private content`. Actions:
`private_content_make_private`, `private_content_make_public`.
