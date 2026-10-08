# Slim Select — manual setup guide

**Slim Select** (`slim_select`) upgrades Drupal's plain `<select>` dropdowns
into the nicer, searchable selects provided by the
[Slim Select](https://slimselectjs.com) JavaScript library. Instead of a native
dropdown where you scroll through a long list, you get a select with a search
box you can type into, tidier styling, and — for multi-select fields — clickable
option groups that select all their children at once.

The problem it solves is usability on forms with long option lists: a searchable,
filter-as-you-type select is far easier to work with than a native one. This is
a **developer-oriented** module — it exposes a form element property rather than
a point-and-click settings screen. You (or a module you write) opt a select into
the enhanced behaviour by adding a `#slim_select` property to the form element in
code. The stored values are ordinary select values, so it changes only the input
experience and has no access-control role.

It works on Drupal 10.2 and 11, is covered by Drupal's security advisory policy,
and requires the external Slim Select JavaScript library to be present (see
Installation). It provides its own permissions.

This guide is written for a **human** installing and wiring up the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, provide the Slim
   Select library, and enable it.

## How to use it

Slim Select is applied in **code**, not through an admin form. To turn a normal
select into a Slim Select, add a `#slim_select` property to the form element:

```php
$form['my_slim_select'] = [
  '#type' => 'select',
  '#title' => 'A new select',
  '#options' => [
    'option1' => 'Red',
    'option2' => 'Green',
    'option3' => 'Blue',
  ],
  '#slim_select' => [
    'showSearch' => TRUE,
  ],
];
```

The `#slim_select` array holds the library's options. Two are currently
supported:

- **`showSearch`** — whether to show a search bar for filtering the options.
- **`selectByGroup`** — for multi-select elements with `optgroup` groups, makes
  each group heading clickable so clicking it selects all the options under it.
