<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Endpoint: /api/cohesion/webform-list + siteStudioWebformElementList

Supports dynamically choosing the Webform a component shows (token-driven placement), instead of
hard-picking one in the `WebformElement` builder select.

## Route
`site_studio_webform_element.routing.yml`:
```yaml
site_studio_webform_element.webform_list:
  path: '/api/cohesion/webform-list'
  defaults:
    _title: 'Webform List'
    _controller: '\Drupal\...\Controller\WebformOptionListController::list'
  requirements:
    _permission: 'access content'
```
GET, read-only. No `configure` route / settings form exists in this module.

## Controller — `WebformOptionListController::list()`
`src/Controller/WebformOptionListController.php`. `final class` implementing
`ContainerInjectionInterface`; `create()` injects `entity_type.manager`. `list()`:
```php
$entities = entityTypeManager->getStorage('webform')->loadMultiple();
foreach ($entities as $entity) {
  $webforms[] = ['label' => $entity->label(), 'value' => $entity->id()];
}
return new CacheableJsonResponse($webforms);   // [{ "label": "...", "value": "..." }, ...]
```
Returns the label + id of all Webforms as JSON.

## JS helper + attachment
- `site_studio_webform_element.libraries.yml` defines library `webform_list` = `js/script.js`
  depending on `core/drupalSettings`.
- `site_studio_webform_element.module` `hook_page_attachments()` attaches that library on every
  page.
- `js/script.js` defines:
  ```js
  window.siteStudioWebformElementList = async function () {
    const response = await fetch(drupalSettings.path.baseUrl + 'api/cohesion/webform-list');
    if (response.ok) return await response.json();
  }
  ```

## Workflow — dynamic / token-based form selection
In a Site Studio **component form**, add a Select field and choose one of:
- **Options from a custom function** → function name `siteStudioWebformElementList` (the global
  above), or
- **External data source** → path `/api/cohesion/webform-list` (requires Site Studio 7.5.0+).

Then set the Webform element's `webform_id` in the Layout Canvas to the token of that Select field,
so a single component can render whichever Webform the editor selects at placement time.

## Operating notes
- The list includes all Webforms regardless of open/closed state — the returned `value` is the
  Webform machine id passed straight to `WebformElement::build()`.
- The response is a `CacheableJsonResponse` but the controller adds no cache tags/contexts, so it
  is effectively re-computed; the list changes only when Webforms are added/removed/renamed.
