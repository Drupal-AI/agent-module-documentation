# Domino — manual setup guide

**Domino** (`domino`) is an opinionated bundle of configuration and helper
features that gives a new Drupal project a consistent, security‑minded baseline
from day one. Rather than a single feature, it is a collection of conveniences
aimed at developers who care about ease of development, automated testing, and
sensible defaults across three environment types: production, staging, and
development.

Its headline features include: automatically generated **test users** (by
default, one per role, so you can quickly test each role's permissions);
**displaying outgoing emails as Drupal messages** (invaluable for QA and
automated tests, so you can check registration and password‑reset links actually
work); a **Display SMS as Drupal messages** counterpart delivered by the
`domino_sms` submodule (which works with the SMS Framework module); three
ready‑made **configuration splits**, one each for Development, Staging, and
Production; two standardized **user roles**, Developer and Manager; and
**email rerouting** for non‑production environments so development mail never
reaches real recipients.

Two behaviors deserve attention up front. Domino enables **Reroute Email** but
leaves the rerouting *feature* off by default — and if Reroute Email is not
configured for your non‑production environments, Domino will *prevent all emails
from being sent* until rerouting is set up. Configure it correctly per
environment so production mail is never rerouted and non‑production mail is never
sent to real users. Domino also **blocks the super‑admin user (uid 1)** for
security, changing its username and password on cron or cache flush.

It depends on **Config Split** and **Reroute Email** (with Features suggested,
optionally, if you want to receive configuration updates), runs on Drupal 10.1
and 11, is actively maintained, and is security‑advisory covered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its Config Split / Reroute Email dependencies, and enable the
   optional SMS submodule.

Domino has no single settings form of its own; its behavior is driven by the
configuration it ships (the three environment splits) and by the settings of the
modules it bundles. That is why there is no separate Configuration page in this
guide — the important tuning happens in **Config Split** and **Reroute Email**,
per environment, as described below.

## How to use it

Enable Domino as part of standing up a new project. It will create the Developer
and Manager roles, generate test users based on your roles, and set up the three
environment configuration splits. Then:

- **Configure Reroute Email per environment** — this is the most important step.
  Ensure non‑production environments reroute (or suppress) mail, and that
  production sends normally. Remember that until rerouting is configured, Domino
  blocks all outgoing mail as a safety measure.
- **Review the environment splits** in Config Split (Development, Staging,
  Production) and align them with how your deployments select an active split.
- **Confirm the super‑admin handling** — Domino deactivates uid 1 and rotates its
  name and password on cron/cache flush, so plan to administer the site through
  properly permissioned roles rather than user 1.
- If you need SMS message display for testing, enable the **`domino_sms`**
  submodule alongside the SMS Framework module.
