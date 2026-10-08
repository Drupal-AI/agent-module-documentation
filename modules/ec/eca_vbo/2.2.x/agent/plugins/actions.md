# ECA VBO action plugins

Five action plugins. One (`eca_vbo_execute`) is the **VBO** action that dispatches the ECA events; the
other four are **ECA** actions (`@Action ... type = "system"`, so they are hidden from the VBO action
list and are meant to be used *inside* the ECA model, reacting to the `vbo:*` events).

## `eca_vbo_execute` — the VBO bulk action (derived, not used directly in ECA)

`Plugin/Action/VboExecute` (`ViewsBulkOperationsActionBase`), deriver
`Plugin/Action/Derivative/VboExecuteDeriver`. You never pick this in the ECA UI; instead the deriver
scans every **enabled** ECA config for `vbo:execute` / `vbo:execute_multiple` events and emits one
derivative per distinct `operation_name` (id = the operation name lowercased/underscored, label = the
operation name). Those derivatives are what you select as bulk actions in a View.

- `executeMultiple()` dispatches `eca_vbo.execute_multiple` once for the selection, then calls
  `execute()` per entity, which dispatches `eca_vbo.execute`; both return `$event->result` as the batch
  result message.
- `access()` allows only when the object is an entity and the operation name is non-empty.
- `customAccess()` dispatches `eca_vbo.custom_access` and returns `$event->accessGranted`; it receives
  the action definition/selection from the *ECA bulk operations* field (`EcaVboBulkForm`), so use that
  field with `vbo:custom_access`.
- Preconfiguration form adds **`skip_confirm`** (checkbox) to bypass the confirm step.
- `calculateDependencies()` adds the source `eca.eca.<id>` configs as config dependencies.
- Confirm route: `eca_vbo.confirm` (annotation `confirm_form_route_name`). If the config form is empty
  (no `vbo:form_build` added fields) it redirects straight to confirm/execute.

## Helper ECA actions (`type: system` — add these as successors of the `vbo:*` events)

### `eca_vbo_set_result` — "VBO: Set result"
`Plugin/Action/VboSetResult`. Sets the batch result message shown after execution. Config: `result`
(textarea, token-replaced via `TokenServices::replaceClear`). Only effective on the execution events
(`VboExecutionEventBase`).

### `eca_vbo_get_config_value` — "VBO: Get configuration value"
`Plugin/Action/VboGetConfigValue`. Reads a value out of the executed action's configuration (or a custom
form field) into a token. Config:
- `config_key` — key to read (e.g. `message_text`); dotted paths (`a.b`) are treated as `a:b`; empty =
  the whole config array. Supports `_entities_to_load` to hydrate entities from storage.
- `token_name` — token to store the value in (required).
- `replace_tokens` — replace tokens inside the read value.
- `default_value` — used when the key is absent/empty.
Works on execution events and form events (`VboFormEventBase`).

### `eca_vbo_get_views_argument` — "VBO: Get Views argument"
`Plugin/Action/VboGetViewsArgument`. Reads a Views contextual argument into a token. Config:
- `index` — argument position (0-based); empty = all arguments as an array.
- `token_name` — token to store into (required).
- `default_value` — fallback when the index is empty.
Reads from `$event->actionContext['arguments']`. Works on execution and form events.

### `eca_vbo_set_custom_access` — "VBO: Set custom access on Views Bulk Operation"
`Plugin/Action/VboSetCustomAccess`. Grants/denies access to the operation. Config: `access_granted`
(boolean checkbox, default TRUE). **Only works as a successor of the `vbo:custom_access` event** — it
sets `$event->accessGranted`. Combine with prepended ECA conditions to implement per-user/role/selection
access logic.

## Result / access data model

Execution events (`Event/VboExecutionEventBase`) expose to actions: `actionContext` (view data +
`arguments`), `actionConfiguration` (the action config, incl. `operation_name`), `getAction()`,
`getView()`, and a writable `result`. The custom-access event (`VboCustomAccessEvent`) exposes the
writable `accessGranted` boolean.
