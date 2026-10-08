# ACSF Connector — manual setup guide

**ACSF Connector** (`acsf`) is the site-side integration for **Acquia Cloud Site
Factory (ACSF)**, Acquia's hosting product for running and managing large numbers
of Drupal sites from a single codebase and a central Management Console (called
"the Factory"). This module is the code that lives inside each managed site and
talks back to the Factory — handling site duplication, staging database scrubs,
factory data sync, theme events, and single sign-on.

**It only does useful work on Acquia-hosted ACSF environments.** On an ordinary
Drupal site the module installs but stays completely inert — all of its real
behavior is gated behind a check for an Acquia host and the site's
Factory-assigned identity. So you would only install this if your site is (or is
becoming) part of an Acquia Cloud Site Factory.

Because it is a platform integration, ACSF Connector works very differently from a
typical contrib module: it has **no admin settings form and no permissions**. Its
configuration is written by the platform, and the critical setup step is a
standalone `acsf-init` Drush script that patches your codebase (`sites.php`, Cloud
Hooks, `.htaccess`) so each incoming request is routed to the correct site
database during early bootstrap. That script must be re-run after **every** ACSF
module update. The suite ships several submodules from one shared codebase; the
main module requires `acsf_theme` and `acsf_variables`, with optional add-ons for
SAML SSO, scheduled jobs, and meta tags.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the Drush command list,
the `AcsfMessage`/`AcsfSite`/`AcsfEvent` API, and the scrub hooks — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its required submodules, and run `acsf-init` to patch the codebase.

There is no configuration page in this guide: ACSF Connector has **no admin
settings form** (its `acsf.settings` config is managed by the platform, not by an
admin UI) and no permissions.

## Where it lives in the admin menu

Nowhere. ACSF Connector adds no admin menu item, settings form, or permission.
Everything happens at the platform level and through Drush commands (see the
[agent Drush reference](../agent/drush/acsf.md) for the full list). The only
user-visible touch is an "ACSF site maintenance in progress" notice that appears
during platform operations.

## How to use it

1. Confirm your site runs (or will run) on **Acquia Cloud Site Factory** — off
   the platform this module does nothing.
2. Install and enable the module and its required submodules (see
   [Installation](installation/index.md)).
3. Run the standalone **`acsf-init`** Drush script to patch the codebase, and
   `acsf-init-verify` to confirm it — ACSF blocks deployment if verification
   fails. Re-run `acsf-init` after every ACSF module update.
4. Let the platform and its hosting tasks drive the rest: site sync (daily via
   cron and on demand), staging database scrubs when a production site is copied,
   and factory data updates. These run through the module's own event framework
   and Drush commands, not through the Drupal UI.
