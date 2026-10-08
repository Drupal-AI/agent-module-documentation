# BE Param Verify — manual setup guide

**BE Param Verify** (`param_verify`) is a **developer‑only** module. It does
nothing on its own and has no user‑facing features: its whole job is to provide
the "glue" between Drupal and the `adaddinsane/param_verify` PHP package
(from Packagist), supplying a service that hands your code the library's parameter
verifier. If you are not writing custom PHP, there is nothing here for you.

The underlying library does **type‑checking of a set of array values** — most
often the parameters passed into a function or method, or a payload coming from an
external source such as an API call. You describe the values you expect with a
declarative ruleset (which keys are **required**, what **type** each must be, and,
where relevant, a **range** or allowed list), and the verifier returns a list of
errors — an empty list means everything checked out. This is a useful guardrail
for validating untrusted or externally supplied input in your own code before you
act on it, though the module itself exposes no endpoints and makes no security
decisions on its own.

The supported types are broad and cover most of PHP: `any`, `null`, `class`,
`object`, `array` (with nested sub‑definitions), `int`, `bool`, `int_bool`,
`float`, `string`, `string_list` (an enum‑style list separated by `|`), `regex`,
`callable`, `resource`, `url`, `email`, and (on PHP 8.1+) `enum`. Both `int`,
`float`, and `string` support length/range restrictions.

This guide is written for a **human** developer setting the module up. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which fetches
   the underlying library) and enable the module.

There is **no configuration page** for this module — it has no settings form and
no admin UI. You use it entirely from your own PHP code, sketched in "How to use
it" below.

## How to use it

Because this module is glue for a code library, "using it" means calling it from
custom PHP once the module is enabled. In broad strokes:

1. Build a **settings array** describing the values you expect. Each entry is
   keyed by the property/parameter name and declares at least a `type`, plus
   optionally `required`, a `data` string (for example the pattern for a `regex`
   type or the fully qualified class name for a `class`/`enum` type), and a
   `range`. For example:

   ```php
   [
     'name' => [
       'required' => true,
       'type'     => 'string',
       'data'     => '',
       'range'    => [],
     ],
   ]
   ```

2. Obtain the verifier through the service this module provides and run your set of
   values against that ruleset.
3. Inspect the returned **list of errors** — an empty list means every value was
   present and of the right type; otherwise the list tells you what failed.

For the full ruleset structure and the exact behavior of each type, see the
`adaddinsane/param_verify` package README.
