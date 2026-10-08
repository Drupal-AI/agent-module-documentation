<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming & markup

The formatter builds one render array per field delta with `#theme =>
'hierarchical_term_formatter'`, then core themes it.

## Theme hook

Declared in `hierarchical_term_formatter_theme()`:

```php
'hierarchical_term_formatter' => [
  'variables' => [
    'terms' => [],          // ordered list of term labels/links (or grouped arrays)
    'wrapper' => '',        // the 'wrap' setting: none|span|div|ul|ol
    'separator' => ' » ',   // the 'separator' setting
    'link' => FALSE,        // the 'link' setting
  ],
  'file' => 'hierarchical_term_formatter.theme.inc',
];
```

## Preprocess — `template_preprocess_hierarchical_term_formatter()`

In `hierarchical_term_formatter.theme.inc`. It:
- turns each term into a label or a rendered `Link` (when `link` is TRUE);
- for `grouping`, a delta may itself be an array of sibling terms — these are joined with
  `<span class="child-separator">, </span>`;
- unless `wrapper === 'none'`, wraps each term in an `html_tag` element (`<li>` for `ul`/`ol`,
  otherwise the chosen tag `span`/`div`) with classes `taxonomy-term` and `count N`.

## Template — `templates/hierarchical-term-formatter.html.twig`

- For `wrap` = `ul`/`ol` it prints an enclosing `<ul class="terms-hierarchy">` / `<ol …>`.
- It loops `terms`, printing each, and between items prints
  `<span class="separator">{{ separator }}</span>` (not after the last).

Available Twig variables: `terms`, `wrapper`, `separator` (see the docblock in the template).

## Overriding

- Override the template by copying `hierarchical-term-formatter.html.twig` into your theme.
- Add a preprocess (`hook_preprocess_hierarchical_term_formatter()`) to alter `terms`,
  `separator`, or `wrapper` before rendering.
- CSS hooks available out of the box: `.terms-hierarchy`, `.separator`, `.child-separator`,
  `.taxonomy-term`, `.count-N`.
