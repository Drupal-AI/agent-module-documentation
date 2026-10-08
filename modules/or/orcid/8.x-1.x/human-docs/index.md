# ORCID — manual setup guide

**ORCID** (`orcid`) lets people create an account and log in to your Drupal site with
their **ORCID iD** using OAuth2, and lets existing users connect (link) their ORCID
iD to their account. ORCID is the open, non‑profit registry of unique researcher
identifiers, so this module is aimed at academic and research sites that want
researchers to sign in with the identity they already use.

To work, the module needs an **OAuth application registered with ORCID**, which gives
you a **client ID** and **client secret** to configure in Drupal. Users are then sent
to ORCID to authorise, and returned to your site to be logged in or linked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register an ORCID OAuth application and
   store its client ID and secret safely.

## Where it lives in the admin menu

The module handles the ORCID OAuth login and account‑linking flow (the callback lives
at `/orcid/oauth`) and provides its own permissions. You supply the ORCID OAuth
application's client ID and secret in its settings — see
[Configuration](configuration/index.md).
