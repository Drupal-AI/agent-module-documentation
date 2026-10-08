# Reauthenticate on idle browser — manual setup guide

**Reauthenticate on idle browser** (`idle_reauthenticate`) protects logged‑in
sessions on shared or unattended machines. When an authenticated user leaves
their browser untouched for a configurable period, the module blocks any further
interaction and shows a modal dialog asking them to prove they are still the
person at the keyboard before they can carry on.

This is a real security benefit: an unattended, still‑logged‑in browser is an
open door to whatever that account can do. By requiring re‑authentication after a
period of inactivity, the module closes that window without logging the user out
outright — which matters, because it means a half‑filled form or in‑progress work
is still there once they re‑authenticate (handy if the phone rang or they simply
stepped away).

Importantly, the block applies to the **whole session**, not just the current
tab — so a user can't sidestep it by opening another tab. When the idle dialog
appears, the returning user can re‑authenticate with their password, or log in as
a different user. (Re‑authentication via a user‑defined token and via 2FA are
noted by the maintainers as planned additions.) It depends on core's **User**
module and supports Drupal 10.4+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the idle timeout and choose
   which re‑authentication methods are allowed.

## Where it lives in the admin menu

The module's settings — the idle time before a session is blocked and which
re‑authentication methods are permitted — live on its configuration form under
**Configuration**. See [Configuration](configuration/index.md).
