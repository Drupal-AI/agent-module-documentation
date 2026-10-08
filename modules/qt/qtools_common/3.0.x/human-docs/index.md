# Qtools Common — manual setup guide

**Qtools Common** (`qtools_common`) is a shared **developer utility** module for the
Qtools suite. It bundles helper services and low-level primitives — such as a
`TerminatedRedirectResponse` and other utilities — that the suite's other modules
(for example **Qtools Profiler**) build on top of.

On its own it has **no standalone site features**: you do not enable it to get a
visible tool or an admin page. Instead you install it because another Qtools module
depends on it, in which case Drupal will normally enable it for you automatically as
a dependency. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it provides shared developer
utilities and has nothing to configure.

## Where it lives in the admin menu

Qtools Common adds no admin page and no visible feature. It exists to support other
Qtools modules.
