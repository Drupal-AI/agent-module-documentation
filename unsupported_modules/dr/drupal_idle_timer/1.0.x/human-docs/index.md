# Drupal Idle Timer — manual setup guide

**Drupal Idle Timer** (`drupal_idle_timer`) watches for user inactivity and acts
on it: after a configurable idle period it warns the user and/or logs them out.
It is a small session‑management and security tool, most valuable on shared or
kiosk machines where a walked‑away session should not stay open indefinitely.

The problem it solves is stale, unattended sessions. Left to itself, a logged‑in
Drupal session persists whether or not anyone is actually at the keyboard — a real
risk on public terminals, reception desks, or any device several people use. Idle
Timer closes that gap by counting idle time and, once the limit is reached,
prompting the user (so they can stay signed in if they are still there) and/or
ending the session.

It ships several configuration options so you can tune how long "idle" is and how
the timeout behaves, and it provides its own permission. It is published under the
`dit` project on drupal.org (hence the Composer name `drupal/dit`) and supports
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the idle period and the
   warning/logout behavior.

## Where it lives in the admin menu

The module provides a settings form for its idle‑timer options (idle period,
warning, and logout behavior). Because it lives in Drupal's Configuration area,
look for **Drupal Idle Timer** under **Configuration** after enabling — see
[Configuration](configuration/index.md) for what each option does. It also adds
its own permission, managed at **People → Permissions**.
