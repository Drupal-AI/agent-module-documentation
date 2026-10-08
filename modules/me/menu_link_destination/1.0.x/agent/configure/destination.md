<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — menu_link_destination

## YAML-defined menu links
Add `destination: true` to the link definition:
```yaml
my_menu.link:
  title: 'My link'
  route_name: 'some.route'
  menu_name: menu
  destination: true
```
`hook_menu_links_discovered_alter()` copies this to `options.menu_link_destination = TRUE`.

## menu_link_content (UI) links
On the menu link add/edit form a checkbox **"Add a destination query parameter"** is added (`menu_link_destination_form_menu_link_content_menu_link_content_form_alter`); its value is written into the link's `options` by the entity builder `menu_link_destination_form_entity_builder`.

## Runtime behaviour
- `hook_link_alter()`: if `options.menu_link_destination` is set and the URL has no explicit `query.destination`, it injects `query.destination = \Drupal::service('redirect.destination')->get()` (the current request's destination or path).
- An explicitly configured `destination` is **not** overridden.
- `MenuLinkDestination::preRenderLink()` (registered via `hook_element_info_alter` on the `link` element, `TrustedCallbackInterface`) adds the `url` cache context so links that embed the current URL cache correctly.

## Notes
- The destination string comes from core's `redirect.destination`; core rejects external destinations when redirecting, so there is no new open-redirect vector.
- `menu_link_content` is only needed for the UI checkbox; YAML links work with core alone (>=10).
