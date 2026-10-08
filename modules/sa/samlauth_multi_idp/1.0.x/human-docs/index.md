# SAML Auth Multi IdP — manual setup guide

**SAML Auth Multi IdP** (`samlauth_multi_idp`) extends the SAML Authentication
(`samlauth`) module so that a single site can authenticate users against **more
than one identity provider (IdP)** at the same time. Where `samlauth` on its own
assumes one IdP, this module lets you configure several — for different
organisations, tenants or login portals — and use them interchangeably.

It was built for a real situation where users needed to log in through multiple
portals, and it has been used across development, staging and live deployments.
IdPs are stored as **configuration entities**, so they can be exported and
imported like any other Drupal config and kept in sync between environments. Each
IdP can have its own login link, and you can disable the link for any IdP you do
not want to advertise. When several IdPs have login links enabled, the standard
samlauth login link is replaced by a page that lists all of them so the user can
pick.

The module needs configuration to be useful, but it gets you started
automatically: on installation a **default IdP** is created, and if you already
had an IdP configured in `samlauth` it becomes that default. The default also
acts as a fallback if an invalid IdP link is ever followed. It reuses samlauth's
existing metadata, SSO, SLO and ACS endpoints rather than inventing its own. It
depends on the `samlauth` module, provides its own permissions, and has no
submodules.

Because this touches authentication, keep the security basics in mind: the actual
SAML assertion validation (signatures, conditions) is still handled by `samlauth`
and its underlying toolkit — this module adds the per‑IdP configuration and
routing around it. Keep each IdP's certificate and metadata correct, make sure
assertions are validated for every IdP, store any signing keys securely, and
serve the site over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside samlauth.
2. [Configuration](configuration/index.md) — add and manage IdPs and their login
   links.

## Where it lives in the admin menu

After installation, manage your identity providers at
**`/admin/config/people/saml/idp`**, where you can add additional IdPs or edit
the default one.

## How to use it

Add each IdP you need and enable a login link for the relevant ones — those links
then appear on the standard Drupal login page. If more than one IdP has a login
link enabled, the single samlauth login link is replaced by a page listing all
the enabled providers for the user to choose from.
