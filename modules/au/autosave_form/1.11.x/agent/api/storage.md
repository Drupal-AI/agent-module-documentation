# Storage service

`autosave_form.entity_form_storage` — `AutosaveEntityFormDatabaseStorage` (interfaces
`AutosaveEntityFormStorageInterface` / `AutosaveFormBackendInterface`). Stores serialized
entity + form state in the database; used to check, restore and purge autosaved drafts.

Key methods:

| Method | Purpose |
|---|---|
| `storeEntityAndFormState($form_id, $form_session_id, $entity_type_id, $entity_id, $langcode, $uid, $timestamp, $entity, $form_state)` | Persist an autosave record. |
| `getEntityAndFormState(...)` | Retrieve stored entity + form state. |
| `getEntity(...)` / `getFormState(...)` | Retrieve one side only. |
| `hasAutosavedState($form_id, $entity_type_id, $entity_id, $langcode, $uid, $form_session_id = NULL)` | Is there a draft? |
| `hasAutosavedStateForFormState($form_state, $uid)` | Same, from a form state. |
| `getLastAutosavedStateTimestamp(...)` | Timestamp of the latest draft. |
| `purgeAutosavedEntityState($entity_type_id, $entity_id, ...)` | Delete drafts for one entity. |
| `purgeAutosavedEntitiesStates($entity_type_id = NULL, $langcode = NULL, $uid = NULL)` | Bulk purge. |

```php
$storage = \Drupal::service('autosave_form.entity_form_storage');
if ($storage->hasAutosavedState('node_article_edit_form', 'node', 5, 'en', $uid)) {
  $storage->purgeAutosavedEntityState('node', 5);
}
```
Drafts are purged automatically on entity insert/update/delete (see `.module`).
