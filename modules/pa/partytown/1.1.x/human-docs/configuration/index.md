# Configuration

One of the reasons to use this module rather than wiring Partytown up by hand is
that it provides a **UI for configuring the integration** — so you manage which
scripts get offloaded from the admin area instead of editing templates.

## Before you configure

Make sure both pieces are in place first (see
[Installation](../installation/index.md)):

1. The **Partytown module** is enabled.
2. The **Partytown JavaScript library** is installed and available to the site.

Only then does the "send scripts to Partytown" step have something to work with.

## Open the settings

Log in as an administrator and open the module's **Partytown** configuration form
from the site's configuration area. This is where you manage the integration and
decide which third‑party scripts Partytown should take over.

## Send scripts to Partytown

The heart of the setup is telling Partytown *which* scripts to move into the web
worker — typically your analytics, tag manager, or other third‑party tags. Use the
configuration UI to designate those scripts for offloading. Everything you do not
hand to Partytown continues to run normally on the main thread.

## Test as you go — this is experimental

Partytown is an experimental technology, and not every third‑party script behaves
correctly inside a web worker. Offload scripts **one at a time** and verify each
one still works as expected before moving on:

- Confirm the feature the script powers (analytics events firing, a chat widget
  loading, etc.) still works after offloading.
- Watch the browser console for errors coming from the worker.
- Keep the Partytown project's "trade‑offs" documentation to hand — it lists the
  kinds of scripts that need special handling or cannot be offloaded.

If a particular script misbehaves in the worker, simply leave it out of the
Partytown configuration so it runs on the main thread as before.

## A note on privacy

Moving a script into a web worker changes where it runs, not what it does. Any
consent, cookie, or privacy obligations tied to your third‑party scripts still
apply exactly as before — Partytown does not alter them.
