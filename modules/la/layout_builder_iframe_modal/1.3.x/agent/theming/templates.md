# Theming — templates & theme hooks

Two theme hooks (from `hook_theme()` in `Hook\ThemeHooks`), two templates, one body class.

## Theme hooks

| Hook | Variables | Template | Purpose |
|---|---|---|---|
| `lbim_iframe` | `iframe_attributes` (default `NULL`) | `lbim-iframe.html.twig` | The `<iframe>` element rendered in the dialog. Override `iframe_attributes` to set width/height/class/etc. |
| `lbim_redirect` | (none) | `lbim-redirect.html.twig` | The tiny success page whose JS `postMessage`s the parent window to close the modal and rebuild. |

Override a template by copying `templates/lbim-iframe.html.twig` (or `lbim-redirect...`) into
your theme and clearing caches (`drush cr`). To set iframe attributes, implement a preprocess
in your theme:

```php
function MYTHEME_preprocess_lbim_iframe(array &$variables): void {
  $variables['iframe_attributes'] = new \Drupal\Core\Template\Attribute([
    'width' => '100%',
    'height' => '700',
    'class' => ['my-lb-iframe'],
  ]);
}
```

## The `layout-builder-iframe-modal` body class

`hook_preprocess_html` (in `Hook\ThemeHooks::preprocessHtml`) fires on every request. When the
current route is a modal route (`IframeModalHelper::isModalRoute()`), inside the iframe it:

- unsets page furniture — `page_top`, `page.header`, `page.pre_content`, `page.breadcrumb`,
  `page.footer`, and the page `#title` — so only the bare form shows; and
- adds the body class **`layout-builder-iframe-modal`**, which you can target from admin-theme
  CSS to further style the iframed form.

Shipped CSS/JS libraries: `layout_builder_iframe_modal/iframe` (`js/iframe.js`,
`css/iframe.css`) and `layout_builder_iframe_modal/redirect` (`js/redirect.js`,
`css/redirect.css`). You normally don't attach these yourself; the render/AJAX layer does.
