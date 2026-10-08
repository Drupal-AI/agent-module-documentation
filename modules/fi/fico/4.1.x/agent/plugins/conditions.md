<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `field_formatter_condition` plugin type

Manager service `plugin.manager.field_formatter_condition`
(`\Drupal\fico\Plugin\FieldFormatterConditionManager`). Plugins live in
`Plugin/Field/FieldFormatter/Condition/`, extend
`\Drupal\fico\Plugin\FieldFormatterConditionBase`, and use the annotation
`@FieldFormatterCondition` (still annotation-based in 4.1.x, not PHP attributes).

## Annotation fields

- `id` — plugin id (stored as the condition value).
- `label` — shown in the condition select.
- `dsFields` (bool) — whether the condition is offered on Display Suite fields.
- `types` (array) — field types it applies to, or `{"all"}`.

## Methods to implement

```php
public function alterForm(array &$form, array $settings);   // condition settings form
public function access(array &$build, $field, array $settings); // set #access=FALSE to hide
public function summary(array $settings);                   // human summary on Manage display
```

`$settings` carries `entity_type`, `bundle`, `view_mode`, `field_name`, `field_type`, plus the
condition's own `settings` sub-array. Hide a field with
`$build[$field]['#access'] = FALSE;`. The base class also offers `getEntity($build)`,
`getEntityType($build)`, and `getEntityFields($entity_type, $bundle)` helpers.

## Built-in conditions

| id | Label | Notes |
|---|---|---|
| `hide_if_empty` | Hide when target field is empty | Select another field; type-aware emptiness (image/ref `target_id`, link `uri`, comment count, else `value`). |
| `hide_not_empty` | Hide when target field is not empty | Inverse of the above. |
| `hide_if_string` | Hide when target field contains a string | `target_field`, `string`, `single` (whole-word), `case_sensitive`; uses `fico_string_search()` (regex). Text field types only. |
| `hide_no_string` | Hide when target field lacks a string | Inverse string match. |
| `hide_if_bool_check` | Hide on a boolean field's value | Checks a boolean target field. |
| `hide_if_author` | Hide from the author | Compares current user to entity owner. |
| `hide_not_author` | Hide from non-authors | Show only to the author. |
| `hide_on_role` | Hide when current user has role | `roles` (multi), `include_admin` toggles hiding for user 1. |
| `hide_link_when_title_is_empty` | Hide a link field with empty title | For link fields. |
| `hide_on_pages` | Hide on specific pages | `visibility` (only-listed vs all-except), `pages` textarea, `*` wildcards; matches current path. |
| datetime condition | Hide date/time output | `HideDateTime` plugin. |

## Custom condition example

```php
// mymodule/src/Plugin/Field/FieldFormatter/Condition/HideForAnon.php
namespace Drupal\mymodule\Plugin\Field\FieldFormatter\Condition;

use Drupal\fico\Plugin\FieldFormatterConditionBase;

/**
 * @FieldFormatterCondition(
 *   id = "hide_for_anon",
 *   label = @Translation("Hide for anonymous users"),
 *   dsFields = TRUE,
 *   types = { "all" }
 * )
 */
class HideForAnon extends FieldFormatterConditionBase {
  public function alterForm(&$form, $settings) {}
  public function access(&$build, $field, $settings) {
    if (\Drupal::currentUser()->isAnonymous()) {
      $build[$field]['#access'] = FALSE;
    }
  }
  public function summary($settings) {
    return t('Condition: Hide for anonymous users');
  }
}
```

Definitions can be altered via `hook_fico_field_formatter_condition_info_alter()`.

Note: `access()` only removes the field from the render array — it is not entity/data access
control, and text-matching conditions match against admin-configured strings.
