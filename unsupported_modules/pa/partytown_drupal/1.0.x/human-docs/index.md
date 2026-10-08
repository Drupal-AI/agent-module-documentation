# Partytown Drupal — manual setup guide

> **This module is no longer maintained.** Its own project page states that all
> development has moved to a different Partytown integration under a combined
> namespace. If you are starting fresh, use the actively maintained **Partytown**
> module (`partytown`) instead. The notes below are here for anyone maintaining an
> existing site that already relies on `partytown_drupal`.

**Partytown Drupal** (`partytown_drupal`) integrates the
[Partytown](https://partytown.builder.io/) lazy‑loaded library to relocate
resource‑intensive scripts — analytics, tag managers, other third‑party
JavaScript — into a **web worker**, off the browser's main thread. The goal is to
free the main thread for page rendering, HTML/CSS parsing, and your own code, so
heavy third‑party scripts do not block interactivity. This can help failing Core
Web Vitals. Partytown is developed by qwik.dev and is itself considered
beta‑quality; the module treats it as a working proof‑of‑concept — usable for most
cases, but not polished.

It works by loading selected page scripts through a **locally hosted service
worker**, which is how it moves them onto a separate thread. It provides its own
permission and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (but see the deprecation note above).

There is **no admin settings form** to walk through here — the way you tell
Partytown Drupal to take over a script is described under "How to use it" below.

## How to use it

Once the module is installed and enabled, offloading a script is a matter of
changing its **MIME type** so Partytown handles it instead of the browser loading
it normally. In practice you change the `type` attribute of the `<script>` tags you
want Partytown to take over so they are flagged for the Partytown worker rather
than executed on the main thread. Everything you leave alone continues to run
normally.

Because the module is unsupported, treat any new work here as maintenance only —
and plan to migrate to the maintained **Partytown** module.

## Similar / replacement modules

- **Partytown** (`partytown`) — the actively maintained Partytown integration; the
  recommended choice for new sites.
- **Serviceworker** — a module that implements generic service workers for Drupal.
