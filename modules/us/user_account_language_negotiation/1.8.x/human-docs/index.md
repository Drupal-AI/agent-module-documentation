# User Account Language Negotiation — manual setup guide

**User Account Language Negotiation** (`user_account_language_negotiation`) adds a
single language‑detection plugin — **User account saver** — that *remembers* the
language a logged‑in user switches to. When a user picks a language, the plugin
saves that choice onto their user account (the `preferred_langcode` field), so the
next time they log in the site opens in the language they last chose.

Out of the box, Drupal's language switcher changes the language for the current
request, but core doesn't persist that choice back to the user's account from the
switcher. This module closes that gap: it extends core's user‑based negotiation so
that switching language via a URL prefix (like `/de/...`) — or a `?language=`
query for languages configured without a prefix — both switches the language *and*
writes it to the account. For anonymous visitors it remembers the choice in the
session instead.

The module has **no settings form of its own**. You configure it on Drupal's
standard language‑detection page by enabling the **User account saver** plugin for
the language type(s) you want. The maintainer recommends making it the *only*
enabled plugin for interface‑text detection, so the "remember my language" behavior
is deterministic.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (needs a multilingual site).
2. [Configuration](configuration/index.md) — enabling and ordering the plugin on
   core's detection page, and what it does per request.

## Where it lives in the admin menu

There's no page specific to this module. You enable its plugin at **Configuration
→ Regional and language → Detection and selection**
(`/admin/config/regional/language/detection`) — the same core page where you order
all the other language‑detection methods.

## How to use it

1. Make sure you have a multilingual site with at least two languages and a way to
   switch — for example core's **Language switcher** block.
2. On the Detection and selection page, enable **User account saver** for the
   language type you care about (usually *Interface text*), and — per the
   maintainer's recommendation — make it the only enabled plugin for that type so
   the behavior is predictable.
3. From then on, when a logged‑in user switches language, that choice is saved to
   their account and reused on their next visit.

The [Configuration](configuration/index.md) guide covers the exact steps and the
plugin's per‑request behavior.
