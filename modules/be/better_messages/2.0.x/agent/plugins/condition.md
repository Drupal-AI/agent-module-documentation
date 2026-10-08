# The `message_type` condition & messages context

Besides the settings, Better Messages ships a **Condition plugin** and a **context provider** so
other plugins can react to which Drupal messages are currently present.

## Context provider: `better_messages.context`

Service `better_messages.context` → `Drupal\better_messages\ContextProvider\MessagesContext`
(args `@messenger`), tagged `context_provider`. It exposes the current messenger messages as a
context named `better_messages`, making the set of active status/warning/error messages available
to context-aware plugins (conditions, blocks).

## Condition plugin: `message_type`

`Drupal\better_messages\Plugin\Condition\MessageType`:

```
@Condition(
  id = "message_type",
  label = @Translation("Message type"),
  context_definitions = { "better_messages" = ... current better messages ... }
)
```

- Configuration: `message_types` — a sequence of allowed message type strings (schema
  `condition.plugin.message_type` → `message_types` sequence of string).
- `evaluate()` reads the `better_messages` context value and matches against the configured
  `message_types`; `summary()` describes the selection.

Use it wherever Drupal accepts condition plugins (e.g. block visibility, or the module's own
`visibility` config) to act only when a message of a given type (status / warning / error) is
being shown.

## Notes

- This is a normal core Condition plugin — no custom plugin type is defined by the module
  (`provides_plugin_types` is empty).
- The context provider is what makes the `message_type` condition possible; both are wired
  automatically once the module is enabled.
