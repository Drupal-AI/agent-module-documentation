# Drupal Remote Dashboard — manual setup guide

**Drupal Remote Dashboard** (`drd`) is a central dashboard for monitoring and
managing any number of remote Drupal sites from one place. Instead of logging
into each site to check for security updates, review its status report, or run
maintenance actions, you connect them all to a single DRD instance and see — and
act on — the whole fleet at once. It's aimed at agencies, freelancers, and site
owners who look after more than one Drupal site and don't want to route that
oversight through a third‑party service.

DRD works as a hub‑and‑spoke system. This module is the **dashboard** (the hub).
Each remote site you want to manage runs the companion **DRD Agent** module,
which the dashboard authenticates against to inspect the site and trigger
actions on it (checking updates, reading the status report, running operations).
Several optional submodules extend the dashboard: **DRD ECA** (`drd_eca`) for
event‑driven automation, **DRD Migrate** (`drd_migrate`), **DRD Install Core**
(`drd_install_core`), and a family of hosting‑provider integrations under **DRD
PI** — `drd_pi`, plus `drd_pi_acquia`, `drd_pi_pantheon`, and
`drd_pi_platformsh`.

**Treat DRD as critical infrastructure.** A dashboard that can authenticate to
and act on every managed site is, in effect, an administrator of all of them —
so a compromise of the dashboard, or of a dashboard‑to‑site connection, is a
compromise of every site behind it. That reality shapes how you deploy it:
restrict who can reach the dashboard, protect the connection credentials, always
connect over TLS with certificate verification, and guard the hosting‑provider
API keys that the DRD PI submodules hold. Its power is exactly its risk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the dashboard with Composer,
   enable it and the submodules you need, and install the DRD Agent on each
   remote site.

DRD's setup is a multi‑step process built around its dashboard and the
per‑site agent connections rather than a single settings form; the essentials are
in "How to use it" below, and the project's community documentation on drupal.org
covers the full detail.

## Where it lives in the admin menu

Once enabled, DRD adds its dashboard and remote‑site management screens under the
site administration menu (it builds on core **Views**, **Taxonomy**, and
**Update**, so much of the fleet data is presented as views). Because setup
involves registering remote sites and their agents, plan to follow the
step‑by‑step guidance in the project's documentation on drupal.org as you connect
each site.

## How to use it

1. Install and enable the DRD dashboard module on your central management site
   (see [Installation](installation/index.md)). Enable only the submodules you
   need — for example `drd_pi_acquia` if you host on Acquia.
2. On **each remote site** you want to manage, install and enable the **DRD
   Agent** module (`drd_agent`) — this is what the dashboard connects to.
3. From the dashboard, register each remote site and establish its authenticated
   connection. Use **TLS with verification** and store the connection
   credentials as secrets.
4. Restrict access to the DRD dashboard tightly — it is effectively an
   administrator of every managed site.
5. Use the dashboard to review update status, read status/health reports, and run
   actions across your sites. Optionally use **DRD ECA** to automate responses to
   events across the fleet.

> **Security reminder:** protect every dashboard‑to‑site credential and every
> hosting‑provider API key the DRD PI submodules use. A single leaked credential
> can expose the whole fleet.
