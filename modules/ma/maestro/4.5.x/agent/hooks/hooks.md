# Maestro — hooks (`maestro.hooks.api.php`)

Implement any of these in `your_module.module` to extend the engine.

## Assignment & access
- `hook_maestro_post_fetch_assigned_queue_tasks($userID, &$queueIDs)` — alter the list of queue ids
  assigned to a user.
- `hook_maestro_can_user_execute_task_alter(&$returnValue, $queueID, $userID)` — override task
  execution access (e.g. for known-anonymous flows).
- `hook_maestro_post_production_assignments($templateMachineName, $taskID, $queueID)` — react after a
  task's assignments are provisioned.

## Process variables & entity tokens
- `hook_maestro_post_variable_save($variableName, $variableValue, $processID)` — after a process
  variable is saved.
- `hook_maestro_get_entity_token_value($entity, $token_name, $original, $token_parts, &$replacements)`
  — provide values for Maestro entity tokens.

## Validation
- `hook_maestro_template_validation_check($templateMachineName, &$validation_failure_tasks, &$validation_information_tasks)`
  — add custom template validation results.
- `hook_maestro_pre_task_save($templateMachineName, $taskID, &$task, $taskAssignments, $taskNotifications)`
  — mutate a task before it is saved to the template.

## Notifications
- `hook_maestro_production_NOTIFICATIONTYPE_notification($queueID, $notification, &$notificationList)`
  — customize the recipient list for a notification type.
- `hook_maestro_zero_user_notification($templateMachineName, $taskMachineName, $queueID, $notificationType)`
  — handle the "no assignee" case.

## Task Console UI alters
- `hook_maestro_task_console_interactive_link_alter(&$link, …)`,
  `..._alter_execution_link(&$execute_link, …)`,
  `..._interactive_url_alter(&$handler, &$query_options, …)`,
  `..._custominformation_alter(&$customInformation, …)`,
  `..._taskdetails_alter(&$taskDetails, …)`,
  `hook_maestro_task_console_status_bar_alter(&$status_bar, $processID)`,
  `hook_maestro_process_status_alter(&$taskDetails, $processID, $template)`.

## Handler registries
- `hook_maestro_interactive_handlers()` / `hook_maestro_batch_handlers()` — register named handler
  functions selectable on interactive / batch-function tasks.

## Webform integration (used by `maestro_webform`)
- `hook_maestro_webform_submission_form($queueID, &$form, &$webformEngineTask)`,
  `..._set_cancel_completion_status($queueID, &$form, &$form_state, $triggeringElement, &$completeTask)`,
  `..._submission_form_submit($queueID, &$form, &$form_state, $triggeringElement)`.

## Set-Process-Variable plugin hooks
- `hook_maestro_set_process_variable_entity_field_list_alter($entity_field_list)`,
  `hook_maestro_set_process_variable_entity_types_list($entity_types)`,
  `hook_maestro_spv_set_number_of_items_plugin($queueID, $processID, $task, $tpl, &$returnValue)`,
  `hook_maestro_spv_get_field_value_delta_with_pv(…, &$returnValue)`,
  `hook_maestro_spv_get_content_type_field_value_plugin(…, &$returnValue)`.
