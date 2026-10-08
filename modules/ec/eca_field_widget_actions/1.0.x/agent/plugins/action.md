<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# "Set field widget value" action

`src/Plugin/Action/SetWidgetValue.php` — `SetWidgetValue extends ConfigurableActionBase`.
Attributes: `#[Action(id: 'eca_set_field_widget_value', label: 'Set field widget value')]` and
`#[EcaAction(description: 'This action sets the value for the field widget event.', version_introduced: '1.0.0')]`.
This is how an ECA model hands its computed value back to the widget. Add it to a model that uses
the ECA Field Widget event.

## Access
`access()` = `AccessResult::allowedIf($this->getEvent() instanceof FieldWidgetEvent)` — the action is
usable only while a `FieldWidgetEvent` is being processed; outside that context it is denied.

## Config keys (schema `action.configuration.eca_set_field_widget_value`)
- `widget_value` (string, textarea, `#eca_token_replacement => TRUE`) — the value to set, defaults `''`.
- `use_yaml` (boolean checkbox "Interpret above value as YAML format") — defaults FALSE.

## `execute()` value resolution
Injected `eca.service.yaml_parser` (via `create()` / `setYamlParser()`). Starting from
`$this->configuration['widget_value']`:
1. If `use_yaml`: `yamlParser->parse($value)`. The parser replaces tokens inside the parsed
   structure, so each property of a compound value can carry its own token. A `ParseException` is
   logged (`logger->error(...)`) and the action returns without setting a value.
2. Else if `tokenService->hasTokenData($value)`: `getTokenData($value)`.
3. Else: `tokenService->replaceClear($value)`.

Then normalization:
- A `DataTransferObject` is unwrapped via `getValue()`; if that is an array it prefers
  `_string_representation`, else `values`.
- A `TypedDataInterface` (e.g. `StringData` from a `[field:0:value]` token) is reduced with
  `getString()`.
- Anything not array/string is cast to string.

Finally `event->setWidgetValue($value)` — a string for scalar fills, or an array (mapping / list)
for compound and multi-value fills. See [field-widget-action.md](field-widget-action.md) for how the
button consumes it.

## Compound / YAML shape (from source + README)
For a compound field, enable `use_yaml` and write a mapping of the field item's property names:
`uri: "https://example.com"` + `title: "Example"` for Link; `country_code` / `locality` /
`postal_code` etc. for Address. A YAML list of such mappings fills a multi-value field. Wrap tokens
in quotes so YAML stays valid: `title: "[node:title]"`.
