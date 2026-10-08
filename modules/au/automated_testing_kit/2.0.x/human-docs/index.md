# Automated Testing Kit — manual setup guide

**Automated Testing Kit** (`automated_testing_kit`) is a developer toolkit of
reusable end‑to‑end tests and helper functions for testing a Drupal site with
**Cypress** and **Playwright**. It packages the common flows a test suite keeps
needing — logging in, creating content, and so on — plus utilities to build on, so
teams don't have to reimplement the same E2E scaffolding from scratch each time.

It ships a demo submodule, **Automated Testing Kit Demo**
(`automated_testing_kit_demo`), and provides Drush commands to support the testing
workflow. This is a tool for **development and CI**, not for end users: use it to
bootstrap E2E coverage against a Drupal site.

Because it is a testing kit, its helpers and demo may create and log in test users
and content during runs. Keep the module and its demo submodule **out of
production**.

This guide is written for a **human** setting things up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and enable the demo submodule if you want it.
2. [How to use it](#how-to-use-it) — where the helpers and Drush commands fit.

## Where it lives in the admin menu

The kit has no admin menu item or settings form — it is a developer/testing tool
driven from your Cypress/Playwright test suites and from Drush on the command line.

## How to use it

1. Install and enable the module in a **development or CI** environment (see
   [Installation](installation/index.md)).
2. Build your Cypress and/or Playwright specs on top of the kit's reusable tests and
   helper functions, using them for common flows such as login and content creation.
3. Use the module's **Drush commands** to support the testing workflow.
4. Optionally enable the **Automated Testing Kit Demo** submodule to see worked
   examples you can copy.
5. Do not deploy the module or its demo to production — runs may create and log in
   test users and content.
