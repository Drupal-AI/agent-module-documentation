# insert_block — configure

The module adds **no admin route of its own** (`configure` is null; there is no `*.routing.yml`).
All configuration is done through Drupal core's Text formats UI, because Insert Block is a
`filter` plugin.

## Enable the filter on a text format

1. Go to **Admin > Configuration > Content authoring > Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the format you want (e.g. Full HTML): route `entity.filter_format.edit_form`.
3. Under **Enabled filters**, check **"Insert blocks"** (filter id `filter_insert_block`).
4. In **Filter processing order**, place Insert blocks where you want; it runs its regex over
   the text and injects rendered block markup. Save.

Only formats where you enable this filter will expand `[block:...]` tags. Enable it only on
trusted formats — an editor who can write these tags can render any block, including
role-restricted ones if `check_roles` is off.

## Tag syntax (author-facing)

- `[block:BLOCK_ID]` — inserts the rendered block.
- `BLOCK_ID` is a **placed block's config entity id** (e.g. `olivero_syndicate`) OR a
  **content block's numeric id** (e.g. `12`). The filter tries the placed `block` entity first,
  then a `block_content` entity.
- Legacy `[block:module=delta]` is accepted; the portion after `=` is used as the id.
- Find a placed block id at `/admin/structure/block` (hover its "Configure" link — last path
  segment). Find a content block's numeric id from its edit URL under `/admin/content/block`.

## The one setting: `check_roles`

Per-format boolean, default **TRUE**. Stored in the format's filter config as:

```yaml
# filter.format.<format>.yml → filters.filter_insert_block.settings
check_roles: true
```

- **TRUE** — a placed block's role-visibility condition (`user_role`) is enforced; users
  without the block's allowed roles do not see the embedded block (negation honored).
- **FALSE** — role visibility is ignored and the block always renders.
- Content blocks (`block_content`) are not role-checked either way; they always render.

The checkbox appears in the filter's settings ("Check roles permissions.") on the text-format
edit form. Config schema: `filter_settings.filter_insert_block` (type `filter`) with the single
`check_roles` boolean (`config/schema/insert_block.schema.yml`).

## Enable the module

`drush en insert_block -y` (pulls in core `block` and `filter`). No install-time config is
written; the filter is inert until enabled on a format.
