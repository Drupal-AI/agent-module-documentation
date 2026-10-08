# Role Test Accounts — manual setup guide

**Role Test Accounts** (`role_test_accounts`) creates one **test user account per
role** on your site, so developers can quickly log in as a representative of any role
to test role-based behaviour, permissions, and displays — without hand-creating a
user for each role.

It can also optionally **block** the test accounts automatically after a configurable
amount of time, so stale test logins don't linger. It depends on core's User module
and supports Drupal 10.2 and 11.

> **Development use only — do not enable on production.** By design this module
> creates real user accounts that hold your site's roles (potentially including
> privileged ones). On a live site those are extra credentialed accounts and a real
> access-risk surface, especially if they have weak or well-known passwords. Keep it
> to local and staging environments, and remove any test accounts before go-live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (on non-production environments only).

Configuration is a single form, described below.

## Where it lives in the admin menu

Once enabled, the settings live at the `role_test_accounts.settings` route (under the
site's configuration). This is where you generate the accounts and set the optional
auto-block timing.

## How to use it

1. On a **local or staging** environment, enable the module.
2. Open the Role Test Accounts settings form (`role_test_accounts.settings`).
3. Generate the per-role test accounts. The module creates one account for each role
   so you can log in as each in turn to check permissions and displays.
4. *(Optional)* Set the **auto-block** period so the test accounts are blocked
   automatically after the configured amount of time.

## Keep it out of production

Because the accounts it creates are real, credentialed users that may hold
privileged roles, treat this strictly as a developer tool:

- Never enable it on a production site.
- Remove the generated test accounts before a site goes live.
- Prefer strong passwords even in staging, and don't reuse test credentials across
  environments.
