# Hello World — manual setup guide

**Hello World** (`helloworld`) is a minimal example module — the classic "Hello
World" demonstration for Drupal. It shows the basic anatomy of a module: a
route/controller that returns a greeting. Once enabled it adds a **Hello World**
link and page you can click straight to; there is nothing you need to configure.

Its value is educational. Read the code alongside this module to learn how a
route, a controller, and a returned render array fit together, or use it as a bare
scaffold to copy when starting a real module.

Because this is **example / reference code, not a production feature**, it is meant
for learning and local experimentation rather than for enabling on a live site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.

## How to use it

After you enable the module, a new **Hello World** menu link appears. Click it (or
visit the module's route) and you will see the greeting page. That is all there is
to it — the point is to demonstrate the smallest working route/controller in
Drupal.
