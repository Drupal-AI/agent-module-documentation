<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Renderer service, template, JS behavior & alter hook

## The renderer service

- Service id `mobile_native_share.renderer`; also aliased to the interface
  `Drupal\mobile_native_share\MobileNativeShareRendererInterface`.
- Class `Drupal\mobile_native_share\MobileNativeShareRenderer`; constructor args
  `@config.factory`, `@token`, `@request_stack`, `@extension.list.module`.
- Method: `render(?EntityInterface $entity = NULL): array`.

Programmatic use (block, controller, custom route):

```php
// With an entity — uses its canonical absolute URL + configured Title/Description.
$build = \Drupal::service('mobile_native_share.renderer')->render($node);

// Without an entity — falls back to the current request's _title attribute and URI.
$build = \Drupal::service('mobile_native_share.renderer')->render();
```

### What `render()` builds

- **Title**: per-bundle `entities.<type>.<bundle>.title` run through `token->replace()` with the
  entity as context; if empty, the entity's `label()`. Without an entity, the request `_title`
  attribute (or NULL).
- **Description**: per-bundle `...description` token-replaced; NULL if unset.
- **URL**: `$entity->toUrl('canonical', ['absolute' => TRUE])->toString()`; on exception, or when
  no entity, the current request URI (`requestStack->getCurrentRequest()->getUri()`).
- **Classes**: always `mn-share-button`; adds the `style` value when it is not `default`
  (e.g. `fixed-icon`); adds `icon-only` when `display_mode === 'icon_only'`.
- **Icon**: the configured `icon`, else `base_path() . <module path> . '/images/share.svg'`.
- Returns `#theme => 'mobile_native_share'` with `#url`, `#title`, `#description`, `#icon`,
  `#classes`, `#display_mode`, `#entity_type`, `#bundle`;
  `#cache['tags'] = config->getCacheTags()`; `#attached` library `mobile_native_share/share-button`.

## Template & theme suggestions

- Theme hook `mobile_native_share` (`hook_theme`) → `templates/mobile-native-share.html.twig`.
- Renders a `<button type="button" class="{{ classes|join(' ') }}">` with `data-url`, optional
  `data-title`, optional `data-description` (`|striptags`), `aria-label="Share"` in `icon_only`
  mode. Shows an `<img src="{{ icon }}" alt="" aria-hidden>` for icon modes and a
  `<span>Share</span>` for text modes. All variables emit through Twig autoescaping.
- `hook_theme_suggestions_mobile_native_share()` adds `mobile_native_share__<entity_type>` and
  `mobile_native_share__<entity_type>__<bundle>` — override markup per type/bundle.

## JS behavior

`js/share-button.js` (`Drupal.behaviors.mobileNativeShare`, using `core/once` on
`.mn-share-button`): on click it prevents default, reads `data-url/-title/-description`, then:

1. if `navigator.share` exists → `navigator.share({title, text, url})` (native share sheet);
2. else if `navigator.clipboard` → `writeText(url)` then an "Link copied to clipboard!" alert
   (falls back to `prompt()` on rejection);
3. else → `prompt('Copy this link:', url)`.

Library `mobile_native_share/share-button` also loads `css/share-button.css` and depends on
`core/drupal` + `core/once`. The Web Share API requires a secure context (HTTPS) and a user
gesture — hence the click handler.

## Extending entity types

`hook_mobile_native_share_entity_types_alter(array &$entity_types)`
(documented in `mobile_native_share.api.php`) mutates the default list before it is filtered to
existing `ContentEntityType`s. Example:

```php
function mymodule_mobile_native_share_entity_types_alter(array &$entity_types): void {
  $entity_types[] = 'paragraph';
}
```

The added type then appears on the settings form and, once a bundle is enabled, gets the
"Native share button" display component.
