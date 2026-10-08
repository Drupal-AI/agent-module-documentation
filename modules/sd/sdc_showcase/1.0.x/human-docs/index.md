# SDC Showcase — manual setup guide

**SDC Showcase** (`sdc_showcase`) auto-generates browsable preview pages for every
**Single Directory Component (SDC)** on your site — with no manual stories and no
hand-written fixtures. Enable it and every component gets a detail page showing a
schema reference and a matrix of rendered variations. Crucially, components render
with the site's own front-end theme, so the showcase matches production.

The module does the tedious work for you. It auto-discovers all SDC components
across your installed themes and modules, then generates realistic props from each
component's JSON Schema: strings become lorem ipsum, enums and booleans are swept
through every value, numbers respect their min/max bounds, and URIs become valid
URLs. For each component it builds a **variation matrix** — a baseline, enum/boolean
sweeps, edge cases (empty, long, zero, null), and hand-crafted combinations — so the
cases that actually break templates in production are covered without anyone writing
a story. Components can be composed into multi-component **collections** that mimic
full page layouts, and a single variation can be rendered in isolation for
screenshotting. A Drush command surface lists components and outputs every showcase
URL, which is ideal for piping into visual-regression tools like BackstopJS, Percy,
or Playwright.

The module is built with a sound security posture. The admin settings route is gated
by the **`administer sdc showcase`** permission. The public showcase routes default
to an "open" access mode that simply requires the **`access sdc showcase`**
permission — standard Drupal access control. If you want CI tools to reach it
anonymously, there are opt-in modes (HTTP Basic Auth or a query-string key, both
compared securely) and a "disabled" mode that blocks everything, which is a good
choice on production. In other words, nothing is exposed anonymously unless an
administrator explicitly opts in. Typical setup is: enable the module, grant
`access sdc showcase` to your QA/reviewer roles, and optionally pick an access mode
and a seed.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — access modes, the fake-data seed,
   variation layers, and the other settings.

## Where it lives in the admin menu

The settings form sits at **Configuration → Development → SDC Showcase**
(`/admin/config/development/sdc-showcase`), gated by `administer sdc showcase`. The
showcase itself is served at `/sdc-showcase`, with per-component pages, per-variation
pages, and collection pages, all protected by the module's access check.
