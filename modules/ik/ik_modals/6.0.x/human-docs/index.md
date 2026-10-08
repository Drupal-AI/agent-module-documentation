# Modal Management Module — manual setup guide

**Modal Management Module** (`ik_modals`) lets site builders create and manage
modals (pop-up dialogs) as content that lives in one place, rather than scattering
them across templates and custom code. It defines a custom **Modal** entity with
support for different **bundles** (modal types), each of which is fieldable and
comes with its own template suggestions — so you can build and style distinct kinds
of modal (a newsletter sign-up, a cookie notice, a promotion) and maintain them
centrally.

It is maintained by Interactive Knowledge (the "IK" package). Because modals can be
targeted by a visitor's location, the module can integrate with geolocation
services — a bundled GeoIP2 library, and optionally the ipdata or AbstractAPI
services (each of which needs an API key).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the required
   Block and Address modules, and enable it.
2. [Configuration](configuration/index.md) — the settings form, managing modal
   bundles and content, and the optional geolocation API keys (and how to store
   them safely).

## Where it lives in the admin menu

Once enabled, the module's settings form is reached via its configure link at
`ik_modals.settings`. Modal content is **admin-authored** and shown to visitors, so
it carries no access-control role of its own — instead the module provides its own
permissions so you can decide who is allowed to create and manage modals. Gate
those permissions to trusted editors under **People → Permissions**.
