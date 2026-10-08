# Twig Slugify — the `slugify` filter

## Registration

`Drupal\twig_slugify\SlugifyTwigExtension` (`twig_slugify.services.yml`, service
`twig_slugify.slugify`, tagged `twig.extension`; constructed with `@renderer`). `getFilters()` returns
one `TwigFilter` named `slugify` mapped to the static method `SlugifyTwigExtension::slugify()`.

## Usage in templates

```twig
{{ 'Hello World!'|slugify }}            {# hello-world #}
{{ node.label|slugify }}
{{ title|slugify({'separator': '_'}) }}  {# hello_world #}
{{ title|slugify({'lowercase': false}) }}
```

Signature: `slugify(string $string, array $options = []): string`. It creates a fresh
`Cocur\Slugify\Slugify` and returns `->slugify($string, $options)`. The `$options` array is passed
straight to cocur/slugify, so any of its options apply, e.g.:

- `separator` — the word separator (default `-`).
- `lowercase` — bool, force lowercase (default true).
- `regexp` — custom regex of allowed characters.
- `rulesets` — transliteration rulesets (e.g. language-specific).
- `lowercase_after_regexp`, `strip_tags`, `trim` — see the cocur/slugify docs.

No configuration is needed; the filter is available anywhere Twig renders once the module is enabled.
