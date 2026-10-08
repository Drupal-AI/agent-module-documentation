# Rut — manual setup guide

**Rut** (`rut`) validates the Chilean **RUT/RUN** — the national identification
number used by people and companies in Chile, made up of a number and a check digit
("DV"). The module makes sure a RUT that someone enters is actually valid (the check
digit matches), so you don't have to write that validation yourself.

It comes in two parts:

- The **base module** provides a reusable **form element** (`#type => 'rut_field'`)
  for custom forms, plus a `Drupal\rut\Rut` helper class with static methods for
  working with RUTs in code — splitting, computing the check digit, validating,
  formatting, and generating a random valid RUT. Validation runs server‑side, and you
  can optionally enable a jQuery client‑side check as well.
- An optional **submodule, RUT Field** (`rut_field`), turns that into a **storable
  field type** you can add to content types and other entities through the admin UI —
  with a widget, a display formatter, a uniqueness constraint, and integration with
  Feeds, Views, and the Devel generator.

So if you're a developer building a custom form, you'll use the base module's form
element; if you're a site builder who just wants a validated "RUT" field on a content
type, enable the RUT Field submodule.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and optionally enable the RUT Field submodule.

There is **no central configuration page** for this module. You either use the form
element in code or add a RUT field to an entity, described in "How to use it" below.

## How to use it

**As a site builder (RUT Field submodule):**

1. Enable the **RUT Field** submodule (see Installation).
2. Go to **Structure → Content types → *(your type)* → Manage fields → Add field**
   and choose the **RUT** field type.
3. Configure the field. A per‑field **Bypass validation** setting lets you allow
   saving values that don't pass RUT validation, if you ever need to; leave it off to
   enforce valid RUTs. You can also enforce **uniqueness** so the same RUT can't be
   stored twice.
4. Set the field's widget on **Manage form display** and its formatter on **Manage
   display**. The field also works as a Feeds import target and a Views filter.

**As a developer (form element):** add the element to a custom form —

```php
$form['rut_client'] = [
  '#type' => 'rut_field',
  '#title' => t('RUT'),
  '#required' => TRUE,
  '#validate_js' => TRUE, // optional: also validate in the browser
];
```

The element validates the RUT for you. In code you can also call the helper
directly, e.g. `\Drupal\rut\Rut::validateRut($value)`, `Rut::calculateDv($number)`,
`Rut::formatterRut($number, $dv)`, or `Rut::generateRut()` for a random valid RUT
(handy for tests and fixtures).
