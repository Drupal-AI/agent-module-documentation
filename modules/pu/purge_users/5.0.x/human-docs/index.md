# Purge Users — manual setup guide

**Purge Users** (`purge_users`) deletes or cancels user accounts that match
criteria you define — accounts that never logged in, that have been inactive or
blocked for too long, or whose last login is older than a threshold. It's a
practical tool for tidying up dormant accounts and supporting data-minimisation
(GDPR-style) housekeeping, with optional warning emails before an account is
removed.

There are two ways to define who gets purged:

- **The global settings form** offers four independent age-based rules —
  *never logged in*, *last login older than*, *inactive / never activated*, and
  *blocked* — each with a value, a period (minutes/hours/days/…), and an on/off
  toggle. It also lets you exclude content authors or commenters, include or
  exclude specific roles, choose how accounts are cancelled, and set up
  notification emails.
- **Policies** are named, reusable rule sets built from composable **condition
  plugins** (never logged in, not logged in, inactive, blocked, included/excluded
  roles, author/commenter, notification-required). Policies let you combine
  conditions — for example "blocked *and* not in the staff role".

Purging can run automatically on **cron** (opt-in), on demand via **Drush**, or
manually through a confirmation form. Under the hood, matching accounts are pushed
onto Drupal queues and processed in the background, so even large purges run
safely. Deletion uses Drupal core's standard account-cancel methods, so it honours
your chosen cancel behaviour and fires the normal cancellation hooks and emails.

> **Safety first.** Every rule and the cron trigger ship **disabled by default**,
> and all the admin and confirmation screens are behind restricted permissions.
> Nothing is deleted until you deliberately enable rules and trigger a purge.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global rules, cancel methods,
   notifications, policies, and how to trigger a purge.

## Where it lives in the admin menu

The settings live at **Configuration → People → Purge Users**
(`/admin/config/people/purge-users`), with a **Policies** sub-page and a
confirmation form for running a purge on demand.
