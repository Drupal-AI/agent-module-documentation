# Webform Entity View — agent index

One Webform element plugin, `webform_entity_view`, that renders a build-time-selected entity in a chosen view
mode inside a webform. Display-only (extends `WebformMarkupBase`) — no stored value, no config schema, no
permissions, no routes, no Drush. Requires `webform`.

- **The element: config properties, the "Entity settings" form, how it loads & renders the entity, the access
  caveat** → [configure/element.md](configure/element.md)

Key facts:
- Plugin class `Drupal\webform_entity_view\Plugin\WebformElement\WebformEntityView` (`id: webform_entity_view`,
  category "Entity reference elements").
- Properties: `target_type`, `target_bundle`, `selected_entity` (entity id), `view_mode` (+ inherited title props).
- `prepare()` does `getViewBuilder($type)->view($entity, $view_mode, $langcode)`; on any exception it sets
  `#access = FALSE` and logs to the `webform_entity_view` channel.
