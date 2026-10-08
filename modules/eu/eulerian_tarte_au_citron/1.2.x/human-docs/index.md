# Tarte au citron Eulerian — manual setup guide

**Tarte au citron Eulerian** (`eulerian_tarte_au_citron`) makes **Eulerian**
analytics consent‑compliant by registering it as a service in the **Tarte au
citron** consent manager. With this module in place, the Eulerian tracking tag (and
the cookies it sets) load **only after the visitor gives consent**, instead of
firing on page load.

It is a small bridge/plugin: it depends on the **Tarte au citron** module and adds
Eulerian to the set of services Tarte au citron gates. It sits in the GDPR package
and is a **privacy‑positive** feature — it prevents the Eulerian tracker from
running before consent, which supports GDPR/ePrivacy compliance. The module has no
access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Tarte au citron dependency.

This module has **no settings form of its own** — it adds Eulerian to Tarte au
citron, and the settings live in the Tarte au citron (and Eulerian) modules,
described in "How to use it" below.

## How to use it

1. Configure the **Eulerian** module with your Eulerian tracking setup (see the
   Eulerian module's own guide).
2. Set up the **Tarte au citron** consent manager — its banner and the services /
   categories it manages.
3. With **Tarte au citron Eulerian** enabled, Eulerian appears as a consent‑gated
   service in Tarte au citron. Confirm it is enabled there so the Eulerian tracker
   loads only after consent.
4. Test as an anonymous visitor: the Eulerian tracker and its cookies should **not**
   appear until consent is given, and should load once it is.
