# Hooks (`pdf_using_mpdf.api.php`)

Both hooks fire only on the node route (`GeneratePdf::generate`), once per PDF, and receive the
processed node. They are the intended way to vary output per content type / use case.

## `hook_mpdf_html_alter(string &$html, \Drupal\node\NodeInterface $node)`

Alter the rendered HTML just before it is written to mPDF (after the node is rendered, after
`hook_mpdf_settings_alter`). Append/replace markup.

```php
function MYMODULE_mpdf_html_alter(&$html, \Drupal\node\NodeInterface $node) {
  if ($node->getType() === 'page') {
    $html .= '<div>Generated ' . date('Y-m-d') . '</div>';
  }
}
```

## `hook_mpdf_settings_alter(array &$settings, \Drupal\node\NodeInterface $node)`

Override any setting key (see configure/settings.md) for this node before conversion — e.g. a
different header, page size, or watermark per bundle.

```php
function MYMODULE_mpdf_settings_alter(array &$settings, \Drupal\node\NodeInterface $node) {
  if ($node->getType() === 'article') {
    $settings['pdf_header'] = "{PAGENO}\n<hr>";
  }
}
```

Note: these alters run only for the node route. When you call
`pdf_using_mpdf.conversion::convert()` directly, pass overrides via the `$settings` argument
instead (the hooks are not invoked there).
