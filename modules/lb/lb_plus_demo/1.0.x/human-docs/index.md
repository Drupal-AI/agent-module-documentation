# Layout Builder + Demo — manual setup guide

**Layout Builder + Demo** (`lb_plus_demo`) is a dependency-only wrapper module.
Its sole purpose is to install **Layout Builder +** (`lb_plus`) together with
**Field Sample Value** (`field_sample_value`) in one step, so you can spin up a
throwaway environment to try Layout Builder + — for example on Simplytest.me.

The module ships no code of its own: no PHP, routes, permissions, services, or
configuration. Its `.info.yml` simply declares the two dependencies, so enabling
it enables that whole stack at once. Field Sample Value supplies placeholder field
content so demo layouts have something to render. Because it is a meta-package,
there is nothing to configure here — all behaviour comes from the modules it
pulls in.

This is **not intended for production**; it exists to make "try Layout Builder +"
a single click. Note that it declares Drupal 10 compatibility
(`core_version_requirement: ^10`), while Layout Builder + itself is Drupal 11
only — so in practice you use this wrapper on a demo build where the dependency
resolves.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   wrapper.

This module has **no configuration page** and no settings — everything it does is
handled by the modules it depends on.

## Where it lives in the admin menu

Nowhere — it adds no admin pages (`configure` is null). After enabling it, you
work entirely with **Layout Builder +** (see that module's documentation), using
the sample values that Field Sample Value provides to populate demo layouts.
