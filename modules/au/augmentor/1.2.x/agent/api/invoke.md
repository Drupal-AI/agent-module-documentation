<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invoking augmentors — field type/widgets, execute endpoint, Actions

There are three ways a configured augmentor gets run against content.

## 1. Field type + widgets (interactive, on entity forms)

**Field type** `field_augmentor_type` (`src/Plugin/Field/FieldType/AugmentorItem.php`): one big-text
`value` column, cardinality 1, category `Augmentor`, default widget `augmentor_default_widget`,
default formatter `field_augmentor_formatter`. The **formatter** (`AugmentorFormatter`) renders
**nothing** (`viewElements()` returns `[]`) — it is a UI affordance; the actual result is written
into *other* target fields by the widget's JavaScript.

**Widgets** all extend `AugmentorBaseWidget` (← core `TextareaWidget`) except the leaner
`AugmentorWidget`. On `formElement()` a widget:

- reads its settings (`augmentor`, `source_fields`, `targets`/`target_field`, `action`,
  `button_label`, per-widget extras);
- gathers current values of the configured **source fields** from the entity (files/images resolve
  to a URI/URL; text is passed through `strip_tags()` in `extractValue()`);
- attaches library **`augmentor/augmentor_library`** and a `drupalSettings.augmentor.execute_<field>`
  payload containing the execute-route `url`, the input, `augmentor` (uuid), `action`, `targets`,
  `explode_separator`, and a `type` discriminator;
- renders an **execute submit button** (`#access` = augmentor exists) that the JS turns into an AJAX
  call.

Per-widget `type` and extras:

| Widget id | `type` | Adds |
|---|---|---|
| `augmentor_default_widget` (`AugmentorDefaultWidget`) | `dynamic`/`static` | multi-target mapping |
| `augmentor_select_widget` | `select` | choose among multiple returned options |
| `augmentor_select_regex_widget` | `select_regex` | `regex`, `result_pattern`, `explode_separator`, `match_index` to parse the response |
| `augmentor_tags_widget` | `tags` | `explode_separator` → split into reference/tag values |
| `augmentor_summary_widget` | `summary` | targets a summary field; source built from targets |
| `augmentor_file_widget` | `file` | drops the `action` setting; sends a file URI |
| `augmentor_widget` (`AugmentorWidget`) | — | thin single-target variant with `target_field`/`explode_separator` |

Widget settings map source→target fields; `action` is `append`/`prepend`/`replace`; the eligible
field list comes from `AugmentorManager::isAugmentorValidTarget()` (`body`, `title`, `field_*`,
`schema_*`).

## 2. The execute endpoint (`AugmentorController::execute`)

Route `augmentor.augmentor_execute` — `POST /augmentor/execute/augmentor`, permission
`execute augmentor`. `js/augmentor_library.js` POSTs a JSON body `{augmentor, input, …}`. The
controller:

1. `Json::decode($request->getContent())`;
2. invokes `hook_pre_execute(&$decoded_request_body)`;
3. `augmentorManager->executeAugmentor($body['augmentor'], $body['input'])`;
4. invokes `hook_post_execute(&$result, &$decoded_request_body)`;
5. returns `JsonResponse` — 400 with `_errors` if the result contains `_errors`, else the
   JSON-encoded result (`JSON_UNESCAPED_SLASHES|JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE`).

The response is consumed by the JS, which applies the value to the target field(s) client-side per
the widget's `action`/`type`. The controller **does not** write to the entity — persistence happens
when the editor saves the form normally.

## 3. Entity Actions (bulk / Views VBO / no UI)

Derived per content-entity-type by `AugmentorActionDeriver` (applies to content entity types that
have a bundle entity type).

- **`entity:augmentor_action`** (`AugmentorAction`) — config: `source_fields[]`,
  `targets[]{target_field,key}`, `augmentor`, `action`, `text_format`, `explode_separator`.
  `execute($object)` concatenates the source fields' strings, runs the augmentor, then for each
  target writes `$result[$key]` into the field — as `{value,format:text_format}` for
  `text_long`/`text_with_summary`, as an exploded array for `entity_reference` (+
  `explode_separator`), else raw. `access()` returns **allowed** (gate via the operation/VBO
  permission and entity access at the call site).
- **`entity:augmentor_action_minimal`** (`AugmentorActionMinimal`) — same behaviour but with a
  flat form of up to **10** `source_field_N` / `target_field_N` / `response_key_N` rows instead of
  the dynamic targets fieldset.

Both build their field option lists via `isAugmentorValidTarget()` and their augmentor option list
from `getAugmentors()`. `text_format` uses `FilterFormatRepositoryInterface::getFormatsForAccount()`
(with a `filter_formats()` back-compat fallback), so generated rich text is filtered by a chosen
format on save.
