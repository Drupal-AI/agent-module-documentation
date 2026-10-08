# Language menu settings

Node Menus has **no settings form of its own** and ships **no config schema**. All configuration lives on the
**node type** (content type) as third-party settings and is edited from the node type edit form.

## Prerequisites

- The content type must be **translatable** (enable Content Translation for it).
- Add **more than one language**, and the **language selector must be visible** on the node form
  (`language.content_settings.node.<bundle>` with `language_alterable: true`) for the per-language dynamic
  selectors to appear. Without a visible selector, the module still scopes the parent options to the node's
  own language, but does not render the per-language switcher.

## Where

Edit the content type (`/admin/structure/types/manage/<bundle>`). Under **Additional settings** a
**"Language menu settings"** panel (`details`, added by `form_node_type_form_alter`) contains:

| Field | Form key | Meaning |
|---|---|---|
| Enable language menus | `node_menus[enable_language_menus]` | Master switch; stored as third-party setting `node_menus.enabled`. |
| Available menus (per language) | `node_menus[languages][<langcode>][menu_options]` | Checkboxes of menus a node link may be placed in for that language. Default `['main']`. |
| Default parent item (per language) | `node_menus[languages][<langcode>][menu_parent]` | The default parent for a new link, in `menu_name:menu_item` form. Default `main:`. |

The per-language fieldsets are only visible while "Enable language menus" is checked (`#states`). The
default-parent `select` is kept in sync with the checked "Available menus" live by the `node_menus/admin`
library (`js/node_menus.admin.js`), which POSTs to core's `admin/structure/menu/parents`.

## Stored shape (third-party settings)

```
node.type.<bundle>.third_party.node_menus:
  enabled: true
  languages:
    en:
      available_menus: ['main', 'footer']
      parent: 'main:'
    de:
      available_menus: ['main-de']
      parent: 'main-de:'
```

## Validation (`validateNodeTypeForm`)

On save, for each language that has at least one available menu, the chosen default parent must belong to one
of the selected menus, otherwise: *"The selected menu item is not under one of the selected menus."* If a
language has no menus selected, its stored `parent` is cleared.

## Effect on the node form

On add/edit of a node of that type, the core menu "Parent item" selector is replaced with options drawn only
from the menus configured for the relevant language. If an existing menu link already points at the node
(within the configured menus), its title / description / weight / parent are pre-filled as the link defaults.
Actual menu-link creation is still handled by core **menu_ui**; Node Menus only changes which parent options
are offered.

## Rendering the menus

Node Menus only governs placement. Use normal core **menu blocks** (or your own block) to display the
per-language menus on the site.
