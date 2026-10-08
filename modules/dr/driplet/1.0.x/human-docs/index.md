# Driplet — manual setup guide

**Driplet** (`driplet`) is a WebSocket‑based real‑time notification system for
Drupal. It lets your site push live messages to the browser — targeted at
specific users, roles, or topics — so visitors see updates the moment they
happen instead of waiting for a page reload. Typical uses include real‑time
notifications and content alerts, moderation‑queue notices, live log streaming,
custom live analytics, and even user‑to‑user chat.

Driplet is not a self‑contained module: it works together with **Driplet**, a
separate Go‑based microservice, and it depends on the **Driplet PHP library**.
The flow is: your Drupal backend pushes a message to the Driplet microservice,
which then delivers it over WebSockets to the subscribed frontend clients. Drupal
issues each connecting user a **JWT** (from a `/api/driplet/jwt` endpoint) that
encodes their user ID and roles, and the microservice uses that token both to
authenticate the user and to decide who a given message should reach. Frontend
clients subscribe to **topics** so they only receive the messages relevant to the
page they're on.

Two optional submodules ship as worked examples: **`driplet_log`** for viewing
logs in real time, and **`driplet_notify`** for real‑time push notifications.

The JWT signing secret ties Drupal to the microservice, so set it to a strong,
unique value of your own and use the same value on both sides (see
[Configuration](configuration/index.md)); don't ship the placeholder that comes
in the default configuration. Note that much of Driplet's real power
is exposed through a PHP service (`driplet.service`) and a JavaScript client, so
building notifications into your site involves some developer work beyond the
admin UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its example submodules, and run the Driplet microservice.
2. [Configuration](configuration/index.md) — set the JWT signing secret and
   point Drupal at your running Driplet microservice.

## Where it lives in the admin menu

Driplet's settings (including the JWT secret and the microservice connection) are
configured under the site **Configuration** menu. The real work of sending and
receiving messages happens in code — a PHP service on the backend and a JavaScript
client on the frontend — rather than through admin screens.

## How to use it

1. Install and enable the module, and set up and run the Driplet **microservice**
   (see [Installation](installation/index.md)). The microservice must be running
   before the module can deliver anything.
2. Set a strong **JWT signing secret** and configure the microservice connection
   (see [Configuration](configuration/index.md)).
3. In your backend code, push a message through the `driplet.service` service,
   choosing a topic and a target (a set of user IDs, roles, or an inclusion /
   exclusion rule).
4. On the frontend, use the Driplet JavaScript client to subscribe to the topics a
   page cares about and handle incoming messages.
5. Enable **`driplet_notify`** or **`driplet_log`** for ready‑made examples of push
   notifications and real‑time logs.
