<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — block groups (`block_group_content` config entity)

A block group is a **config entity** of type `block_group_content`. Creating one is the
only configuration this module has; there is no global settings form (`configure` is null).

## The config entity

- Entity type id: `block_group_content`
- Config prefix / name: `blockgroup.block_group_content.<id>` (e.g. `blockgroup.block_group_content.header`)
- Exported keys (`config_export`): **`id`** and **`label`** only (plus `uuid`, `langcode`,
  `status`, `dependencies` from the base entity). There are no other fields — a group is
  just an id + a human label.
- Schema: `blockgroup.block_group_content.*` in `config/schema/block_group_content.schema.yml`.

Creating or deleting a group clears block plugin definitions and refreshes theme region
info (`BlockGroupContent::clearBlocksCaches()` runs on save + delete), so the new derived
block and region appear immediately.

## Admin UI

- List / manage: `/admin/structure/block_group_content` (route
  `entity.block_group_content.collection`), also reachable as the **Block groups** tab on
  `/admin/structure/block` (Block layout).
- Add: `/admin/structure/block_group_content/add` — the "Add group" action link. The form
  has just a **Label** textfield and a **machine name** (id).
- Edit / delete: `/admin/structure/block_group_content/{id}/edit` and `/delete`.
- All routes require the **`administer blockgroups`** permission.

## Using a group after creating it

1. Create the group (gives you derived block `block_group:<id>` and region `<id>`).
2. On `/admin/structure/block`, place the block titled **"Block group: <label>"** into a
   normal theme region (this is the parent block).
3. Move any other blocks into the group's own region (also listed on the block layout page
   as **"Block group: <label>"**). Those blocks now render inside the parent block, in
   weight order, with access checks applied.
4. Set visibility/weight on the parent block to govern the whole group; nest by placing one
   group block into another group's region.

## Create / delete with drush (php:eval)

The module ships no Drush commands; use the entity storage API. Create:

```bash
drush php:eval '\Drupal::entityTypeManager()->getStorage("block_group_content")
  ->create(["id" => "header", "label" => "Header"])->save();'
```

List and read:

```bash
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("block_group_content")
  ->loadMultiple() as $g) { print $g->id()." => ".$g->label()."\n"; }'
```

Delete:

```bash
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("block_group_content")
  ->load("header"); if($e){$e->delete();}'
```

Or via config: `drush config:set blockgroup.block_group_content.header label "Header" -y`
after `drush config:get` shows the shape. Config export/import (`drush cex`/`cim`) carries
groups between environments.

## Permission

`administer blockgroups` (in `blockgroup.permissions.yml`) gates every group route. Grant it
with `drush role:perm:add <role> 'administer blockgroups'`.
