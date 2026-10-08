# Emulsify Twig Extensions — manual setup guide

**Emulsify Twig Extensions** (`emulsify_twig`) is a small developer/theming module
that adds two helper functions to Drupal's Twig templating engine: **`bem()`** for
building BEM (Block-Element-Modifier) CSS class names, and **`add_attributes()`**
for merging extra HTML attributes into a template. It exists so that components
written for the **Emulsify** design system render identically in Drupal and in a
component library like Pattern Lab or Storybook — the same Twig file works in both
places.

This is a module for theme developers, not something with an admin interface.
Enabling it makes the two functions available in every Twig template; there is
**nothing to configure**. It has no settings form, no permissions, no routes, and
no dependencies beyond Drupal core (10 or 11). Typically you install it because an
Emulsify-based theme or starter kit lists it as a dependency.

One thing to note about the project's direction: per its README, this **5.0.x
branch is the last supported release** (Drupal 10/11 only), and development
continues in the separate **Emulsify Tools** module. If you are starting fresh,
check whether Emulsify Tools is the better fit; if you are maintaining an existing
Emulsify theme, this module remains the drop-in dependency.

This guide is written for a **human** using the module. If you want terse,
token-cheap references for an AI coding agent — the exact function signatures,
output tables, and service names — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere. This module has no admin page, no settings, and no permission. Its entire
surface is the two Twig functions you call from template files.

## How to use it

Both functions are called from within a Twig template (they cannot be called from
PHP). They return a Drupal `Attribute` object, so you print them where you would
normally print `{{ attributes }}`.

### `bem()` — build BEM class names

```twig
bem(base_class, modifiers = [], blockname = '', extra = [])
```

Examples:

- `<h1 {{ bem('title') }}>` renders `class="title"`.
- `bem('title', ['small', 'red'])` renders `title title--small title--red`.
- `bem('title', [], 'card')` renders `card__title` (namespaced under the `card`
  block).
- `bem('title', ['small'], 'card')` renders `card__title card__title--small`.
- `bem('title', '', '', ['js-click'])` appends non-BEM classes verbatim (handy for
  JavaScript hooks or utility classes).

A useful detail: when you use `bem()` in place of `{{ attributes }}`, it folds in
the classes Drupal already put on the element (plus its `id`, `data-*`, and
contextual-link markers) and then **removes** them from the Twig context, so they
do not leak into any `{% include %}`d child templates. That is why you replace
`{{ attributes }}` with `{{ bem(...) }}` rather than printing both.

### `add_attributes()` — merge extra attributes

```twig
<div {{ add_attributes({class: ['foo'], 'data-x': 'y'}) }}></div>
```

This merges an arbitrary map of attributes (classes, `data-*`, `aria-*`, `role`,
and so on) with the template's own `attributes`. Existing values for the same key
are merged, not replaced.

### Composing the two

The two functions work together — build the class list with `bem()` and hand it to
`add_attributes()`:

```twig
{{ add_attributes({class: bem('foo', ['bar'], 'block')}) }}
```

Use `bem()` when you want an element's classes generated from a BEM scheme (and are
replacing `{{ attributes }}`); use `add_attributes()` when you want to add
arbitrary attributes on top of whatever Drupal already provided.
