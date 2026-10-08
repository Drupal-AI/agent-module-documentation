# Supervisor — manual setup guide

**Supervisor** (`supervisor`) gives you a simple admin UI for controlling the
programs running under **Supervisor**, the well-known process-control system.
Supervisor (the external tool) runs and monitors long-running worker processes —
typically things like queue workers — and this module surfaces its status and
controls inside Drupal so that operators can start, stop and restart those
background workers without needing shell access to the server.

The problem it solves is operational convenience and access. On many hosting
setups, the people who need to bounce a stuck worker or check whether background
processing is alive do not have — and should not need — SSH access to the box.
This module brings the essential Supervisor controls into the Drupal admin
interface, so managing background workers becomes a point-and-click task for
authorised users.

Enabling the module is not the whole story: Supervisor needs to know how to reach
your Supervisor instance. The connection details and credentials are configured by
an administrator. Treat those credentials as secrets — store them in an environment
variable rather than hard-coding or committing them. The module targets Drupal
10.4+ and 11, provides its own permission for gating access to the controls, and
has no module dependencies beyond core.

This guide is written for a **human** operator using the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once the module is enabled and its connection to your Supervisor instance is
configured, a user with the appropriate permission can view the running programs
and their status and issue start / stop / restart actions against them from the
Drupal admin UI — no shell required. Because these controls affect real background
processes, grant the permission only to trusted operators.
