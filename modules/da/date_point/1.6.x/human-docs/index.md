# Date Point — manual setup guide

**Date Point** (`date_point`) provides a simple, robust field type for storing a
**point in time** — a datetime value. It's a developer/site‑builder building block:
it defines the field type, and you add it to a content type (or any fieldable
entity) like any other field. Its selling points are native database types for
datetime storage, PSR‑20 compatibility, support for the HTML5 `datetime-local`
input element, configurable precision (seconds, milliseconds, or microseconds),
and advanced Views integration.

The module works on **Drupal 11.3+** and has no external dependencies. It ships two
optional submodules — **Date Point Time Machine** (`date_point_time_machine`) and
**Clock Mock** (`dp_clock_mock`) — which let you mock or shift "now" for testing and
development. These are development aids: do **not** enable time‑mocking on a
production site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) enable the development submodules.

There is **no configuration page** — you use it by adding a Date Point field to a
bundle and configuring that field, as described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the bundle you want the field on — for example **Structure → Content types
   → *(type)* → Manage fields** — and click **Add field**.
3. Choose the **Date Point** field type, name the field, and save.
4. In the field settings, set the **precision** (seconds, milliseconds, or
   microseconds) to match what your data needs.
5. Configure the field's form widget (**Manage form display**) and display
   formatter (**Manage display**) as you would for any field. Views can then use
   the field for filtering, sorting, and display.
