# Logout on Timeout — manual setup guide

**Logout on Timeout** (`logout_timeout`) automatically signs a user out after a
set period of **inactivity**. Before it does, it shows a pop‑up that warns the
user their session is about to end and lets them either **extend the session** or
**log out immediately**. It's a classic session‑security measure for shared,
unattended, or high‑sensitivity machines, where an abandoned browser shouldn't
stay logged in.

The module is built for real multi‑tab use: it synchronises session status across
**all open tabs** so they all log out together, and it uses Web Workers to keep
the timing accurate even in tabs that are no longer the active one. You get full
control over the alert wording — both the pop‑up message and an optional flashing
**tab‑title** alert — and the logout URL carries a query parameter so your theme
can show a custom "you were logged out" message.

It has a couple of specialist integrations: it can work with the
**simpleSAMLphp Authentication** module (redirecting to that module's configured
logout target rather than a hard‑coded destination) and can fire a logout event
through **Hook Event Dispatcher's** User Event Dispatcher submodule. Both are
optional and only do anything if those modules are present.

Because the timing runs in the browser, **end users must have JavaScript
enabled** — the module is recommended only for sites that require JS. It depends
on core's **User** module. Note that it ships **disabled**: after installing you
must turn it on from the configuration form before it does anything.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn the feature on, set the
   timeout, customise the alerts, and wire up the optional integrations.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → People → Logout on
Timeout** (`/admin/config/people/logout_timeout`). Related permissions are set at
**People → Permissions** (`/admin/people/permissions`).
