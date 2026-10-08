<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clone flow: routes, access, permissions, operations, form lifecycle

## 1. Link template on every entity type

`cloner_entity_type_alter()` → `Hook/Entity/EntityTypeAlter::__invoke()` sets, on **every** entity
type definition:

```
cloner-form  →  /cloner/{entity_type_id}/{{entity_type_id}}
```

So the template exists for all entity types, content and config alike.

## 2. Route generation

`EventSubscriber/ClonerSubscriber` subscribes to `RoutingEvents::ALTER`. For every entity type that
has a `cloner-form` link template (i.e. all of them), it adds a route
`entity.{entity_type_id}.cloner_form` with:

- `_form: \Drupal\cloner\Form\ClonerCloneForm`, `_title: Clone`
- requirement `_access_cloner_form: 'TRUE'` (triggers the custom access check; the value is ignored
  by the checker)
- option `_admin_route: TRUE`
- option `_cloner_entity_type_id: {entity_type_id}` (stashed for the form/access check to read)
- `parameters` upcasting the slug to `type: entity:{entity_type_id}` — Drupal loads the real entity;
  a non-existent id yields a param-converter 404.

## 3. Access check (`Access/AccessClonerForm`, service `cloner.access_cloner_form`)

Tagged `access_check, applies_to: _access_cloner_form`. Reads `_cloner_entity_type_id` from the route
and returns:

```php
AccessResult::allowedIfHasPermissions($account, [
  'access all entity cloner',
  "access $entity_type_id cloner",
], 'OR');
```

**This is the entire authorization for the clone route.** It checks only the two permissions — it
does **not** call `$entity->access('view')` on the source, nor create access for the destination
bundle, nor any bundle-level check.

## 4. Permissions (`cloner.permissions.yml` + `ClonerDynamicPermissions`)

- `access all entity cloner` — static, `restrict access: true` ("Bypass all checks for every form
  clone").
- `access {entity_type_id} cloner` — `ClonerDynamicPermissions::permissions()` generates one for
  **every** entity type on the site (label "Access to *{label}* cloner entity form"). These are NOT
  marked `restrict access`. (A `@todo` in the source notes they are generated for all types, not just
  ones with plugins.)

## 5. Entity operation link

`cloner_entity_operation()` → `Hook/Entity/EntityOperation::__invoke()` asks the form manager for
applicable plugins; if the winning plugin defines `entity_operation_label`, it adds an operation
`cloner` (weight 50) linking to `$entity->toUrl('cloner-form')`. This is a **GET link to the form
page**, not a mutating action. If no applicable plugin declares a label, no operation appears.

## 6. Form lifecycle (`Form/ClonerCloneForm`, a `FormBase`)

Constructor reads `_cloner_entity_type_id`, pulls the entity from the route match, and loads the
entity type definition.

- **buildForm** — `clonerFormPluginManager->isApplicable($entityType, $entity)`; if zero applicable
  plugins → `NotFoundHttpException` (404). Otherwise `array_shift` the highest-weight plugin, create
  it with `['entity' => $this->entity]`, call its `buildForm()`, then append a hidden
  `cloner_plugin_id`, a **Clone** submit, and a **Cancel** submit (`::cancelForm`,
  `#limit_validation_errors: []`).
- **validateForm** — re-instantiates the plugin by the hidden id and calls its `validateForm()`.
- **submitForm** — re-instantiates the form plugin; reads its `cloner_plugin_type`
  (content/config) and `cloner_plugin_id`; creates the matching cloner plugin (throws
  `PluginNotFoundException` if none); `$entity_cloned = $this->entity->createDuplicate()`; calls
  `cloneEntity($source, $cloned, ['form_state' => $form_state])`; `$entity_cloned->save()`; redirects
  to the clone's canonical URL.
- **cancelForm** — redirects to the source's canonical URL (or `<front>`).

Because this is a core `FormBase`, submit is POST with a CSRF form token — the mutating step is
CSRF-protected out of the box.

## Access model — what to know before you ship

The built-in check (step 3) is coarse: whoever holds `access {type} cloner` may clone **any** entity
of that type through the clone route, regardless of whether they can view the source or create the
destination bundle. `createDuplicate()` copies **all** fields verbatim (owner, unpublished status,
access-controlled field values included) before your `cloneEntity()` runs. If you need per-entity or
per-bundle enforcement, add it yourself — e.g. check `$this->getEntity()->access('view')` /
create access inside your `@ClonerForm` plugin's `isApplicable()`/`buildForm()`/`validateForm()`, or
gate the operation more tightly — rather than relying on the module's per-type permission alone.
