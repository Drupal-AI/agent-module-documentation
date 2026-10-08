# Smoke — manual setup guide

**Smoke** (`smoke`) adds automated smoke testing to a Drupal site with very
little setup. After you install it and run one setup command, `ddev drush smoke`
drives a real browser (Chromium via Playwright) against your site to confirm the
basics still work: the homepage loads, login works, forms submit, and — where
those features are present — commerce and search behave. Tests run with a live
progress bar in your terminal, and results also appear on an admin dashboard at
`/admin/reports/smoke`. It's aimed at teams who want a quick way to confirm that
an update or deployment didn't break the site.

Smoke is a **developer / QA tool**, not a site‑visitor feature. It auto‑detects
what your site has installed (Webform, Commerce, Search API, and so on) and
generates a matching test configuration during setup. It depends on core's
**User** module and provides its own permission, and it lives in the
*Development* package.

Two things are worth knowing before you start. First, **DDEV is currently
required** — Smoke's setup and test execution rely on DDEV, and support for other
local environments (Lando, bare metal, etc.) is planned but not yet available.
Second, because Smoke drives an authenticated browser, its login/auth tests may
need **test credentials**: keep those in secrets, use the dedicated `smoke_bot`
test account it creates rather than real logins, and keep this tooling on
**non‑production / CI environments** gated to developers — you don't want test
tooling exposed on a production site.

This guide is written for a **human** setting Smoke up and running it. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and run the one‑time setup.

## How to use it

Smoke is driven from the command line (all commands run through DDEV):

- **One‑time setup** — `ddev drush smoke:setup` downloads Chromium (~180 MiB,
  cached per user and shared across projects), installs the npm/Playwright
  dependencies and required system libraries, scans your site to detect
  installed modules, creates the `smoke_bot` test user and role, and installs a
  DDEV post‑start hook so the config regenerates on `ddev start`. It takes about
  2–5 minutes the first time. Re‑run it after adding new modules (Webform,
  Commerce, etc.) — it skips the browser download and just regenerates the test
  config.
- **Run all tests** — `ddev drush smoke --run` shows a progress bar and results
  in the terminal.
- **Run one suite** — e.g. `ddev drush smoke:suite auth` or
  `ddev drush smoke:suite webform`.
- **Fast sanity check** — `ddev drush smoke --run --quick`.
- **Test a remote target** — `ddev drush smoke --run --target=https://example.pantheonsite.io`.
- **View results in the browser** — open `/admin/reports/smoke`.

VS Code / Cursor users can run `ddev smoke-ide-setup` once on the host (needs
Node.js 18+) and `ddev drush smoke:init` so the IDE discovers the tests. If a
browser launch ever fails after a `ddev restart`, Smoke auto‑reinstalls its
dependencies and retries.
