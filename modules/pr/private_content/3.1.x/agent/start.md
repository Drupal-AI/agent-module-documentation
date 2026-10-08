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
- **The access model: node grants realms, the four hooks, isPrivate/isLocked/getDefault, rebuilds** →
  [api/access-model.md](api/access-model.md)
- **The three permissions and exactly what each gates** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: content-type mode at `node.type.<bundle>.third_party.private_content.private`
(0=Disabled/always public, 1=Enabled/public default, 2=Enabled/private default,
3=Hidden/always private). Grant realms `private_view` (gid 1 = "access private content") and
`private_author` (gid = author uid). Permissions: `mark content as private`,
`edit private content`, `access private content`. Actions:
`private_content_make_private`, `private_content_make_public`. Ships D6 migration templates.

Requires **Drupal core `^11.4 || ^12`** (core Node module only; no other dependencies). Hooks are
implemented as OOP methods on the `Drupal\private_content\Hook\PrivateContentHooks` service class
(`#[Hook]` attributes), with thin `#[LegacyHook]` procedural wrappers in `private_content.module`.
The privacy-mode integer constants live on `Drupal\private_content\PrivateContentInterface`
(`DISABLED`, `ALLOWED`, `AUTOMATIC`, `ALWAYS`, `GRANT_ALL`).

## Diff 2.2.x → 3.1.x (major bump — BC breaks)

- **Core requirement raised:** `^10 || ^11` → **`^11.4 || ^12`**. Drupal 10 (and 11.0–11.3) are no
  longer supported; Drupal 12 is now supported. This is the headline BC break — the module will
  not install on older cores.
- **Constants moved to an interface.** The privacy-mode / grant constants that were module-level
  `define()`s (`PRIVATE_DISABLED`, `PRIVATE_ALLOWED`, `PRIVATE_AUTOMATIC`, `PRIVATE_ALWAYS`,
  `PRIVATE_GRANT_ALL`) are now class constants on `PrivateContentInterface`
  (`DISABLED`, `ALLOWED`, `AUTOMATIC`, `ALWAYS`, `GRANT_ALL`). Any custom code referencing the old
  global constants must be updated. The integer values are unchanged (0/1/2/3 and gid 1).
- **Hooks converted to OOP.** All hook logic moved into
  `Drupal\private_content\Hook\PrivateContentHooks` (registered in `private_content.services.yml`,
  `autowire: true`) using `#[Hook('…')]` attributes. `private_content.module` now holds only
  `#[LegacyHook]` shim functions that delegate to that service. Behaviour is unchanged.
- **Rebuild API updated.** The node-type entity builder now calls
  `\Drupal::service(NodeAccessRebuild::class)->setNeedsRebuild(TRUE)` instead of the older
  `node_access_needs_rebuild(TRUE)` function (D11.4 service API).
- **Unchanged:** the access strategy (node grants for listings + `hook_node_access` for
  update/delete), the three permissions, the `private` base field / widget / formatter, the two
  bulk actions, and the D6 migration templates all behave as in 2.2.x.
