# Datalist — manual setup guide

**Datalist** (`datalist`) adds a Drupal render element for HTML5's native
`<datalist>` — a text input that shows the browser's own suggestion list as the
user types, while still letting them type a value that isn't in the list. It sits
neatly between a plain text field and a select box: use it whenever the answer is
"usually one of these, but sometimes something else."

Because it uses the browser's built‑in element, it needs **no JavaScript** and
inherits the browser's own accessibility handling — a real advantage over scripted
autocomplete widgets like Select2, which are harder to make fully accessible. The
trade‑off is that the suggestion dropdown is not consistently styleable and the
exact filtering behaviour differs slightly between browsers, so it's the right
choice where "works everywhere, looks native" matters more than pixel‑perfect
control. It also ships a small extra: an optional "clear" button and basic
theming.

Two things are worth knowing. First, a `<datalist>` is a *suggestion*, not a
constraint — the field still accepts any value the user types, so if the value
*must* be one of your options, use a select instead or add your own validation.
Second, this is a developer‑oriented module: it provides a form/render element
(and a form widget, with a field type in development) for use in custom code and
in Webform, rather than a point‑and‑click feature. It depends only on Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form,
routes, or permissions. You use it by adding the element to a form.

## How to use it

In custom form code, set an element's `#type` to `datalist` and pass an
associative array of options (value → label). The value is submitted and the label
is shown to the user:

```php
$form['list_of_things'] = [
  '#type' => 'datalist',
  '#title' => 'Title',
  '#options' => [
    1 => 'Label 1',
    2 => 'Label 2',
  ],
  '#required' => TRUE,
];
```

A `use_keys` setting lets you tweak whether keys or labels are used. A **Webform**
element is also provided, so you can offer the same native suggestions on a
webform, and a form widget is included for field use.
