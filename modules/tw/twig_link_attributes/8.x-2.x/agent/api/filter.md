<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `link_attributes` Twig filter

Provided by `Drupal\twig_link_attributes\Twig\Extension\TwigLinkAttributes` (extends `\Twig_Extension`).

```twig
{{ item.url|link_attributes({'class': ['button', 'button--primary'], 'target': '_blank', 'rel': 'noopener'}) }}
```

- First argument: a `Drupal\Core\Url` object (e.g. `item.url` from a link field).
- Second argument: an associative array of attributes.
- Behavior: reads the Url's existing `attributes` option; if present, `array_merge_recursive($values, $current)`; otherwise uses `$values`; then `setOption('attributes', ...)` and returns the Url.

Note: because merging is recursive, an attribute already set on the Url is combined with (not replaced by) the provided value. There is no separate permission or configuration.
