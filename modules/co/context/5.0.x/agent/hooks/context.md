# Hooks

Context ships **no `context.api.php`**. The hook surface is:

## `hook_context_condition_info_alter(array &$definitions)`

The reaction plugin manager calls `alterInfo('context_condition_info')`, so implement
`hook_context_condition_info_alter()` to alter the discovered **ContextReaction** plugin
definitions (add/remove/modify reactions). (Despite the "condition" name, this alters the
*reaction* definitions — see `ContextReactionManager`.)

```php
function mymodule_context_condition_info_alter(array &$definitions) {
  // e.g. tweak a reaction's label or unset one.
  unset($definitions['theme']);
}
```

## Entity CRUD hooks

`context` is a config entity, so the standard config-entity hooks fire on save/load/delete:
`hook_context_presave/insert/update/predelete/delete` and the generic
`hook_entity_*` equivalents. Context itself implements
`hook_ENTITY_TYPE_presave()` as `context_context_presave()` to keep each block reaction's
`context_id` in sync.

## Where reactions are applied (module hooks in `context.module`)

Not hooks you implement, but useful to know how reactions reach the page:

- `context_preprocess_html()` — runs `body_class`, `page_title`, and `regions` reactions.
- `context_preprocess_page_title()` — runs `page_title`.
- `context_theme_suggestions_page_alter()` — runs `page_template_suggestions`.
- `context_form_alter()` — warns if the `menu` reaction can't override `menu.active_trail`.

To apply a custom reaction, add your own hook that calls
`context.manager`→`getActiveReactions()` (see [../api/context.md](../api/context.md)).
