# Hooks — verify a transition from another module

Declared in `moderated_content_bulk_publish.api.php`. During a bulk transition the module
calls `\Drupal::moduleHandler()->invokeAll(...)` for each translation, passing a single
`\Drupal\moderated_content_bulk_publish\HookObject` you mutate to control the outcome. Added
in early 2022 and used (optionally) by the safedelete module.

| Hook | Fired during |
|---|---|
| `hook_moderated_content_bulk_publish_verify_publish($hookObject)` | Publishing the latest revision |
| `hook_moderated_content_bulk_publish_verify_unpublish($hookObject)` | Unpublishing the current revision |
| `hook_moderated_content_bulk_publish_verify_archived($hookObject)` | Archiving the current revision |

The `$hookObject` carries context and result fields you can read and set, e.g. `nid`,
`bundle`, `langcode`, `body_field_val`, `validate_failure`, `error_message`, `show_button`,
`markup`, and message details (`msgdetail_isToken`, `msgdetail_isPublished`,
`msgdetail_isAbsoluteURL`). Set `error_message` / `validate_failure` (or `show_button` +
`markup`) to signal a failed verification and stop the transition.

```php
function mymodule_moderated_content_bulk_publish_verify_publish($hookObject): void {
  if (!$hookObject->nid) {
    $hookObject->validate_failure = TRUE;
    $hookObject->error_message = t('Invalid node.');
  }
}
```
