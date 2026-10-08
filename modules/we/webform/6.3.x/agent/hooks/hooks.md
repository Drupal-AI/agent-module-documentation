# Webform hooks

Full signatures in `webform.api.php`. Implement in `mymod.module` (or an OOP hook class).

## Plugin info alters
- `hook_webform_element_info_alter(&$definitions)` — add/change element plugin definitions.
- `hook_webform_handler_info_alter(&$handlers)`
- `hook_webform_variant_info_alter(&$variants)`
- `hook_webform_source_entity_info_alter(&$definitions)`

## Elements
- `hook_webform_element_default_properties_alter(&$properties, &$definition)`
- `hook_webform_element_translatable_properties_alter(&$properties, &$definition)`
- `hook_webform_element_configuration_form_alter(&$form, $form_state)`
- `hook_webform_element_alter(&$element, $form_state, $context)` — alter a rendered element.
- `hook_webform_element_ELEMENT_TYPE_alter(...)` — per element `#type`.
- `hook_webform_element_access($operation, $element, $account, $entity_type)` — grant/deny.
- `hook_webform_element_input_masks()` / `_alter()` — register input-mask patterns.

## Options
- `hook_webform_options_alter(&$options, &$element, $id)`
- `hook_webform_options_OPTIONS_ID_alter(...)` — dynamic named option lists.

## Submissions & access
- `hook_webform_submission_form_alter(&$form, $form_state, $webform_id)`
- `hook_webform_submission_access($webform, $submission, $op, $account)`
- `hook_webform_submission_query_access_alter($query, $context)`
- `hook_webform_submissions_pre_purge($ids)` / `hook_webform_submissions_post_purge($ids)`
- `hook_webform_access_rules()` / `_alter()` — define custom access-rule permissions.

## Handlers, help, libraries, messages
- `hook_webform_handler_invoke_alter()` / `hook_webform_handler_invoke_METHOD_NAME_alter()`
- `hook_webform_third_party_settings_form_alter()` /
  `hook_webform_admin_third_party_settings_form_alter()` — add third-party settings to forms/global.
- `hook_webform_libraries_info()` / `_alter()` — declare optional external libraries.
- `hook_webform_help_info()` / `_alter()` — add help/notification entries.
- `hook_webform_message_custom($operation, $id)` — custom close/reset message handling.
