# Element Multiple — manual setup guide

**Element Multiple** (`element_multiple`) is a developer helper module. It adds a
reusable Form API element — a new `#type` called `element_multiple` — for
collecting several values of the same kind in a form, complete with the familiar
"Add another" behaviour: rows you can add, remove, and reorder.

Drupal already has this multi-value pattern, but it is tied to the **field**
system. The moment you need a repeatable list of inputs on a plain form — a
settings form, a configuration entity form, or a custom form — you normally have
to build the whole thing by hand: track the row count in form state, wire up the
AJAX rebuild so it does not wipe what the user typed, give the wrapper a stable
id, and make it all survive validation errors. That is fiddly, and most projects
get it slightly wrong. This module packages the pattern so you can declare it
instead of rebuilding it.

There is **nothing to configure** and there are no dependencies — it is pure
infrastructure that works the moment you enable it. You use it entirely from
your own module's PHP code, so this module is aimed at developers rather than
site builders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has **no configuration page** — it exposes no settings form and adds
nothing to the admin menu. Everything happens in code, described in "How to use
it" below.

## How to use it

Once the module is enabled, you can use `element_multiple` as the `#type` of any
form element. Provide a `#header` (the column labels) and an `#element` (the
sub‑fields that make up one row); Drupal renders it as a table of rows with an
"Add another" button:

```php
$form['multiple'] = [
  '#type' => 'element_multiple',
  '#title' => 'Multiple values',
  '#header' => [
    ['data' => $this->t('First name'), 'width' => '50%'],
    ['data' => $this->t('Second name'), 'width' => '50%'],
  ],
  '#element' => [
    'first_name' => [
      '#type' => 'textfield',
      '#title' => $this->t('First name'),
    ],
    'last_name' => [
      '#type' => 'textfield',
      '#title' => $this->t('Last name'),
    ],
  ],
  '#default_value' => $config->get('multiple'),
];
```

The element hands your submit handler back a plain array of the entered rows.
What you do with that array is yours to decide: whether to filter empty rows,
whether the order matters, and whether to remove duplicates all belong in your
own submit handler — the element does not assume any of it. One thing worth
testing is adding a row **after a failed validation**, to confirm nothing the
user typed is lost.
