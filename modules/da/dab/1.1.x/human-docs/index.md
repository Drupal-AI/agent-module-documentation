# Drupal Atomic Builder — manual setup guide

**Drupal Atomic Builder** (`dab`) is a developer tool for building UI components
following the atomic / component design pattern on top of Drupal core's **Single
Directory Components (SDC)**. It lets front‑end developers visualize and create
components — coding them directly without having to build full content first — and
integrates with Drupal's admin interface so you can browse and preview your
component library in one place.

Its value is during development: it provides **in‑admin lists and previews of your
SDC components**, which makes assembling a design system from small, reusable
pieces much faster to iterate on. The maintainers **strongly advise against using
it in production environments** — it's a build‑time aid, not a runtime feature,
which is why it is installed as a development dependency.

DAB depends on core's **SDC** module and also uses the CommonMark Markdown library
(pulled in by Composer). It provides three permissions — `administer dab
configuration`, `administer dab components`, and `access dab components` — and you
should restrict the *administer* permissions to developers. It supports Drupal
10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install as a dev dependency with
   Composer and enable it.

## How to use it

Once enabled, DAB adds an in‑admin component area (gated by its permissions) where
you can browse the SDC components defined in your themes and modules and preview
them without wiring up content. Give developers the `access dab components`
permission to view the library and the `administer dab components` /
`administer dab configuration` permissions to manage it; keep those administer
permissions off untrusted roles. Because it's a development aid, enable it in your
local and development environments rather than on production.
