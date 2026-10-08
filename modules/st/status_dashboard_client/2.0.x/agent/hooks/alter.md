# hook_status_dashboard_json_response_alter()

The only hook the module invites. Lets a module add to / modify the JSON report before it is
returned by `/status_dashboard/check`.

```php
/**
 * @param array &$json_response
 *   The response array being built (date, core, modules, security_updates,
 *   feature_updates, sitename, url, error_count).
 * @param array $projects_data
 *   Result of update_calculate_project_data() — per-project update metadata.
 */
function hook_status_dashboard_json_response_alter(array &$json_response, array $projects_data) {
  // Add PHP version.
  $json_response['php_version'] = phpversion();
  // Add last cron run.
  $json_response['cron_last_run'] = \Drupal::state()->get('system.cron_last');
}
```

Invoked via `$this->moduleHandler()->alter('status_dashboard_json_response', $json_response, $projects_data)`
at the end of `StatusDashboardClientController::doCheck()`. Use it to enrich the payload the
central Status Dashboard site consumes (custom telemetry, environment tags, etc.). Keys you add
are surfaced verbatim in the JSON; keep them JSON-serializable.
