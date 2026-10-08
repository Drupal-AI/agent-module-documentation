<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the "Field value from Current Entity" contextual filter default

On a view: add a **Contextual filter** (usually a numeric/string argument), then under
**When the filter value is NOT available in the URL** choose **Provide default value →
Field value from Current Entity**. The default-argument type id is
`current_entity_field_value`.

## Options (schema `views.argument_default.current_entity_field_value`)

| Option | Type | Default | Meaning |
|---|---|---|---|
| `entity_type_id` | select | `node` | Content entity type to resolve from the route. |
| `field_name` | select | `''` | Chosen field, stored as `field_name:property`. |
| `empty_value` | textfield | `''` | Returned when the field exists but is empty. |
| `multiple_values` | radios | `concatenate` | `concatenate` (join all deltas) or `single` (one delta). |
| `multiple_values_separator` | radios | `+` | `+` (OR) or `,` (AND); only for `concatenate`. |
| `single_value_delta` | number | `0` | Which delta to use when `multiple_values = single`. |

Notes on the field select: the form renders one field `<select>` per entity type and uses
`#states` to show only the one matching the chosen entity type (AJAX was avoided
deliberately — see the code comment). `submitOptionsForm()` flattens the per-entity-type
selection down to the single stored `field_name`.

## Runtime behaviour (`getArgument()`)
1. Load the entity: `routeMatch->getParameter(entity_type_id)`. If no such route parameter,
   the argument is `NULL`.
2. Split `field_name` into `[$field_name, $property]`.
3. If the entity lacks the field → `NULL`. If the field is empty → `empty_value` (or `NULL`).
4. Otherwise read `array_column($entity->{field}->getValue(), $property)`; concatenate with
   the separator, or return `single_value_delta` (default `NULL` if that delta is missing).
5. Merges `$entity->getCacheTags()` into `$this->view->element['#cache']['tags']`.

## Tips
- Use `+` with the "Allow multiple values" option (More section) for an OR match on a
  multi-value reference field; use `,` for AND.
- Pair `empty_value` with a matching **Exception value** (Exceptions section) so the whole
  filter is skipped when the current entity's field is empty.
- Choose the right property: `field_ref:target_id` for an entity-reference id,
  `field_link:uri`, etc. The main property is listed under the plain field name.
