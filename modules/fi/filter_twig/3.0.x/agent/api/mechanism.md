# How the Twig filter renders (mechanism)

The whole module is one plugin: `src/Plugin/Filter/FilterTwig.php`.

```php
public function process($text, $langcode): FilterProcessResult {
  $build = [
    '#type' => 'inline_template',
    '#template' => $text,
  ];
  return new FilterProcessResult($this->renderer->render($build));
}
```

- The stored field text becomes the `#template` of a core **`inline_template`** render element,
  so it is compiled and executed by Drupal's Twig environment, then the rendered string is
  returned as the filtered output.
- The plugin injects the core `renderer` service (`ContainerFactoryPluginInterface::create`).
- Annotation: `@Filter(id = "filter_twig", title = "Replaces Twig values",
  type = TYPE_TRANSFORM_IRREVERSIBLE, settings = {})` — irreversible transform, no settings.
- `tips()` just links to the Drupal Twig docs; there is no config or state beyond the
  per-format `status` flag.

## Implications

- Because rendering runs through `inline_template`, the content is real Twig — expressions,
  loops, filters, and functions available to that environment all execute. Treat any
  Twig-enabled format as code-execution surface (see the configure doc's security caution).
- `TYPE_TRANSFORM_IRREVERSIBLE` means the transform is not reversed for editing — the raw Twig
  is what is stored and edited; only the rendered output is transformed.
- No hooks, services, events, or plugin types are defined, so there is nothing to implement
  against; the only integration point is enabling the filter on a format.
