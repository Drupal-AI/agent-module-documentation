# Preview route, services and runtime flow

The module mirrors core's node-preview mechanism for arbitrary content entities. The "entity" being
previewed is never saved — it is the in-memory entity carried by the edit form's `FormState`, stashed
in a per-user private tempstore and rendered by a dedicated route.

## Route `preview.entity_preview`

```
path: /preview/{entity_preview}/{view_mode_id}
_controller:      \Drupal\preview\Controller\PreviewController::view
_title_callback:  \Drupal\preview\Controller\PreviewController::title
requirements:     _entity_preview_access: '{preview}'
options.parameters.entity_preview.type: entity_preview
```

- `{entity_preview}` is an **entity UUID string**, upcast by the `entity_preview` param converter.
- `{view_mode_id}` is the view mode to render in (`default` if none).

### Controller — `PreviewController` (extends core `EntityViewController`)

`view($entity_preview, $view_mode_id = 'default')` sets `$entity->preview_view_mode = $view_mode_id`,
delegates to the core entity view builder via `parent::view()`, then `unset($build['#cache'])` so a
preview is not render-cached. `title()` returns the context translation's `label()`.

### Param converter — `entity_preview` (`PreviewConverter`)

`applies()` matches any route parameter whose `type` is `entity_preview`. `convert($uuid …)` returns
`preview.storage`'s `getPreviewEntity($uuid)` — i.e. it pulls the pending entity out of the current
user's private tempstore. Returns `NULL` (→ 404) when no preview is pending for that UUID.

### Access check — `access_check.entity.preview` (`EntityPreviewAccessCheck`)

Tagged `access_check` with `applies_to: _entity_preview_access`. Given the resolved entity:

- new entity (`isNew()`): returns `createAccess($bundle, $account)` for its entity type;
- existing entity: returns `$entity->access('update', $account)`.

So the preview page enforces the entity's own create/update access — the same gate core uses for node
preview — evaluated against the entity restored from the viewer's own tempstore.

## Service `preview.storage` — `PreviewStorageInterface`

Public integration API (id `preview.storage`, class `Drupal\preview\PreviewStorage`, interface alias
`Drupal\preview\PreviewStorageInterface`). Wraps the private tempstore collection named by the
constant `PreviewStorageInterface::TEMPSTORE_NAME` = `'entity_preview'` (built from `tempstore.private`,
resolved once per instance).

| Method | Returns | Purpose |
| --- | --- | --- |
| `getFormState(string $uuid)` | `?FormStateInterface` | Pending stored form state for a UUID, or NULL. |
| `setFormState(string $uuid, FormStateInterface $fs)` | `void` | Store the form state (what `PreviewHooks::preview()` does). |
| `getPreviewEntity(string $uuid)` | `?EntityInterface` | The in-memory entity (unsaved values applied) from the stored form's `EntityFormInterface`, or NULL. |
| `deletePreview(string $uuid)` | `void` | Drop the pending preview (done on save). |

```php
/** @var \Drupal\preview\PreviewStorageInterface $storage */
$storage = \Drupal::service('preview.storage');
$entity = $storage->getPreviewEntity($uuid); // NULL if no pending preview for this user
```

Because the store is `tempstore.private`, entries are namespaced to the owning user; one user cannot
resolve another user's pending preview UUID.

## Runtime flow (implemented in `PreviewHooks`, service `Drupal\preview\Hook\PreviewHooks`)

1. **`hook_form_alter`** — on a `ContentEntityFormInterface` whose `entity_type/bundle` is present in
   `preview.settings.enabled` *and* passes `EntityPreviewAccessCheck`, adds a **Preview** submit
   button (`::submitForm` then `PreviewHooks::preview`) and appends `PreviewHooks::cleanup` to the
   real Save submit handlers. If the request carries `?uuid=` and a matching stored form state exists,
   it re-applies the previewed user input/storage and rebuilds the form (restore-from-preview path).
2. **`preview()`** — sets `$entity->in_preview = TRUE`, calls `setFormState($entity->uuid(), $form_state)`,
   and redirects to `preview.entity_preview` using the bundle's configured default view mode.
3. **`hook_page_top`** — on the `preview.entity_preview` route, renders `PreviewForm`
   (`preview_form_select`): a view-mode `<select>` (autosubmit) plus the "Back to editing" link
   (see [../events/back-link.md](../events/back-link.md)). Switching redirects back to the preview
   route with the new `view_mode_id`.
4. **`cleanup()`** — on the entity's real Save, calls `deletePreview($entity->uuid())` to clear the
   tempstore.

## Update hook

`preview_update_10001` (`preview.install`) reshapes older raw config into `preview.settings.enabled`.
