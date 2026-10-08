# context_active_trail — configuration

No standalone settings form (`configure` is null). You configure it as a **reaction inside a
Context** at *Structure → Context* (needs `context_ui`, part of Context, for the UI).

## Adding the reaction

1. Create or edit a context and add its conditions (path, content type, role, …) as usual.
2. Add the **Active trail** reaction (plugin id `active_trail`).
3. Fill in the reaction fields:

| Field | Key | Default | Purpose |
|---|---|---|---|
| Menu parent selector | `trail` | `main:` | The menu link to force as the active trail. Uses core's `menu.parent_form_selector` (`menu_name:plugin_id`). |
| Override breadcrumbs | `breadcrumbs` | `TRUE` | Rebuild the breadcrumb from the forced trail. |
| Show current page title at end | `breadcrumb_title` | `FALSE` | Append the current page title as a final (non-link) breadcrumb crumb. Only visible when *Override breadcrumbs* is on. Disable if another module already handles breadcrumbs. |

`getLinkId()` splits `trail` on the first `:` and uses the part after it as the menu link plugin id.

## Stored configuration

The reaction is stored inside the context config entity. Schema
(`config/schema/context_active_trail.schema.yml`):

```yaml
reaction.plugin.active_trail:
  type: reaction.plugin
  mapping:
    trail:
      type: string
    breadcrumbs:
      type: boolean
    breadcrumb_title:
      type: boolean
```

Example (inside `context.context.*.yml`):

```yaml
reactions:
  active_trail:
    id: active_trail
    trail: 'main:standard.front_page'
    breadcrumbs: true
    breadcrumb_title: false
```

## Cache behavior

- The reaction uses the cache tag `context_active_trail` (added to the overridden active trail) and
  the module-wide tag `cache_tag_breadcrumbs` (constant
  `ContextActiveTrail::CACHE_TAG_BREADCRUMBS`).
- Saving the reaction form invalidates `context_active_trail`; `hook_context_update` /
  `hook_context_delete` invalidate `cache_tag_breadcrumbs` when an active_trail reaction changes.
- `hook_system_breadcrumb_alter` tags **all** breadcrumbs with `cache_tag_breadcrumbs` so a context
  change can flip which builder owns a breadcrumb.
- On install the module clears the whole render cache once (previously-cached breadcrumbs may be
  untagged).

## Gotchas

- If no context matches, behavior falls back to Drupal core's normal active trail — nothing is
  forced.
- Incompatible with other modules that also take over the active trail (e.g. Menu Trail By Path).
