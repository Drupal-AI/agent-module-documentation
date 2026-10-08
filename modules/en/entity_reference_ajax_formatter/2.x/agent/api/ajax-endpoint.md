<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Load-More AJAX route & controller

## Route

Defined in `entity_reference_ajax_formatter.routing.yml`:

```yaml
entity_reference_ajax_formatter.ajax_field:
  path: '/ajax_field/{entity_type}/{entity}/{field_name}/{view_mode}/{language}/{start}/{printed}'
  defaults:
    _controller: '\Drupal\entity_reference_ajax_formatter\Controller\EntityReferenceAjaxController::viewField'
    _title: 'Entity Reference Ajax Controller'
    printed: null
  options:
    parameters:
      entity:
        type: entity:{entity_type}
    no_cache: true
  requirements:
    _permission: 'access content'
```

- `{entity}` is upcast to a loaded entity via `type: entity:{entity_type}` (dynamic entity type
  from the earlier path slug).
- `printed` defaults to `null`; the response is marked `no_cache: true`.
- The route is a plain **GET** render endpoint (no `_csrf_token`, none needed — it performs no
  state change).

## Controller — `EntityReferenceAjaxController::viewField()`

`src/Controller/EntityReferenceAjaxController.php`, extends `ControllerBase`, `create()` injects the
`renderer` service.

Signature: `viewField(EntityInterface $entity, string $field_name, string $view_mode,
string $language, int $start, ?string $printed)`. Steps:

1. Throws `BadRequestHttpException('Requested Entity is not a Content Entity.')` if `$entity` is not
   a `ContentEntityInterface`.
2. Resolves the field: `$field = $entity->getTranslation($language)->get($field_name)`; throws
   `BadRequestHttpException('Requested Field does not exist.')` if falsy.
3. Renders `$field->view($view_mode)` and returns an `AjaxResponse` carrying a single
   `ReplaceCommand` whose selector is
   `#ajax-field-{entity_type_id}-{entity_id}-{field_name}` — the exact container id the formatter
   emitted around its Load-More link — so the response replaces that container with the next batch.

Because the formatter renders the reference field with `entity_reference_ajax_entity_view` (the
formatter reads `start`/`printed` from the current route in `viewElements()`), the ajax re-render of
that same field continues from the requested offset and appends a fresh Load-More link when more
items remain.

## Operating notes

- The `start` and `printed` values are supplied by the module-generated Load-More link (offset and,
  for random sort, the already-shown ids). `view_mode`/`language` mirror the field's configured
  display and the render language.
- The response replaces the container in place; `core/drupal.ajax` (attached by the formatter)
  drives the client-side swap via the link's `use-ajax` class.
