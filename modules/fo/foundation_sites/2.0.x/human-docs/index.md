# ZURB Foundation Sites Library — manual setup guide

**ZURB Foundation Sites Library** (`foundation_sites`) registers the
[ZURB Foundation Sites](https://get.foundation/sites/) front‑end framework — its
CSS, JavaScript, grid and components — as a managed **Drupal library**, so themes
and modules can attach Foundation the proper Drupal way rather than hard‑coding
`<link>` and `<script>` tags. It doesn't change how your site looks on its own; it's
the plumbing that other Foundation‑based modules and themes depend on.

Reach for this module if any of these are true: you're using another module or theme
that declares it as a dependency; you're building or maintaining a Foundation‑based
theme or module; or you simply want Foundation's assets available in your project so
you can attach them where you need them.

The module exposes several **library variants** so you load only what you need —
`complete`, `essential`, `core`, and a `cdn` variant — and each Foundation plugin
(accordion, slider, and so on) is available as its own sub‑library that depends on
`core`. You attach them from PHP (`$build['#attached']['library'][] =
'foundation_sites/core';`) or Twig (`{{ attach_library('foundation_sites/core') }}`),
and you can override, extend, or trim the library contents using Drupal's standard
libraries‑override mechanism.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the (slightly special) Composer setup that
   also pulls in the Foundation front‑end assets, plus the manual‑download
   alternative.
2. [Configuration](configuration/index.md) — the module's settings and the
   permission it provides.

## Where it lives in the admin menu

The module registers a settings form (route `foundation_sites.admin`) under
**Administration → Configuration**, and it provides its own permission controlling
who may administer it. See [Configuration](configuration/index.md) for details.

## How to use it (attaching the library)

Foundation isn't switched on globally — you attach the variant or plugin you want:

**In PHP:**

```php
$build['#attached']['library'][] = 'foundation_sites/core';
$build['#attached']['library'][] = 'foundation_sites/accordion';
```

**In Twig:**

```twig
{{ attach_library('foundation_sites/core') }}
{{ attach_library('foundation_sites/accordion') }}
```

`foundation_sites/core` is a dependency of every plugin, so you don't have to attach
it by hand when you attach a plugin. For the full list of available libraries, look
at `foundation_sites.library.yml` in the module.
