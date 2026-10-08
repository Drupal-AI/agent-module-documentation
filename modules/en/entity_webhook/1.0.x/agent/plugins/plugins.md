<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types & built-in plugins

The module defines **four** plugin types (attributes in `src/Attribute/`, managers in
`src/Plugin/*/*Manager.php`, each `parent: default_plugin_manager`). Every plugin exposes an
admin config form (`buildConfigurationForm()`), so config keys are edited in the UI and stored in the
owning config entity's `*_config` map.

## value_resolver — extract a value from the payload

Attribute `#[ValueResolver]`; interface `ValueResolverInterface::resolve(array $payload): mixed`;
base `ValueResolverBase`. Selected per `webhook_field_mapping` (`resolver`, default `json_path`).

- `json_path` — *JSONPath Expression*. Config `path` (e.g. `$.order.id`); delegates to
  `JsonPathExtractor`. `src/Plugin/ValueResolver/JsonPathResolver.php`.
- `json_composite` — *JSON Composite*. Combines multiple JSONPath expressions into one value.
  `JsonCompositeResolver.php`.
- `static_value` — *Static Value*. Returns a hardcoded configured value. `StaticValueResolver.php`.

## field_value_mutation — transform an extracted value

Attribute `#[FieldValueMutation]`; interface `FieldValueMutationInterface::mutate(mixed): mixed`;
base `FieldValueMutationBase`. Optional per field mapping (`mutation_plugin`). Also reused by the
Broadcast submodule's outbound payload builder. Built-in ids (`src/Plugin/FieldValueMutation/`):

- `timestamp_format` — reformat a timestamp/date value.
- `map_values` — lookup-table translation of values.
- `price_cents_to_decimal` — integer cents → decimal price.
- `string_replace` — literal string replacement.
- `regex_replace` — regex-based replacement.
- `json_encode` — JSON-encode the value.
- `array_reshape` — restructure an array value.
- `expand_entity_reference` — expand a referenced-entity value (implements
  `ContainerFactoryPluginInterface`).

## webhook_verification — authenticate an incoming request

Attribute `#[WebhookVerification]`; interface
`WebhookVerificationInterface::verify(Request): bool`; base `WebhookVerificationBase`; run through
`VerificationChain`. Selected per `webhook_source_type` (`verification_plugin`). Built-in ids
(`src/Plugin/WebhookVerification/`):

- `hmac_verification` — *HMAC Signature Verification* (shared-secret signature check).
- `api_key_verification` — *API Key Verification* (key in a header or query parameter).
- `domain_whitelist_verification` — *IP/Domain Whitelist Verification*.

Select a verification plugin on every source type so incoming requests are authenticated.

## webhook_payload_processor — split a batch payload

Attribute `#[WebhookPayloadProcessor]`; interface
`WebhookPayloadProcessorInterface::process(array $payload, array $config): array` (returns a list of
per-record payloads). Optional per source type (`payload_processor`); triggers batch processing and
the `batch_complete` event.

- `array_iterator` — *Array Iterator*. Splits an array-of-records payload into one payload each.
  `src/Plugin/WebhookPayloadProcessor/ArrayIteratorProcessor.php`.

## Adding a plugin

Place a class in the module/other-module's matching `Plugin/<Type>/` namespace, add the attribute,
and implement the interface. Managers discover them automatically; new plugins appear in the relevant
config form select.
