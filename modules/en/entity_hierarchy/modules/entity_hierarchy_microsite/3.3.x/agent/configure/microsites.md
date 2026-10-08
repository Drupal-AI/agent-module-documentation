# Configuring microsites

## The Microsite entity

`entity_hierarchy_microsite` is a **content entity** (base table `entity_hierarchy_microsite`,
`admin_permission` = `administer entity hierarchy microsites`). Manage it at:

- Collection (the `configure` route): `/admin/structure/entity-hierarchy-microsites`
  (`entity.entity_hierarchy_microsite.collection`)
- Add: `/admin/structure/entity-hierarchy-microsites/add`
- Edit / Delete: `.../{entity_hierarchy_microsite}/edit` and `/delete`

Base fields:

| Field | Type | Purpose |
|---|---|---|
| `name` | string | microsite label |
| `home` | entity_reference | the **landing/root node**; the microsite is that node + its hierarchy descendants |
| `generate_menu` | boolean | when TRUE, auto-build a section menu from the subtree |
| `logo` | entity_reference (media) | logo rendered by the branding block |

`field_ui_base_route` is the collection route, so you can add extra fields to microsites via
Field UI.

## Create one with drush/PHP

```php
use Drupal\entity_hierarchy_microsite\Entity\Microsite;
Microsite::create([
  'name' => 'Marketing site',
  'home' => ['target_id' => $landing_node_id],
  'generate_menu' => TRUE,
  // 'logo' => ['target_id' => $media_id],
])->save();
```

## Auto-generated menu

When `generate_menu` is TRUE, `MicrositeMenuLinkDiscovery` + `MicrositeMenuItemDeriver`
create menu links for the home node and every hierarchy descendant into the dedicated
**`entity-hierarchy-microsite`** menu (installed by the module). The tree is kept in sync as
nodes are added/moved (menu rebuild on entity update/insert/delete).

### Overriding individual items

Per-item edits (retitle, re-point, hide) are stored as separate
**`eh_microsite_menu_override`** content entities rather than editing the generated links, so
regeneration does not clobber your changes. There is an "add menu override" route
(`entity.eh_microsite_menu_override.add/{target}`) reachable from the menu edit form.

To render the menu on the page, place the **Microsite menu** block
(`entity_hierarchy_microsite_menu`) — see [../api/blocks-and-lookup.md](../api/blocks-and-lookup.md)
for its settings and the other plugins.
