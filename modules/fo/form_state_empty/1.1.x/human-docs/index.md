# Form State Empty — manual setup guide

**Form State Empty** (`form_state_empty`) is a small extension to Drupal core's
conditional‑fields (`#states`) system. Core `#states` can show, hide, enable, or
disable a field based on another field's value — but it cannot **clear** a
field's value. Form State Empty fills exactly that gap: it adds an `empty` state
so a field can be emptied via JavaScript when a condition is met.

The most common reason to reach for it is a field whose visibility is being
toggled. When you hide a field with `#states`, its old value is still submitted,
which can leave stale data behind. Historically people worked around this by
*disabling* the element instead — but a disabled element submits nothing at all,
so you could never overwrite a previous submission. Emptying the field is the
clean answer: hide it *and* clear it, so what gets submitted matches what the
user actually sees.

This is a **developer‑facing** module — there is no settings page and no
admin UI. You use it entirely from code, by adding an `empty` key to a field's
`#states` definition, exactly the way you already write `visible`, `disabled`,
and the other core states. For example:

```php
$form['field_to_empty']['#states'] = [
  'empty' => [
    ':input[name="field_being_listened_to"]' => ['value' => '0'],
  ],
  'visible' => [
    ':input[name="field_being_listened_to"]' => ['value' => '1'],
  ],
];
```

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module simply makes the `empty` state
available to any form built in code. Once enabled it works with no further setup.

## How to use it

Enable the module, then in your form‑building or `hook_form_alter()` code add an
`empty` condition to the target field's `#states` array (as shown above),
alongside whatever `visible`/`invisible` conditions you already use. When the
condition matches, the field's value is cleared client‑side, so a hidden field no
longer submits stale data.
