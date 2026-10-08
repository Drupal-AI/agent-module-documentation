<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure privacy: per-content-type modes, the `private` field, actions

No admin settings page (`configure: null`). Configuration is a **per-content-type** third-party
setting plus the per-node `private` flag.

## Per-content-type privacy mode

Set on the node type form (*Structure → Content types → <type> → Edit*, "Privacy settings" group
under Additional settings). Stored as a third-party setting:

```
node.type.<bundle>.third_party.private_content.private
```

Constants / integer values (see `private_content.module`):

| Value | Constant | Label | Meaning |
|---|---|---|---|
| 0 | `PRIVATE_DISABLED` | Disabled (always public) | Field off; nodes always public |
| 1 | `PRIVATE_ALLOWED` | Enabled (public by default) | Editors may tick "Private"; default unticked (**default when unset**) |
| 2 | `PRIVATE_AUTOMATIC` | Enabled (private by default) | Editors may tick; default is private |
| 3 | `PRIVATE_ALWAYS` | Hidden (always private) | Field locked on; every node is private |

Changing this value calls `node_access_needs_rebuild(TRUE)` — content access must be rebuilt.

### Set it with drush

```bash
drush php:eval '$t=\Drupal\node\Entity\NodeType::load("article"); $t->setThirdPartySetting("private_content","private",2); $t->save(); node_access_needs_rebuild(TRUE);'
drush php:eval 'node_access_rebuild();'   # apply to existing nodes
```

Read it back: `drush php:eval 'print \Drupal\node\Entity\NodeType::load("article")->getThirdPartySetting("private_content","private","unset");'`

## The `private` node field

`hook_entity_base_field_info()` adds a revisionable base field `private` to **all** nodes
(field type `private`, default widget `private`, default formatter `private`). It is display-
configurable for both form and view. The widget is a single checkbox; edit access on it requires
the **"Mark content as private"** permission (`PrivateItemList::defaultAccess()`), and the field
is force-locked (read-only) when the content type is Disabled or Always-private
(`PrivateItemList::isLocked()`).

`private_content_form_node_form_alter()` moves the checkbox into the node form's `options` group
(next to Published/Promoted).

### Set a node private in code

```php
$node->set('private', 1)->save();   // stored=1
// read the *effective* privacy (honours content-type mode):
$is_private = $node->private->isPrivate();
```

`isPrivate()` returns the stored value when set, otherwise the content-type default
(`getDefault()`), and always the default when the type is locked.

## Bulk actions

Two node actions ship (enabled as optional config `system.action.*`):

- `private_content_make_private` — "Make selected content private" (sets `private = 1`).
- `private_content_make_public` — "Make selected content public" (sets `private = 0`).

Use them from the content admin Views bulk-operations dropdown, or:
`drush php:eval '\Drupal::service("plugin.manager.action")->createInstance("private_content_make_private")->execute($node);'`

## Config schema

`private_content.schema.yml` defines `node.type.*.third_party.private_content` (integer `private`)
and the two `action.configuration.*` entries.
