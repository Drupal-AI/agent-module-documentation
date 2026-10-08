# Place an Entity Block

Entity Block adds no settings form. Everything is done by placing a block. The plugin
`entity_block` is **derived** by `EntityBlockDeriver`: it creates one block derivative for
every content entity type that has a view builder (node, media, block_content, taxonomy
term, user, …). Each derivative appears under the **Entity Block** category in the block
picker, labelled with the entity type's label.

## Steps

1. Create the entity you want to show (node, media, block_content, etc.).
2. Go to **Block layout** (`/admin/structure/block`) or a **Layout Builder** section.
3. Place a block: choose the derivative for the **entity type** you want to reference
   (listed under the *Entity Block* category).
4. In the block form:
   - **Entity** — an `entity_autocomplete` field (`#target_type` = the chosen entity type,
     required); type to find the specific entity.
   - **View mode** — a select of that entity type's view modes (default value `default`).
   - **Display title** (`label_display`) — off by default; when off the block title is
     auto-generated as `"<entity label> (<entity type admin label>)"`. Turn it on to set
     your own label.
5. Save.

## What gets stored / how it renders

Block config (schema `block.settings.entity_block:*`, keys):

| Key | Default | Meaning |
|---|---|---|
| `entity` | `''` | ID of the referenced entity (stored as a string) |
| `view_mode` | `default` | View mode the entity renders in |
| `label_display` | `FALSE` | Whether the block shows a title |

At render time `build()` loads the entity and returns
`entityTypeManager->getViewBuilder($type)->view($entity, $view_mode)` — i.e. the entity's
normal render output. A recursive-render guard (`RECURSIVE_RENDER_LIMIT = 3`) logs and
stops an entity that would embed itself endlessly.

## Access & caching (automatic)

- `blockAccess()` returns *allowed* only if the current user can `view` the entity;
  otherwise *forbidden* ("User does not have permission to view this entity.").
- The block merges the entity's cache **contexts**, **tags**, and **max-age**, so it
  invalidates when the source entity changes.

## Notes

- No `configure` route, permissions, services, or Drush commands exist — configuration is
  entirely per placed block.
- Placed blocks are configuration, so they export/deploy with `drush config:export`.
- If the optional **Canvas** module is enabled, view-mode options are grouped so modes with
  a Canvas template are listed first with a "(Canvas enabled)" suffix.
