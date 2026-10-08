# insert_block — internals / api

Everything lives in one filter plugin. There is no public service, hook, or event to call — this
doc explains how the filter behaves so you can predict output and debug.

## Plugin

`Drupal\insert_block\Plugin\Filter\InsertBlockFilter`

```
@Filter(
  id = "filter_insert_block",
  title = "Insert blocks",
  type = TYPE_TRANSFORM_IRREVERSIBLE,   // display-time only; raw tag stays in storage
  settings = { "check_roles" = TRUE }
)
```

Implements `ContainerFactoryPluginInterface`; injects `entity_type.manager`, `renderer`, and
`current_user`.

## process($text, $langcode)

1. Matches all tags with regex `\[block:([^\]]+)+\]`.
2. For each captured value: if it contains `=`, the id is the part **after** `=`
   (legacy `[block:module=delta]`); otherwise the whole value is the id.
3. Resolution order:
   - Load `block` (placed block config entity) storage by id → `$type = 'block'`.
     - Then `checkVisibility()` is run; if it returns FALSE the tag is skipped (left unrendered
       and removed from the replacement set).
   - Else load `block_content` (content block) storage by id → `$type = 'block_content'`.
   - If neither loads, the tag is skipped and left as-is in the output.
4. Builds the block with `getViewBuilder($type)->view($block)` and renders it via the injected
   renderer. The rendered markup replaces the raw tag (`str_replace`).
5. Merges the block render array's `#cache['tags']` and `#cache['contexts']` into the
   `FilterProcessResult`, so embedded blocks invalidate/vary correctly.

Unmatched or unresolved tags are left verbatim in the text (no error).

## checkVisibility(array $visibility_settings): bool

Only consulted for placed `block` entities. Returns TRUE (render) unless:

- `check_roles` setting is TRUE **and** the block has a `user_role` visibility condition.
- Then it intersects the block's allowed roles with `current_user`'s roles; `negate` inverts the
  result. Match (respecting negate) → render; otherwise hide.

Content blocks bypass this entirely and always render.

## tips($long)

Provides the author help text ("You may use [block:block_entity_id] tags …"), linking to the
filter tips page (`filter.tips_all`). `insert_block_help()` in `insert_block.module` supplies the
admin help at `admin/help#insert_block`.

## Notes

- No `configure` route, permissions, services.yml, drush commands, or `.api.php` — nothing else
  to wire up.
- The id is an **entity id**, not a block plugin id / delta. Placed blocks use their config
  machine name; content blocks use their numeric entity id.
