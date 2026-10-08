# The inline save path and its access checks

Source: `src/Form/AjaxToggleForm.php`. The formatter renders one of these forms per field item.
It is a standard `FormBase` built through `form_builder`, so the entity/field/delta are bound at
render time and the value flows back through Drupal's AJAX form pipeline.

## Flow

1. `ToggleEditableFormatter::viewElements()` creates the form via `class_resolver` and calls
   `setFieldItem($item, $settings)`, which stashes `$entity`, `$fieldName`, `$delta`,
   `$defaultValue` on the form object.
2. `buildForm()` renders a single `checkbox` with `#ajax` on the `change` event
   (callback `formListAjax`) and
   `#disabled => !($this->fieldIsEditable() || $this->checkEditFieldAccess())`.
3. On flip, `formListAjax()` reads the triggering element's submitted value and calls
   `updateFieldValue($value)`, then returns an empty `AjaxResponse`. `submitForm()` is a no-op.
4. `updateFieldValue()` re-checks access, then `$entity->get($field)->set($delta, $value)` and
   `$entity->save()`.

Because the form object (with the bound entity) is carried in the cached form state across the
AJAX round-trip, the user only ever controls the boolean value — not which entity/field/delta is
written.

## Access model (the guard that matters)

`updateFieldValue()` only writes when `fieldIsEditable() || checkEditFieldAccess()` is true:

- `checkEditFieldAccess()` — calls the entity type's access control handler
  `fieldAccess('edit', $fieldDefinition, $currentUser, $parent)`. If field access is granted and
  **no** `field_permissions` third-party `permission_type` is set on the field storage, it falls
  back to `$entity->access('update')`. Otherwise it returns the field-level result.
- `fieldIsEditable()` = `$entity->access('update') && checkEditFieldAccess()`.

Since `fieldIsEditable()` already includes `checkEditFieldAccess()`, the effective server-side
guard reduces to `checkEditFieldAccess()` — i.e. **field `edit` access, and by default the
entity `update` access**. The same expression drives `#disabled`, so the client control and the
server write use one gate.

## Security note (checked, no finding)

The brief flagged this save path. The write **is** access-checked (`checkEditFieldAccess()` runs
inside `updateFieldValue()` before `save()`), so it is not an unauthenticated/low-priv bypass:
an anonymous or read-only user gets a disabled switch and, even if they forge the AJAX request,
the save is skipped. CSRF is covered by Drupal's Form API — the submission carries the form
build id + token validated by `form_builder`, so no separate CSRF check is needed.

## Extending

There is no plugin/hook API. To change behavior you would subclass `AjaxToggleForm` (override
`updateFieldValue()` / `checkEditFieldAccess()`) or the `ToggleEditableFormatter`. Note the
formatter is hardcoded to `boolean` field types; supporting other types means a new formatter.
