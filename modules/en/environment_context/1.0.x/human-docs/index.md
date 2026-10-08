# Environment Context — manual setup guide

**Environment Context** (`environment_context`) gives Drupal a reliable, built‑in
way to know which runtime environment it is currently serving — development,
staging, production, or any environment you define — and to make blocks and other
context‑aware features behave differently depending on the answer. It detects the
environment from `settings.php`, from an environment variable
(`DRUPAL_ENVIRONMENT`), or from pluggable event‑based detection that other modules
can hook into.

Under the hood it registers four small pieces that plug into Drupal's own systems:
a **context provider** that exposes the current environment, a **condition plugin**
you can use in block visibility and Layout Builder, a **typed‑data plugin** for
strong typing, and a **cache context** (`environment`) so rendered output can vary
per environment. It has no external dependencies and works on Drupal 10 and 11.

This is a developer‑ and site‑builder‑oriented module. It has **no admin settings
page of its own** — you use it through the block visibility UI and through code.
For example, a site builder can add a "Current environment" condition to a block so
a debug banner appears only on staging, and a developer can read the active
environment from the `environment_context.context.environment` service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it works behind the scenes
and through developer APIs, described in "How to use it" below.

## Where it lives in the admin menu

Environment Context adds no admin page of its own. Where you meet it is in the
**block visibility** settings of any block (**Structure → Block layout**, then a
block's configuration) and in **Layout Builder**, where a **Current environment**
condition becomes available.

## How to use it

First, make sure the environment is actually detected on each environment — the
whole point is that the value differs between them. Set it in `settings.php` or,
better, via the `DRUPAL_ENVIRONMENT` environment variable so each server reports
itself correctly without shared configuration.

Then use it in either of two ways:

- **In the UI (no code).** Edit a block's visibility settings and add the
  **Current environment** condition, then tick the environment(s) in which the
  block should show. This is how you make, say, a "You are on STAGING" banner
  appear only outside production.
- **In code.** Read the active environment from the context service and branch on
  it:

  ```php
  $env = \Drupal::service('environment_context.context.environment')
    ->getCurrentEnvironment();
  if ($env === 'production') {
    // Do something only on production.
  }
  ```

  Other modules can register environments or override detection by listening for
  the module's events, for example:

  ```php
  $event->addEnvironment('production', ['label' => 'Production']);
  ```

It pairs naturally with **Config Split** (to manage configuration per environment)
and **Environment Indicator** (to decorate the admin UI per environment).
