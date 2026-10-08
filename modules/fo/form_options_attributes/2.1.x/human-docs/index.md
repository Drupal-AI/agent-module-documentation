# Form Options Attributes — manual setup guide

**Form Options Attributes** (`form_options_attributes`) is a small developer
helper for Drupal's Form API. Core lets you put `#attributes` on a form element as
a whole, but it gives you no way to add attributes to a *single* `<option>`
inside a `<select>`, or to one radio button or checkbox within a group. This
module fills that gap.

Once enabled, you can add a new `#options_attributes` property to any `select`,
`radios`, or `checkboxes` element. Its keys mirror the element's `#options` keys,
and each value is an attributes array formatted exactly like `#attributes`. That
lets you attach classes, `data-*` attributes, `title` tooltips, `aria-*`
attributes, and the like to individual choices — perfect for JavaScript hooks,
styling, accessibility, or client-side option filtering. For radios and
checkboxes there are two extra properties, `#options_wrapper_attributes` and
`#options_label_attributes`, which target each option's wrapper `<div>` and
`<label>`.

This is a pure API module: there is **no admin UI, no configuration, no
permissions, no Drush commands, and no dependencies beyond core**. You only need
it if another module depends on it, or if you are writing a custom form (or a
`hook_form_alter`) that needs to decorate individual options. Enabling the module
is the entire setup.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact property
structure and worked code examples — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page. The module only adds capabilities to the
Form API, which you use from code.

## How to use it

Enable the module, then add `#options_attributes` to a form element in your code
or in a `hook_form_alter()`. A quick example:

```php
$form['color'] = [
  '#type' => 'select',
  '#title' => t('Color'),
  '#options' => ['r' => t('Red'), 'g' => t('Green'), 'b' => t('Blue')],
  '#options_attributes' => [
    'r' => ['class' => ['is-recommended'], 'data-hex' => 'ff0000'],
    'g' => ['data-hex' => '00ff00'],
    'b' => ['data-hex' => '0000ff'],
  ],
];
```

A few rules to keep in mind:

- The keys of `#options_attributes` must match the element's `#options` keys.
- It works on `#type` `select`, `radios`, and `checkboxes`.
- `#options_wrapper_attributes` and `#options_label_attributes` apply to
  **radios and checkboxes only** — a `<select>` has no per-option wrapper or
  label.
- For a `<select>` with `<optgroup>`s, the keys nest one level deeper:
  `#options_attributes[group_label][option_key]`.
