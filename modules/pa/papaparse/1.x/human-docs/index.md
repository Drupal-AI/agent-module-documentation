# PapaParse — manual setup guide

**PapaParse** (`papaparse`) packages the **PapaParse** JavaScript CSV-parsing
library as a Drupal library, so other modules can depend on it and parse CSV files
in the browser. PapaParse itself is a fast, in-browser CSV parser; this module's
only job is to make it available to Drupal's asset system.

It is a **library provider** with no features, settings, routes, or permissions of
its own. You don't enable it for something it does directly — you enable it because
another module (or your own custom code) declares a dependency on the PapaParse
library and needs it present. What uses the library defines the behavior; this
module just serves it. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — this module has no settings. Enable it and
let the modules that depend on the PapaParse library use it.

## How to use it

PapaParse does nothing visible on its own. In practice you either:

- install and enable it because another contrib module lists it as a dependency;
  or
- attach its Drupal library (`papaparse/papaparse`) from your own module's or
  theme's asset definitions when you need client-side CSV parsing, then call the
  PapaParse API from your JavaScript.
