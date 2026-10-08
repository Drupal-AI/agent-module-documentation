# Entity Reference Autocomplete Add More — manual setup guide

**Entity Reference Autocomplete Add More** (`entity_reference_autocomplete_add_more`)
is a **developer's tool**. It provides a new **Form API element** —
`entity_reference_autocomplete_add_more` — that lets you add an entity‑reference
autocomplete input, with **"Add more item" and "Remove" buttons**, to **any
custom form**, so an end user can reference several entities using individual
input boxes without a page reload.

Core's `entity_reference_autocomplete` widget requires an actual field storage
attached to an entity, so it only works on entity forms. This module is a
lightweight alternative that works on **plain custom forms** where there is no
field storage — for example a settings form or a custom action form that needs to
collect a list of entity references. It is explicitly intended for **developers**;
enabling it adds no visible feature on its own.

Because it is a form element, there is **no admin UI and no configuration page**.
You use it by referencing the element type in your own form‑building code. It
works on Drupal 10 and 11 with no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is used in code, described
in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. It is consumed entirely from your own custom form
code.

## How to use it

After enabling the module, the new `entity_reference_autocomplete_add_more`
element type is available in the Form API. Use it in a form array like this:

```php
$form['field_name'] = [
  '#type' => 'entity_reference_autocomplete_add_more',
  '#target_type' => 'entity_type',
  '#title' => $this->t('Field label'),
  '#selection_settings' => [
    'target_bundles' => ['bundle_name'],
    'match_limit' => 15,
  ],
  '#default_value' => [
    0 => ['target_id' => 123],
    1 => ['target_id' => 234],
  ],
];
```

Each entry gets its own autocomplete input, and the **Add more item** / **Remove**
buttons let the user grow or shrink the list without reloading the page.
