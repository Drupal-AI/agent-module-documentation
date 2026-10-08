# Domain Twig — manual setup guide

**Domain Twig** (`domain_twig`) adds a single Twig function, `domain()`, that
returns the currently active domain on a [Domain](https://www.drupal.org/project/domain)
(Domain Access) multi‑domain site. With it, your theme templates can read the
active domain — its id, hostname, or label — and render domain‑specific markup
directly, without writing a preprocess hook to pass that value into the template.

A typical use looks like this:

```twig
{% set domain_id = domain().id %}
{% if domain_id == 'example' %}
  Cool stuff, huh!
{% endif %}
```

This is a small theming and developer utility. It reads domain context only — it
has no content model, no routes, and no access‑control role. It depends on the
Domain module and works on Drupal 8, 10, and 11. Note that it is *not* covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Domain.

There is **no configuration page** for this module — it exposes only the Twig
function. Everything you do with it happens inside your Twig templates.

## How to use it

Once the module is enabled, the `domain()` function is available in any Twig
template. Call it and read the property you need (for example `domain().id`,
`domain().hostname`, or `domain().label`), then branch your markup on the result.
This keeps domain‑aware presentation logic in the template where the rest of your
theming lives, instead of scattering it across preprocess functions.
