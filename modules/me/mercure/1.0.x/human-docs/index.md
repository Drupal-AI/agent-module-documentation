# Mercure — manual setup guide

**Mercure** (`mercure`) integrates the [Mercure protocol](https://mercure.rocks)
with Drupal. Mercure is a way to push live data updates to web browsers and other
HTTP clients in a fast, reliable, battery‑efficient way, using server‑sent events
(SSE) over a publish/subscribe model. In practice that means Drupal can publish an
update to a **Mercure hub**, and any front end subscribed to the relevant topic
receives it in real time — ideal for live content updates and notifications in
decoupled or interactive setups.

This module is the Drupal‑side glue: it wires Drupal into the Mercure Component so
your code can publish updates to a hub. It does not ship a hub itself — you run (or
subscribe to) a Mercure hub separately and tell Drupal how to reach it. It works on
Drupal 9.5, 10, and 11 and has no other module dependencies.

Because Mercure uses **JWT** (JSON Web Tokens) to authorise publishing — and, for
private topics, subscribing — there is a real secret to manage. The token that
signs *publisher* tokens must be kept confidential: anyone who has it can publish to
any topic on your hub. This guide's [Configuration](configuration/index.md) page
covers how to point Drupal at your hub and how to store that JWT secret safely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — point Drupal at your Mercure hub and
   store the JWT secret securely.

## How to use it

At a high level: stand up a Mercure hub, tell Drupal its URL and the JWT secret
(see Configuration), and then publish updates from your code to the topics your
front end subscribes to. The exact API and the precise configuration keys are
documented in the module's own `README` on
[drupal.org](https://www.drupal.org/project/mercure); this guide focuses on getting
the connection details in place safely.
