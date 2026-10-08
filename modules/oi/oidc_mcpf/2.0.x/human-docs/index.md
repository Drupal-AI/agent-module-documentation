# OIDC My Citizen Profile Flanders — manual setup guide

**OIDC My Citizen Profile Flanders** (`oidc_mcpf`) integrates Drupal login with the
Flemish Government's **ACM/IDM** identity system — "Mijn Burgerprofiel" / My Citizen
Profile — over OpenID Connect. It lets citizens and organisation representatives log
in to your Drupal site with their Flemish government identity.

It builds on the [OpenID Connect Client](https://www.drupal.org/project/oidc)
(`oidc`) module, adding an **ACM realm** so users can authenticate against ACM, plus
government‑specific handling on top:

- **IDM support with audience‑specific accounts.** When a user logs in as
  themselves and later as a representative of an organisation, two separate local
  accounts are created — one per audience — so you can manage audience‑specific
  permissions cleanly. The module ships **audience validation** to keep those
  identities correct.
- **Role mapping.** IDM roles can be mapped to Drupal roles, which are then assigned
  or revoked automatically each time a user logs in.
- **The "Mijn Burgerprofiel" toolbar**, which can be added automatically to the top
  of the page.

It also ships an `oidc_mcpf_user_purge` submodule for cleaning up accounts, and
depends on core **Telephone** in addition to the OIDC module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside OIDC and Telephone.
2. [Configuration](configuration/index.md) — connect to ACM/IDM and map roles
   safely.

## Where it lives in the admin menu

Configuration happens through the OpenID Connect Client module — you add and set up
the **ACM realm** and its role mappings in the OIDC realm administration (behind the
**Administer OIDC** permission).
