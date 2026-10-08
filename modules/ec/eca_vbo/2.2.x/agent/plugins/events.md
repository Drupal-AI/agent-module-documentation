# ECA VBO event plugins (`vbo:*`)

One ECA event plugin `vbo` (`Plugin/ECA/Event/VboEvent`, id `vbo`, derived by `VboEventDeriver`) exposes
**nine derivative events**. In an ECA model choose *Add event* → the labels below. Every event has the
same three config fields; add successor actions to build the operation's logic.

## The nine events

| Plugin id | Label | ECA tag(s) | When it fires |
|---|---|---|---|
| `vbo:execute` | VBO: Execute … (one by one) | CONTENT | Once **per selected entity**. Main workhorse. |
| `vbo:execute_multiple` | VBO: Execute … (multiple at once) | CONTENT | Once for the **whole selection** (before the per-entity loop). |
| `vbo:custom_access` | VBO: Custom access … | BEFORE | To decide access to the operation (see `eca_vbo_set_custom_access`). |
| `vbo:form_build` | VBO: Form build … | VIEW·RUNTIME·BEFORE | Building the action configuration form. |
| `vbo:form_validate` | VBO: Form validate … | READ·RUNTIME·AFTER | Validating that form. |
| `vbo:form_submit` | VBO: Form submit … | WRITE·RUNTIME·AFTER | Submitting that form. |
| `vbo:confirm_form_build` | VBO: Confirm form build … | VIEW·RUNTIME·BEFORE | Building the confirmation form. |
| `vbo:confirm_form_validate` | VBO: Confirm form validate … | READ·RUNTIME·AFTER | Validating the confirmation form. |
| `vbo:confirm_form_submit` | VBO: Confirm form submit … | WRITE·RUNTIME·AFTER | Submitting the confirmation form. |

(Event name constants live in `Event/EcaVboEvents`, e.g. `vbo:execute` → `eca_vbo.execute`.)

## Config fields (all events)

Schema `eca.event.plugin.vbo:<id>`:

| Field | Required | Meaning |
|---|---|---|
| `operation_name` | yes | Human name identifying the operation. It becomes the selectable VBO action label and is the key that links the ECA model to the Views field. Comma-separate to match several names. |
| `view_id` | no | Restrict to these view ids (comma-separated). Empty = all views. |
| `display_id` | no | Restrict to these display ids (comma-separated). Empty = all displays. |

### Matching (wildcard)

`VboEvent::generateWildcard()` builds `"<operation_names>::<view_ids>::<display_ids>"` (each part `*` when
empty). At runtime `appliesForWildcard()` fires the event only when the current operation name is in the
list (or `*`) **and** the view id matches (or `*`) **and** the display id matches (or `*`). Note: for
`vbo:custom_access` the operation name is only known when the View uses the *ECA bulk operations* field.

## Tokens exposed to the model (`buildEventData`)

Available on the execution events (`vbo:execute` / `vbo:execute_multiple`):

- `[event:view:id]`, `[event:view:display_id]`
- `[event:action:plugin]` (action plugin id), `[event:action:config]` (key/value config array)

Only on `vbo:execute` (one entity in scope):

- `[event:entity:id]`, `[event:entity:label]`, `[event:entity:type]`, `[event:entity:bundle]`,
  `[event:entity:langcode]` (plus `[event:entity]` itself, an entity token).

Only on `vbo:execute_multiple` (the queued selection):

- `[event:queue:count]`, `[event:queue:ids]`, `[event:queue:revisions]`, `[event:queue:items]`.

## Notes

- Saving an ECA config that contains a `vbo:execute` event clears the cached VBO action definitions
  (`eca_vbo_eca_presave` in `eca_vbo.module`) so the derived action appears/updates immediately.
- These event classes are marked `@internal`; drive them through the ECA UI/config, not by extending.
