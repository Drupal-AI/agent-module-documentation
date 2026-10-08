# miniOrange Okta User Sync — manual setup guide

**miniOrange Okta User Sync** (`okta_user_sync`) keeps user accounts in step between
your Drupal site and [Okta](https://www.okta.com). It provisions and de‑provisions
users in both directions and maps user attributes between the two systems, so that
creating, updating, or removing an account in one place is reflected in the other.

It offers three provisioning modes:

- **Automatic / real‑time (Drupal → Okta):** users are provisioned to Okta as soon as
  a create/update/delete happens in Drupal, driven by Drupal's user hooks (via the
  required [User Provisioning](https://www.drupal.org/project/user_provisioning)
  module).
- **Manual / on‑demand (bi‑directional):** provision a single user or all existing
  users immediately, without waiting for cron — handy for troubleshooting too.
- **Scheduler / cron‑based (bi‑directional):** provision on a schedule, including
  custom schedules.

It also maps user profile attributes (name, email, and more) between Okta and Drupal,
and keeps audits and logs of every sync operation for review and troubleshooting. All
of its admin screens are gated by the **Administer site configuration** permission;
there is no anonymous or public trigger.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside User Provisioning.
2. [Configuration](configuration/index.md) — connect to Okta (base URL, UPN, API
   token), map attributes, and turn on the provisioning you want.

## Where it lives in the admin menu

The module's admin area is at **Configuration → People → Okta User Sync**
(`/admin/config/people/okta_user_sync`), with tabs for the overview, Drupal → Okta,
Okta → Drupal, attribute mapping, advanced settings, and audits/logs. Every tab
requires the **Administer site configuration** permission.
