# Drush API Audit — manual setup guide

**Drush API Audit** (`drush_api_audit`) is a developer and operations tool that
adds Drush commands for auditing the API routes of a headless or decoupled Drupal
site. It helps you find routes that are open to anyone, routes that are missing
access requirements, and other potential access-control misconfigurations —
exactly the kind of thing that is easy to overlook when a site exposes a lot of
endpoints.

The whole module is a command-line tool. It reads your site's route definitions
and reports on them; it does not add any web pages, permissions, or content of
its own. Because it runs through Drush, only people who already have shell/Drush
access to the site can use it, which makes it a safe auditing aid for trusted
operators.

It provides two commands: one to list all your API routes, and one to audit those
routes' access permissions. It requires Drush 12 or 13 and supports Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it is a Drush command
provider, described under "How to use it" below.

## How to use it

After enabling the module, two new Drush commands are available. Run them from
the Drupal root, and add `--help` to either one to see its full options:

- **List all API routes (endpoints):**

  ```bash
  drush api:route --help
  ```

- **Audit API route access permissions** — surface routes with open access or
  missing access requirements:

  ```bash
  drush api:audit:permission --help
  ```

Run the audit command regularly (for example as part of a pre-release checklist)
to catch endpoints that were accidentally left open.
