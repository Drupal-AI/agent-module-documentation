<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `format_bytes` Twig filter

The entire module is one Twig extension. It adds a single filter, `format_bytes`, usable in
any Twig template once the module is enabled.

## What it does

`{{ value | format_bytes }}` takes a raw byte count (an integer or numeric string) and returns
a human-readable size string. It is a thin wrapper: the filter is registered as

```php
new TwigFilter('format_bytes', 'Drupal\Core\StringTranslation\ByteSizeMarkup::create');
```

so it delegates directly to core `ByteSizeMarkup::create()` (which wraps `format_size()`).
Output is translatable, locale-aware markup using binary steps (1024):

| Input (bytes) | Output |
|---|---|
| `1048576` | `1 MB` |
| `1073741824` | `1 GB` |
| `5242880` | `5 MB` |
| `1234567890` | `1.15 GB` |

Round values render without decimals; non-round values get two decimals.

## Typical usage

```twig
{# A managed file's stored filesize #}
{{ node.field_attachment.entity.field_file.entity.filesize.value | format_bytes }}

{# Any numeric variable #}
{{ total_bytes | format_bytes }}
```

## Mechanism (so you don't need to read src/)

- Service id: `format_bytes.twig_extension`, class
  `Drupal\format_bytes\Twig\ByteConversionTwigExtension`, tagged `{ name: twig.extension }`
  in `format_bytes.services.yml`.
- The class extends `Twig\Extension\AbstractExtension` and implements only `getFilters()`,
  returning the single `format_bytes` filter above. There is no `getFunctions()`, no state,
  no options.

## Scriptable check (no template needed)

You can exercise the filter through the Twig service:

```php
\Drupal::service('twig')->renderInline('{{ 1073741824|format_bytes }}');  // "1 GB"
```

## Not provided

No configure route (`configure: null`), no settings, no permissions, no Drush commands, no
config schema, no plugins, no dependencies beyond Drupal core. If you need anything beyond
formatting a number for display, this module is not involved.
