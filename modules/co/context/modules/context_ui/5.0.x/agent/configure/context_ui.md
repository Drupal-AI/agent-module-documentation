# Context UI — admin interface

Enable with `drush en context_ui -y`. Configure route (`configure` in info.yml):
**`entity.context.collection`** → **`/admin/structure/context`** (Administration → Structure →
Context). All routes require the `administer contexts` permission (defined in
`context_ui.permissions.yml`).

## Routes

| Route | Path | Purpose |
|---|---|---|
| `entity.context.collection` | `/admin/structure/context` | List all contexts (the `configure` target) |
| `entity.context.add_form` | `/admin/structure/context/add` | Add a context |
| `entity.context.edit_form` | `/admin/structure/context/{context}` | Edit (note: this route is declared in the **base** module) |
| `entity.context.delete_form` | `.../{context}/delete` | Delete |
| `entity.context.duplicate_form` | `.../{context}/duplicate` | Duplicate |
| `entity.context.disable_form` | `.../{context}/disable` | Disable |
| `context.conditions_library` / `context.condition_add` / `context.condition_delete` | `.../{context}/conditions/...` | Attach/remove conditions (`_entity_access: context.update`) |
| `context.reactions_library` / `context.reaction_add` / `context.reaction_delete` | `.../{context}/reactions/...` | Attach/remove reactions |
| `context.reaction.blocks.*` | `.../{context}/reaction/blocks/...` | Block library, add/edit/delete block, region select |
| `context.groups.autocomplete` | `.../groups/autocomplete` | Group name autocomplete |

## What it provides

- Entity forms (`src/Form/`): `ContextAddForm`, `ContextEditForm`, `ContextDeleteForm`,
  `ContextDisableForm`, `ContextDuplicateForm`, `ConditionDeleteForm`, `ReactionDeleteForm`
  (registered as the `context` entity's `add`/`edit`/`delete`/`disable`/`duplicate` handlers).
- `ContextListBuilder` — the collection list.
- `ContextUIController` — condition/reaction libraries, `addCondition`/`addReaction`,
  `groupsAutocomplete`.
- **Context Inspector** block plugin (`src/Plugin/Block/ContextInspector.php`) — place it to
  see which contexts are active on the current page (debugging aid).

## Permission

`administer contexts` — "Associate menus, views, blocks, etc. with different contexts to
structure your site." Gates every UI route and is the `context` entity's `admin_permission`.

```
drush role:perm:add site_manager 'administer contexts'
```

No config schema, no config entities, no Drush commands, no new plugin types — this submodule
only edits the parent module's `context` config entity (see
`modules/context/5.0.x/agent/configure/context.md`).
