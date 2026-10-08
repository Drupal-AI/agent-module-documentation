<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the per-instance limit is enforced (widgets & form alters)

The stored `cardinality_config` is only enforced at **form-render time**. All logic lives in
`\Drupal\field_config_cardinality\Hook\FieldConfigCardinalityHooks` (autowired service, invoked
from the legacy hooks in `.module`) plus a handful of widget subclasses. There is no plugin
*type* defined by this module — only widget plugin *implementations*.

## Widget class swaps — `hook_field_widget_info_alter()`

Existing core widget plugins are re-pointed to cardinality-aware subclasses (so no config change
is needed on displays already using them):

| Core widget id | Swapped class |
|---|---|
| `media_library_widget` | `CardinalityMediaLibraryWidget` |
| `image_image` | `CardinalityImageWidget` |
| `entity_reference_autocomplete` | `CardinalityEntityReferenceAutocompleteWidget` |

## Additional widget plugins the module provides

Selectable on **Manage form display** for the relevant field types:

| Widget id | Extends | Notes |
|---|---|---|
| `cardinality_email_default` | `EmailDefaultWidget` | cardinality-aware email widget |
| `cardinality_options_select` | `OptionsSelectWidget` | select respecting the instance limit |
| `cardinality_ief_simple` | `InlineEntityFormSimple` | only when `inline_entity_form` is installed |

## Form-alter enforcement

- `hook_field_widget_complete_form_alter()` — reads the instance's `cardinality_config`, stamps
  `data-fcc=<limit>` on the widget wrapper; for a `managed_file` widget hides deltas beyond
  `limit-1` (`#access = FALSE`); for a `select` with limit `1` sets `#multiple = FALSE`.
- `hook_preprocess_field_multiple_value_form()` — rebuilds the multi-value table to at most
  `cardinality_config` rows (sorted by `_weight`) and only shows the **"Add more"** button while
  the item count is below the limit (or the limit is `-1`).
- `hook_field_widget_single_element_form_alter()` — when `cardinality_config === '1'` and the
  element is `checkboxes`, converts it to `radios` (single-value UI).

## Consequences an agent should know

- The override is per **instance**; the shared storage keeps its own (higher-or-equal) cardinality.
- Enforcement is UI-level (the edit form caps rows/inputs); set the value via the third-party
  setting `field_config_cardinality.cardinality_config` (see
  [../configure/cardinality.md](../configure/cardinality.md)).
- Not every widget is covered; the README asks you to file an issue for unsupported widgets.
