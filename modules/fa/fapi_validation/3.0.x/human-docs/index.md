# FAPI Validation — manual setup guide

**FAPI Validation** (`fapi_validation`) adds a declarative validation layer to
Drupal's Form API. Core's Form API ships no built‑in validators or input filters —
every check has to be written by hand in a validation callback. This module lets you
instead attach reusable validators and filters directly to a form element by name, so
common needs (email, numeric, length, regular expression, and more) take a line
rather than a callback.

It is a developer tool. You declare validators and filters on a form element with
`#validators` and `#filters` keys; the module runs them and sets form errors with
sensible default messages you can override per rule. Bundled validators include
`numeric`, `alpha`, `length`, `chars`, `email`, `url`, `ipv4`, `alpha_numeric`,
`alpha_dash`, `digit`, `decimal`, `regexp`, `match_field`, and `range`; bundled
filters include `trim`, `numeric`, `uppercase`, `lowercase`, `strip_tags`, and
`html_entities`. The whole system is extensible — you can register your own validators
and filters through hooks and reuse them across the site.

**A security note worth keeping in mind:** FAPI Validation improves input
*validation* ergonomics, which is defensively useful — but validation is **not
sanitization**. Always escape output and use safe APIs regardless of what a form
validates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** — the validators and filters are used from code,
not the admin UI.

## Where it lives in the admin menu

The module adds no settings page. It is a developer tool used from your form‑building
code. It does define its own permission and config schema, but there is no admin form
to visit.

## How to use it

Add `#validators` and/or `#filters` to a form element:

```php
$form['myfield'] = [
  '#type' => 'textfield',
  '#title' => 'My Field',
  '#required' => TRUE,
  '#validators' => [
    'email',
    'length[10, 50]',
    ['rule' => 'alpha_numeric', 'error' => 'Please use only alphanumeric characters at %field.'],
    ['rule' => 'match_field[otherfield]', 'error callback' => 'mymodule_validation_error_msg'],
  ],
  '#filters' => ['trim', 'uppercase'],
];
```

Each validator can be named as a plain string, or given as an array with a custom
`error` message or `error callback`. To add your own reusable rules, implement
`hook_fapi_validation_validators` (for validators) or `hook_fapi_validation_filters`
(for filters). The module ships an **example submodule** demonstrating the API, which
you can enable to study.

> **Note:** in the Drupal 7 version validators were called `#rules`; from Drupal 8
> onward they are `#validators`, renamed to avoid confusion with the Rules module.
