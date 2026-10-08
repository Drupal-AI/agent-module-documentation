<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Page — configuration, routes, and the render mechanism

Everything the module does, grounded in source. No entity type, field type, plugin, permission, hook,
or Drush command is defined — only the pieces below.

## Install / enable

- `composer require drupal/static_page` then `drush en static_page`. Dependency: core `node` only
  (`static_page.info.yml`). Enabling does nothing on its own — `config/install/static_page.fields.yml`
  ships `fields: {}`, so no content type renders statically until you map one.

## Settings form (`StaticPageSettingsForm`)

- Route `static_page.settings` → path `/admin/config/content/static_page`, `_form:
  \Drupal\static_page\Form\StaticPageSettingsForm`, requirement `_permission: 'administer site
  configuration'` (`static_page.routing.yml`). Menu link under *Configuration → Content authoring*
  (`static_page.links.menu.yml`, parent `system.admin_config_content`).
- Class extends `ConfigFormBase`; `getEditableConfigNames()` / `getFormId()` = `static_page.fields` /
  `static_page_config_form`. Injects `entity_field.manager` and `entity_type.manager` via `create()`.
- `buildForm()`: loads all `node_type` entities; for each bundle it iterates
  `entityFieldManager->getFieldDefinitions('node', $bundle)` and offers a `select` (`#tree` under
  `fields`) whose options are the fields whose `getType()` is in `['string_long','text_long',
  'text_with_summary']` and whose name is not `revision_log`, plus a `-- None --` (empty) option.
  Default value comes from the existing `static_page.fields:fields[$bundle]`.
- `submitForm()`: `$this->config('static_page.fields')->set('fields',
  array_filter($form_state->getValue('fields')))->save()` — `array_filter` drops the empty
  (`-- None --`) selections, so a bundle set to None is removed from the map.

## Config object & schema

- Object **`static_page.fields`**, mapping `fields` = `sequence` of `string` keyed by node-type
  machine name → field machine name (`config/schema/static_page.schema.yml`, type `config_object`,
  label *"Static page field mapping"*). Install default `fields: {}`.
- Example after mapping the `landing` bundle to its `body` field:

  ```yaml
  # static_page.fields
  fields:
    landing: body
  ```

  `provides_config_schema: true`; the object is exportable/syncable like any config.

## The render subscriber (`StaticPageSubscriber`)

- Service `static_page.subscriber` (`static_page.services.yml`), class
  `Drupal\static_page\EventSubscriber\StaticPageSubscriber`, args `@current_route_match`,
  `@entity_type.manager`, `@config.factory`, tag `event_subscriber`.
- `getSubscribedEvents()` registers only `KernelEvents::REQUEST => ['onRequest']` (default priority 0;
  no explicit priority, so it runs after core's `RouterListener` has already matched the route and
  enforced route/entity access).
- `onRequest(RequestEvent $event)`:
  - If route is `entity.node.canonical` → `$node = routeMatch->getParameter('node')`.
  - Else if route is `entity.node.revision` → `$vid = (int) routeMatch->getRawParameter('node_revision')`
    and `$node = entityTypeManager->getStorage('node')->loadRevision($vid)`.
  - If a node was resolved: `$type = $node->getType()`; read `$static_fields =
    configFactory->get('static_page.fields')->get('fields')`; if `$static_fields[$type]` is set,
    take `$static_page = $node->get($static_fields[$type])->value` and
    `$event->setResponse(new Response($static_page))`.
- Effect: for a node of a mapped bundle, the response is the field's stored value emitted directly as
  the page body (default `text/html`, HTTP 200). The theme, blocks, regions, libraries, page template,
  and the field's normal display formatter are all skipped. Unmapped bundles fall through to normal
  rendering.

## Operating notes

- The node **title** is only for the admin content list; visitors see exactly the field value. Authors
  put the complete page source (their own `<head>`, `<style>`, `<script>`) into the field.
- Access to the page is still governed by the node's own route access (published status / node grants),
  because access checking happens in routing before this priority-0 subscriber runs — the subscriber
  only swaps the response body for nodes the visitor is already allowed to view.
- The revision route additionally requires the core revision-view access the router enforces.
- To disable static behavior for a bundle, set its select back to *-- None --* and save; to disable
  the module entirely, uninstall it (leaves nodes/fields intact).

## Tests (for reference)

- `tests/src/Functional/StaticPageTest.php` and `tests/src/Kernel/StaticPageConfigTest.php` exercise the
  config mapping and the raw-output behavior.
