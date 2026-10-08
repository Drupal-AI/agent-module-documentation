# Domain Menu Links — manual setup guide

**Domain Menu Links** (`domain_menu_links`) is a small administrator convenience
for Domain-module multisites. It adds a drop-down to the admin toolbar listing all
of your registered domains, so you can switch between domains while browsing
without hand-editing URLs. It is an extension of the **Domain** ecosystem and
depends on both the base `domain` module and the **Admin Toolbar** module (which
provides the expandable toolbar it hangs the links from).

There is nothing to build content-wise: once enabled, the domain drop-down simply
appears in the toolbar for users who can see it. This is admin-facing navigation
with no unusual security surface — the one thing worth doing is making sure only
the administrators who should switch between domains have access to the toolbar.

The only setting is a cosmetic one: where the domain drop-down sits relative to
other toolbar items, controlled by a *Parent menu link weight* value.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Domain and Admin Toolbar.
2. [Configuration](configuration/index.md) — set the position (weight) of the
   domain drop-down in the toolbar.

## Where it lives in the admin menu

Once enabled, the domain drop-down appears in the **admin toolbar** at the top of
every admin page. Its one setting lives at **Configuration → Domain → Domain Menu
Link Settings**.
