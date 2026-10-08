# Easy Social — manual setup guide

**Easy Social** (`easy_social`) gives your readers one-click social sharing
buttons without you having to juggle a separate module for every network or paste
third-party JavaScript snippets by hand. You enable one module, choose which
networks appear, and Easy Social handles the widgets in a single place. Out of
the box it includes **Email, X/Twitter, Facebook, Pinterest, and LinkedIn**.

The share buttons can appear in several ways: as a **block**, automatically
**attached to nodes** (and comments), or as a **Views field** — so you can show
them on articles, on a blog, or in a listing view. A per-network settings form
lets you decide which widgets are active and how they behave, all gated behind the
`administer easy_social` permission. Developers can add their own widget types via
`hook_easy_social_widget()`, and a small `easy_social_example` submodule shows a
working setup.

One thing worth understanding before you switch it on: the official network
widgets are **third-party scripts that can track visitors as soon as the page
loads**, before anyone clicks anything. Under privacy regimes like GDPR that makes
an always-on share set something you usually need consent for — so plan to gate
the widgets behind your consent manager, or restrict them to view modes where
that is handled. See [Configuration](configuration/index.md) for the details and a
privacy-friendlier alternative.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose your networks, place the
   widgets, and handle the privacy considerations.

## Where it lives in the admin menu

Once enabled, Easy Social's settings form sits at **Configuration → Web services
→ Easy Social** (`/admin/config/services/easy-social`), and it requires the
**Administer Easy Social** (`administer easy_social`) permission.
