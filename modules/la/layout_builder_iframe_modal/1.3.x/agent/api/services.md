# API — services & internals

The module exposes one small public helper service plus several internal machinery classes.
Autowiring is on (`_defaults: autowire: true`).

## Public helper

`Drupal\layout_builder_iframe_modal\IframeModalHelper`
(service id `layout_builder_iframe_modal.helper`, also aliased by class name for autowiring).

```php
public function isModalRoute(string $route_name): bool
```

Returns TRUE when `$route_name` appears in either `layout_builder_iframe_routes` or
`custom_routes` in `layout_builder_iframe_modal.settings`. This is the single decision point
used by the link and theme hooks. Inject it by type-hinting `IframeModalHelper`, or:

```php
$isModal = \Drupal::service(\Drupal\layout_builder_iframe_modal\IframeModalHelper::class)
  ->isModalRoute('layout_builder.add_block');
```

## Internals (read-only reference — you rarely call these directly)

- `Render\MainContent\IframeRenderer` — a `render.main_content_renderer` tagged for format
  `drupal_iframe` (based on core `DialogRenderer`). Instead of rendering the form, it renders
  an iframe pointing at the form route and issues `OpenIframeCommand`.
- `Ajax\OpenIframeCommand` — AJAX command that builds the iframe dialog on the client.
- `Ajax\ScrollToBlockCommand` — AJAX command to restore scroll position to the edited block.
- `Controller\RebuildController::rebuild` — backs routes
  `layout_builder_iframe_modal.rebuild` and `…rebuild_translated`; rebuilds the layout after
  a modal save (guarded by `_layout_builder_access`).
- `Controller\RedirectController::content` — backs `layout_builder_iframe_modal.redirect`
  (permission `access content`); renders the tiny `postMessage` page the inner form redirects
  to on success, which tells the parent window to close the modal and rebuild.
- `Hook\LinkHooks` — `hook_contextual_links_alter` + `hook_link_alter` rewrite matching
  dialog links to `data-dialog-type="iframe"`.
- `Hook\FormHooks` — `hook_form_alter` wiring for the iframed forms.
- `Hook\ThemeHooks` — `hook_theme` + `hook_preprocess_html` (see theming doc).

No hooks are *invited* for you to implement (no `.api.php`); customize via config, template
overrides, or by decorating `IframeModalHelper`.
