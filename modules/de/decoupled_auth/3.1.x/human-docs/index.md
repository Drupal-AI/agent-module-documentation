# Decoupled User Authentication — manual setup guide

**Decoupled User Authentication** (`decoupled_auth`) lets Drupal user records
exist *without* the ability to log in. Normally every Drupal user is an account
with a username and password. This module decouples authentication from the user
entity, so you can store people as Drupal users — for a CRM, a mailing list, or
any set of relationships — without those records being login accounts.

Why would you want that? Drupal has a rich ecosystem of modules that work
beautifully with users: Simplenews, Organic Groups, Profile, Drupal Commerce, and
more. Those modules become far more useful if they can also work with people who
have *not* registered. Storing profiles for unregistered users opens up using
Drupal as a CRM framework; Commerce can let a shopper give an email address at
checkout without forcing them to register first. Decoupled User Authentication is
the foundation that makes all of that possible.

The distinction it introduces is between **coupled** users (who have
authentication and can log in) and **decoupled** users (who have no
authentication and cannot log in). This is a deliberately security‑positive
design: because a decoupled user has no credentials, creating thousands of contact
records does not create thousands of login accounts or any new login attack
surface — the login‑less state is enforced by the module, not merely a convention.
When you adopt it, be clear in your own processes about which users are coupled and
which are decoupled, and make sure any step that later *couples* a user (grants
them the ability to log in) is deliberate and trusted. The module ships an optional
**CRM** submodule (`decoupled_auth_crm`) for CRM‑oriented workflows.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the CRM submodule.

This module has **no dedicated settings form** in the admin UI. It works by
extending the base user entity, and its behaviour is driven through the user
system and code/APIs rather than a configuration page — so there is no
Configuration section in this guide.

## Where it lives in the admin menu

Decoupled User Authentication adds no top‑level configuration page. Its effects
appear throughout Drupal's user handling — you continue to manage people under
**People** (`/admin/people`), with the new capability that some of those records
can be login‑less (decoupled) accounts. Developers integrate with it through its
API when building CRM‑style workflows.
