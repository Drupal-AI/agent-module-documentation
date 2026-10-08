<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Automated Testing Kit (automated_testing_kit) — agent index

A library of ready-made **Cypress.io and Playwright** end-to-end tests plus reusable helper
commands that drive **Drush** from the test runner, for testing Drupal 11 sites. Developer/CI
tooling — install on local/QA/CI, not production.

- **Version:** 2.0.0 · **Core:** `>=11.0 <12` · **PHP:** `>=8.3` · **License:** GPL-2.0-or-later
- **Dependencies:** none (Drupal). Test side needs Node + Cypress and/or Playwright (installed on
  the host, not in a container).
- **No routes, no permissions, no config entities, no plugins.** The Drupal side is intentionally
  tiny: two theme-preprocess hooks and one Drush command.

## What the Drupal module provides
- `automated_testing_kit.module`
  - `hook_preprocess_html` — adds `node-type-*`, `node-nid-<id>`, `term-vid-*`, `term-tid-<id>`
    body classes so tests can read the current node/term ID from the page.
  - `hook_preprocess_image` — sets `data-media-id` on rendered images by resolving file → media.
  - `hook_help` — module help text only.
- **Drush command** `file:properties` (alias `fprop`) — see [agent/api/drush.md](api/drush.md).
- Note: `automated_testing_kit.services.yml` registers a Drush command service whose `class`
  string is stale; the working command is the attribute-based class in `src/Drush/Commands/`.

## What the test kit provides (JS, runs in Cypress/Playwright)
Two dozen helper commands and utilities, plus ~a dozen example spec suites mirrored for both
runners under `cypress/e2e/**` and `playwright/e2e/**`. See
[agent/api/commands.md](api/commands.md) for the command reference (user create/delete, login via
one-time-login link, config get/set, Drush execution local/SSH/Pantheon, email assertions,
ID lookups).

## Setup / scaffolding
`module_support/` holds the `atk_setup` script and example `cypress.config.js` /
`playwright.config.js`. `data/` holds JSON/YAML fixtures (`qaUsers.json`, `testUser.json`,
`testMessages.json`, prerequisites). See [agent/setup/install.md](setup/install.md).

## Submodule
- **automated_testing_kit_demo** — scaffolds a runnable demo test project when the ATK
  Demonstration Recipe is applied. Documented at
  [modules/automated_testing_kit_demo/2.0.x/agent/start.md](modules/automated_testing_kit_demo/2.0.x/agent/start.md).
