# AOS JS UI — `aosjs.animate_manager` service

Service id `aosjs.animate_manager` → `Drupal\aosjs_ui\AosJsManager` (constructor arg: `@database`;
tagged `backend_overridable`). All access to the `aos` table goes through it. Interface:
`AosJsManagerInterface`.

Methods:

| Method | Returns | Notes |
|---|---|---|
| `isAnimate($selector)` | bool | true if a row with that `selector` exists. Parameterized query. |
| `loadAnimate()` | statement | Enabled rows (`status = 1`), fields `aid, selector, options`. Used at render time. |
| `addAnimate($aos_id, $selector, $label, $comment, $changed, $status, $options)` | insert id | `MERGE` keyed on `aid` (upsert). `$options` must be a pre-serialized string. |
| `removeAnimate($aos_id)` | void | delete by `aid`. |
| `findAll($header = [], $search = '', $status = NULL)` | statement | Paged (50/page) + table-sorted list for the admin UI. `$search` is `escapeLike()`-escaped, `*` → `%`, matched against `selector`/`label`. Optional `status` filter. |
| `findById($aos_id)` | assoc array | single row (`selector, label, comment, status, options`). |

Example (read enabled targets):

```php
$rows = \Drupal::service('aosjs.animate_manager')->loadAnimate()->fetchAll();
foreach ($rows as $row) {
  $options = unserialize($row->options, ['allowed_classes' => FALSE]);
  // $row->selector, $options[...]
}
```

Notes:
- Queries use placeholders / `escapeLike()` — no string-concatenated user input into SQL.
- Options are always unserialized with `['allowed_classes' => FALSE]`, so no object instantiation from stored data.
- Override the service by supplying an alternative backend (it is `backend_overridable`).
