<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Route, local task, controller & service

Everything the module provides. All claims cite `edit_content_type_tab/*`.

## Install / enable

`composer require drupal/edit_content_type_tab`, then enable `edit_content_type_tab`
(`drush en edit_content_type_tab`). No configuration step — the tab appears automatically on node
canonical pages for users with the `administer content types` permission. `.info.yml` declares
`core_version_requirement: ^9 || ^10 || ^11`, `package: Development`, and no `dependencies`.

## Route (`edit_content_type_tab.routing.yml`)

- `edit_content_type_tab.editor`
  - path: `/node/{node}/edit_content_type_tab`
  - `_controller: \Drupal\edit_content_type_tab\Controller\EditController::editLink`
  - requirement: `_permission: 'administer content types'`
- `{node}` is a raw route slug typed as `int $node` in the controller (there is **no**
  `type: entity:node` parameter conversion / `_entity_access` check declared).

## Local task tab (`edit_content_type_tab.links.task.yml`)

- `edit_content_type_tab.editor`: `route_name: edit_content_type_tab.editor`,
  `base_route: entity.node.canonical`, `weight: 15`,
  `title: "Edit '@type_name' type"`, `class: \Drupal\edit_content_type_tab\Plugin\Menu\EditTab`.
- So the tab renders on the node view page; its access follows the target route's
  `administer content types` permission.

## Controller (`src/Controller/EditController.php`)

`EditController extends ControllerBase`. `editLink(int $node)`:

1. `$loadedNode = \Drupal::entityTypeManager()->getStorage('node')->load($node);`
2. `$nodeType = $loadedNode->getType();`
3. `$url = Url::fromUri('base://admin/structure/types/manage/' . $nodeType);`
4. `$url->setOptions(['query' => ['destination' => 'node/' . $node]]);`
5. returns `new RedirectResponse($url->toString());`

The redirect target is the **core content type management form**, itself protected by
`administer content types`. The controller does not modify the node or the content type; it only
builds a redirect. The type string comes from the loaded node's own bundle, not from request input.

## Local task title plugin (`src/Plugin/Menu/EditTab.php`)

`EditTab extends LocalTaskDefault` (uses `StringTranslationTrait`). `getTitle()`:

- Reads the current node via the module's request service:
  `\Drupal::service('edit_content_type_tab.request_service')`, `setRequest(\Drupal::request())`,
  then `getRequest()->attributes->get('node')`.
- If the attribute is an object (a real node), it derives the label with
  `node_get_type_label($node)` and returns `$this->t($parameter, ['@type_name' => $type], $options)`
  where `$parameter` is the task definition's `title` render. Otherwise returns `''` (empty title),
  so the tab is suppressed on paths that merely carry a `node` parameter but no node object.

## Request service (`src/RequestService.php` + `edit_content_type_tab.services.yml`)

- Service id `edit_content_type_tab.request_service` → class `RequestService`.
- A thin wrapper holding a `\Symfony\Component\HttpFoundation\Request` with `setRequest()` /
  `getRequest()`. Its stated purpose (docblock) is to avoid binding the tab title logic directly to
  the HTTP request. It performs no access or validation logic.

## Operating notes

- The module has **no settings form** (`configure` is null), **no permissions.yml**, **no config
  schema**, **no hooks**, **no Drush**.
- To hide the tab, revoke `administer content types` from the role (that permission also controls
  the core form the tab targets).
