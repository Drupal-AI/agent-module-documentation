# Multi-value form element — manual setup guide

**Multi-value form element** (`multivalue_form_element`) is a developer building block.
It provides a single reusable Form API render element, `#type => 'multivalue'`, that
wraps one or more child form elements and lets a user **add, remove, sort, and repeat**
them over several rows — the familiar "Add another item" pattern from core's multi‑value
field widgets, made available to *any* custom form.

If you have ever hand‑rolled AJAX "add more" callbacks to collect a variable‑length list
in a custom form — a list of job titles, a set of name + e‑mail pairs, a mapping table —
this module replaces that boilerplate with one maintained, tested element type. You
declare the child elements once, and the element repeats them per row, gives each row a
draggable weight for ordering, and (for unlimited cardinality) renders an AJAX **"Add
another item"** button automatically. On submit your form handler receives a clean,
consecutively‑keyed array with empty rows already dropped.

This is a pure Form API tool: there is **no configuration, no settings form, no
permissions, no admin UI, and no Drush**. You use it from custom module form code
(`buildForm()`), not from the site's admin pages. It targets **Drupal 10 or 11** and has
no dependencies.

This guide is written for a **human** — in this case a developer — working with the
module. If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead; the agent docs include the full property
reference and submitted‑value shape.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Nowhere — this module adds no admin pages, settings, or permissions. Its entire surface is
the `multivalue` render element, available to your custom forms once the module is enabled.

## How to use it

Enable the module, then use `#type => 'multivalue'` in a form's `buildForm()`. Put the
child element(s) **directly inside** the `multivalue` element — each row repeats all of
them.

A single repeatable text field with an unlimited number of rows:

```php
$form['job_titles'] = [
  '#type' => 'multivalue',
  '#title' => $this->t('Job titles'),
  'title' => [
    '#type' => 'textfield',
    '#title' => $this->t('Job title'),
    '#title_display' => 'invisible',
  ],
];
```

Several children per row, capped at three rows:

```php
$form['contacts'] = [
  '#type' => 'multivalue',
  '#title' => $this->t('Contacts'),
  '#cardinality' => 3,
  'name' => ['#type' => 'textfield', '#title' => $this->t('Name')],
  'mail' => ['#type' => 'email', '#title' => $this->t('E-mail')],
];
```

A few things worth knowing:

- **`#cardinality`** controls how many rows are allowed. A positive integer caps the rows;
  the default, unlimited (`-1`), renders the AJAX **"Add another item"** button. Relabel
  that button per element with **`#add_more_label`**.
- **`#default_value`** goes on the *wrapper*, keyed by numeric row index (delta) — never on
  the children. For a single‑child element you may pass a simple list of scalars as a
  shorthand.
- **`#required`** on the wrapper behaves like an entity field: it applies only to the first
  row. To keep a child required on every row, drive it with `#states` instead.
- On submit, the element tidies itself: it drops rows where every child is empty, sorts the
  rest by their drag weight, and re‑keys them `0..n`, so `$form_state` always gets a clean
  indexed array of rows keyed by child name.

The full property table, default‑value rules, required behaviour, and the exact submitted
array shape are documented in the sibling [`agent/`](../agent/start.md) reference.
