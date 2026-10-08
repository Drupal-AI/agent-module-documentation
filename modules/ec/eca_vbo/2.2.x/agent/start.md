# ECA VBO — agent index

Run an ECA model as a Views Bulk Operations bulk action. Depends on `views`, `eca` (^2||^3) and
`views_bulk_operations` (^4.2). No admin settings page (`configure` null), no permissions, no Drush.
You configure everything in the **ECA UI** (events + actions) and the **Views UI** (a VBO field). The
link between them is an **operation name** you type on the ECA event and pick as an action in Views.

- **The nine `vbo:*` ECA event plugins (ids, config keys, tokens, matching)** →
  [plugins/events.md](plugins/events.md)
- **The five action plugins (`eca_vbo_execute` + 4 `system` helpers)** → [plugins/actions.md](plugins/actions.md)
- **Wiring it up in Views: the two field plugins, confirm/skip, minimal end-to-end recipe** →
  [configure/setup.md](configure/setup.md)

Key facts:
- Core flow: ECA event **`vbo:execute`** (per entity) or **`vbo:execute_multiple`** (whole selection),
  each with an `operation_name`. `VboExecuteDeriver` turns every such event into a selectable VBO action
  `eca_vbo_execute:<derived_id>`.
- Tokens available inside the model: `[event:view]`, `[event:action]`, and `[event:entity]`
  (execute) or `[event:queue]` (execute_multiple).
- Custom access: event `vbo:custom_access` + action `eca_vbo_set_custom_access`, used together with
  the module's "ECA bulk operations" field (`eca_vbo_bulk_form`) — see [configure/setup.md](configure/setup.md).
- Helper actions (ECA `type: system`, invisible to VBO): `eca_vbo_set_result`,
  `eca_vbo_get_config_value`, `eca_vbo_get_views_argument`, `eca_vbo_set_custom_access`.
- Tip: in an execute model, add an ECA action that actually **saves** the entity — this module only
  dispatches the event.
