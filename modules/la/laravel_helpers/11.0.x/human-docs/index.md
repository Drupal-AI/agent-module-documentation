# Laravel Helpers — manual setup guide

**Laravel Helpers** (`laravel_helpers`) is a **developer library** module. It
brings Laravel's convenient helper functions — for arrays, strings, and
collections — and Laravel's **validation** component into Drupal, so developers who
are comfortable with that API can use it to cut down on boilerplate. This version
tracks **Laravel 11.x**. It supports Drupal 10 and 11.

This is not a module for site builders: there is nothing to click and no visible
feature for end users. Its value is entirely in code. Once installed, your custom
module or form code can call the Laravel helpers, and you can attach Laravel‑style
validation rules to Drupal form elements. For example, the module lets you add a
`#laravel_validators` key to a form element (with rules like `required`,
`alpha_num:ascii`, `email`, `max:50`, or a custom rule class), or apply a set of
rules across a whole form with `#laravel_form_validators` — Laravel's validation
syntax, wired into Drupal's Form API.

Because it is a library integration, the way you "use" it is by writing code
against it. See the Laravel documentation for the full helper, string, collection,
and validation references that this module exposes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it is a developer library
with no settings form. You use it from your own code.

## How to use it

After enabling the module, use it from custom code:

- Call Laravel's array/string/collection helpers directly in your PHP.
- Attach Laravel validation to a Drupal form element with a `#laravel_validators`
  property (a rule string like `required|numeric|min:18|max:50`, an array of rules,
  or custom rule classes), or apply rules form‑wide with a
  `#laravel_form_validators` array on the form.

Refer to the official Laravel 11.x documentation for the full list of available
helpers, string functions, collection methods, and validation rules.
