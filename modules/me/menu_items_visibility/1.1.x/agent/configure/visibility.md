# Configure menu-item visibility

There is no settings page. You configure visibility **on each menu link** at
`/admin/structure/menu/manage/<menu>/link/<id>/edit` (or when adding a custom link). All logic lives
in `menu_items_visibility.module`.

## The form additions

`menu_items_visibility_form_menu_link_content_menu_link_content_form_alter()` adds a
**Visibility settings** fieldset to every `menu_link_content` add/edit form:

| Element | Type | Meaning |
|---|---|---|
| `roles` | checkboxes (`user_role_names()`) | "Show this menu link only for the selected role(s)." Select none = visible to all. |
| `access_check` | checkbox ("Path Access") | Only meaningful for links to a **node**. When on, denies node access to roles that fail the role check. |

A submit handler (`menu_items_visibility_submit_handler`) is appended to `actions.submit`.

## Where settings are stored

Config object `menu_items_visibility.settings`, keyed by the link's **plugin ID**
(`$menu_link->getPluginId()`, e.g. `menu_link_content:<uuid>`):

```yaml
mlid:
  'menu_link_content:<uuid>':
    roles: ['editor', 'administrator']   # role IDs (only checked ones)
    access_check: true                    # or 0/false
```

Schema: `config/schema/menu_items_visibility.schema.yml` (`mlid` sequence → `roles` sequence +
`access_check` boolean).

## Render-time role filter (link hiding)

`hook_preprocess_menu()` recurses the menu tree and keeps a link only when
`menu_items_visibility_check($key)` passes:

- Reads `mlid.<key>.roles`. If non-empty, the link shows only when
  `array_intersect($roles, \Drupal::currentUser()->getRoles())` is non-empty.
- If no roles are stored, the function returns TRUE → visible to everyone.

**This only removes the link from rendered menus.** It does not protect the destination route — a
user who knows/guesses the URL can still reach it unless the target enforces its own access.

## Node Path-Access check (actual access control)

`hook_node_access()` enforces the `access_check` option:

- Collects link plugin IDs where `access_check` is truthy.
- For each, looks up the link's `route_param_key` in the `menu_tree` DB table and parses the node id
  (`route_param_key` like `node=123`).
- If the link targets the node being checked and `menu_items_visibility_check()` fails for the
  current user, returns `AccessResult::forbidden()`; otherwise `AccessResult::neutral()` with
  `setCacheMaxAge(0)`.

So to actually block access to a node's page for certain roles, hide the link **and** enable Path
Access on the menu link that points to that node.

## Attached asset

The form alter attaches `menu_items_visibility/styles` (`css/menu_items_visibility.styles.css`),
purely for styling the fieldset.
