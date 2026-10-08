# Marking a content type as micro-content

There is no admin settings page. The setting is per **node type**, stored as a third-party setting.

## Via the UI

Edit a content type (`admin/structure/types/manage/{type}`), open the **Micro-content settings**
vertical tab, tick **"Is micro-content"**, save. (`MicronodeHooks::formNodeTypeFormAlter` adds the
`micronode` details group, entity builder, and validate handler.)

## Config shape

```
node.type.{type}:
  third_party_settings:
    micronode:
      micronode_is_microcontent: true
```

Schema: `node.type.*.third_party.micronode` → `micronode_is_microcontent` (boolean). Set it in code:

```php
$type = NodeType::load('card');
$type->setThirdPartySetting('micronode', 'micronode_is_microcontent', TRUE)->save();
```

**Existing-site caveat:** on types that predate the module the setting is NULL until the type is
re-saved. The Views "Is Micro-content" filter only recognises types whose flag is an explicit TRUE or
FALSE, so re-save every content type once after install if you use that filter.

## What the flag does — the access rule

`MicronodeHooks::nodeAccess()` (`hook_ENTITY_TYPE_access` for `node`):

- Only acts on the `view` operation, and only when the user **cannot** `update` the node (editors are
  never blocked).
- Returns `AccessResult::neutral()` unless `micronode_is_micro_content($entity)` is TRUE.
- For a flagged node, if the current route is `entity.node.canonical` and the routed node is this
  node, returns `AccessResult::forbidden('This content is marked as hidden micro-content …')`.
- Otherwise `neutral()` — so the node still renders when embedded (reference field, view, layout),
  and non-canonical routes are not blocked. This is view-on-own-page hiding, not full node-access
  revocation.

Toggling the flag on an existing type triggers `micronode_node_type_form_validate`, which deletes all
cache bins (so Views/listings that included/excluded the node update immediately).

## Side effects when a type is flagged

- Removed from the `/node/add` chooser (`MicronodeController::addPage`, unless `type_tray` is on).
- Available under `/node/add-microcontent` instead (route `micronode.add_microcontent_page`).
- Admin Toolbar "add" links regrouped under "Add Micro-content" (needs `admin_toolbar_tools`).
- Excluded from new Views by default; dropped from exposed bundle filters when the micronode Views
  filter is used; blocked from `entity_autocomplete` unless explicitly allowed.

See [api/api.md](../api/api.md) for the helpers and plugins behind these.
