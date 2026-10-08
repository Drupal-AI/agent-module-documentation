# miniOrange Keycloak User Provisioning — manual setup guide

**miniOrange Keycloak User Provisioning** (`keycloak_user_provisioning`) keeps your
Drupal users synchronized with [Keycloak](https://www.keycloak.org/), the
open‑source identity and SSO server. When a user is created, updated, or deleted in
Drupal, the change is pushed to Keycloak so the two systems hold a consistent set of
profiles — which makes onboarding and ongoing user management much simpler when
Keycloak is your central identity provider.

It offers three provisioning modes so you can match your workflow:

- **Real‑time** — every user create/update/delete in Drupal syncs to Keycloak
  immediately.
- **Manual / on‑demand** — provision one or many users on demand, which is handy for
  troubleshooting or urgent updates without waiting for cron.
- **Scheduler / cron‑based** — automate synchronization on a schedule you set.

It can **map user attributes** (name, email, roles, and other profile fields)
between Drupal and Keycloak, and it keeps **audit logs** of create, update, and
delete operations so you can monitor sync status and stay compliant.

The module builds on the **User Provisioning** module and talks to Keycloak's admin
API using credentials you configure. Those admin credentials are powerful — they can
manage users in your realm — so store them securely (backed by an environment
variable), never commit them, and scope the Keycloak client to the least privilege
needed. It supports Drupal 9.3, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it with
   the User Provisioning module.
2. [Configuration](configuration/index.md) — connect to Keycloak, choose a
   provisioning mode, and map attributes.

## Where it lives in the admin menu

This module plugs into the **User Provisioning** module, so its provisioning method
and connection settings are reached through that module's configuration under
**Configuration → People**. See [Configuration](configuration/index.md) for the
walkthrough.
