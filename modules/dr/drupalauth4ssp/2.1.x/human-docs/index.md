# DrupalAuth for SimpleSAMLphp — manual setup guide

**DrupalAuth for SimpleSAMLphp** (`drupalauth4ssp`) turns your Drupal site into
the **login experience for a SimpleSAMLphp Identity Provider (IdP)**. Users create
and manage their accounts in Drupal and authenticate at Drupal's own login form;
SimpleSAMLphp, running alongside the site, then issues SAML assertions to the
service providers (other applications) that trust it. In short: Drupal *is* your
identity provider's front end, and other apps become service providers that
delegate their sign‑in to it.

**The direction matters, and it is the opposite of most SAML modules.** It is easy
to confuse this with `simplesamlphp_auth`, so be precise:

| Module | Drupal's role |
|---|---|
| `simplesamlphp_auth` | **Service provider** — users log in at an *external* IdP and arrive at Drupal already authenticated. |
| `drupalauth4ssp` (this module) | **Identity provider front end** — users log in *at Drupal*, and SimpleSAMLphp asserts their identity out to other apps. |

The problem it solves is single sign‑on backed by Drupal accounts: instead of
every application keeping its own user store, they all trust one Drupal directory,
and users get one login across the estate. The Drupal side is deliberately
compact — a settings form, one security‑sensitive permission, a handler service,
an event subscriber, and a redirect route that returns the user to whichever
service provider sent them. The real work of federation happens in SimpleSAMLphp,
which you install and configure **outside** Drupal, together with the companion
`drupalauth` SimpleSAMLphp module that reads Drupal's session back.

> **Trust and risk:** an IdP concentrates risk. Whoever can log in at Drupal — or
> administer this module — effectively holds the keys to every service that trusts
> the IdP. Lock down the configuration permission, and strongly consider pairing
> the site with two‑factor authentication (the project suggests `drupal/tfa`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required SimpleSAMLphp companion module and its Composer plugin), and enable
   the module.
2. [Configuration](configuration/index.md) — the settings form, the
   security‑sensitive permission, and how Drupal hands off to SimpleSAMLphp.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → People → DrupalAuth for
SimpleSAMLphp** (`/admin/config/people/drupalauth4ssp`, route
`drupalauth4ssp.settings`), behind the `administer drupalauth4ssp configuration`
permission. The module also registers a `/drupalauth4ssp/redirect` route (for
logged‑in users) that returns a user to the originating service provider after
login.
