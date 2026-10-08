# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **User** module (`user`) — part of any standard install.
- **DDEV** — required. Smoke's setup and test execution rely on DDEV, and Node.js
  must be available inside the container (the setup command checks this). Support
  for other local environments is planned but not yet available; if you are not
  using DDEV, this module won't work for you yet.

The Chromium browser and Playwright/npm dependencies are downloaded for you by
the setup command — you don't install them manually.

## Install with Composer

From the project root:

```bash
composer require drupal/smoke -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Because Smoke requires DDEV, run these through `ddev` from your
> host — `ddev composer require drupal/smoke -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smoke -y
```

## Run the one‑time setup

This step downloads the browser and generates your test configuration. Run it
once (it takes about 2–5 minutes the first time):

```bash
ddev drush smoke:setup
```

## Verify it worked

Run the tests:

```bash
ddev drush smoke --run
```

You should see a progress bar and pass/fail results in the terminal. You can
also open `/admin/reports/smoke` to see results in the admin dashboard.

> **Security note:** Smoke drives an authenticated browser against your site and
> may need test credentials for login/auth tests. Keep those in secrets, use the
> dedicated `smoke_bot` account it creates, and keep this tooling on
> non‑production / CI environments gated to developers — don't expose test
> tooling on production.
