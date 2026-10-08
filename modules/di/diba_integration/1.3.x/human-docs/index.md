# Diba Integration — manual setup guide

**Diba Integration** (`diba_integration`) is an integration and setup
meta-module for the **Diputació de Barcelona (Diba)** platform. Rather than adding
a feature of its own, it bundles and configures a standard set of modules and
settings so that a Drupal site aligns with Diba's conventions out of the box —
things like an admin toolbar, anti-spam protection (Antibot/Honeypot), backup
tooling, user impersonation, path aliases, and a sitemap.

It builds directly on well-known contrib modules. Its declared dependencies are
**Masquerade**, **Simple Sitemap**, and **Pathauto**, and it ships several
optional submodules — `diba_integration_cogo`, `diba_integration_extra`,
`diba_integration_saml`, and `diba_integration_vus` — so you can add SAML
authentication and other Diba-specific pieces only where you need them. It targets
Drupal 10.3, 11, and 12.

Because this module pulls in privileged functionality, treat its setup as a
security-sensitive task: **Masquerade** lets trusted users impersonate others, and
the **SAML** submodule handles authentication. Lock those down — restrict
masquerade to trusted administrators, configure SAML with verified metadata and
certificates, and store any secrets securely. Diba Integration layers on the
access controls of the modules it bundles rather than adding its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, enable it, and pick the submodules you need.

This module has **no configuration form of its own** — it configures and relies
on the modules it bundles. Configure those modules (Masquerade, Pathauto, Simple
Sitemap, the SAML submodule, and so on) through their own settings pages.

## Where it lives in the admin menu

Diba Integration adds no single settings page. Its effect is to install and
pre-configure other modules; you'll find the relevant settings under each bundled
module's own admin location.
