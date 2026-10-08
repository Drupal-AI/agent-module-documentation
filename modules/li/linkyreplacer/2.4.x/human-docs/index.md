# Linky Replacer — manual setup guide

**Linky Replacer** (`linkyreplacer`) converts plain hyperlink URLs in your
content into managed **Linky** entities, replacing each raw `href` with a
reference to a Linky link. If you already use — or want to move to — the
[Linky](https://www.drupal.org/project/linky) module for centralised link
management, this is the tool that migrates your existing, scattered links into
that system.

The payoff is everything Linky gives you, applied to links you've already
published: modifications become centralised (update a URL once, every reference
follows), links can be checked in bulk (for example with Linkychecker), and — when
the **Entity Usage** module is enabled — the created Linky entities carry usage
metadata so you can see where each link is used.

It works on the external HREFs in rich text, turning them into reusable Linky
link entities rather than one-off inline URLs. Linky Replacer requires **PHP
8.1** and provides its own permissions; the Linky entities it creates are ordinary
content, and it has no access-control role beyond its permission. Since it depends
on Linky to do anything, install and set up Linky first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Linky
   and enable.

There is **no standalone settings page** documented for this module — it works
against Linky and (optionally) Entity Usage. Configure and run the replacement as
described below, and grant its permission to trusted users.

## Where it lives in the admin menu

Linky Replacer operates on your content's links, converting them into **Linky**
entities. It provides its own permission (grant it under **People → Permissions**)
and integrates with **Entity Usage** when that module is enabled, so replaced
links carry usage metadata.

## How to use it

1. Make sure **Linky** is installed and configured — Linky Replacer creates Linky
   entities, so Linky must be in place first. Optionally enable **Entity Usage**
   to get usage metadata on the created links.
2. Grant Linky Replacer's permission to the trusted roles that should be allowed
   to run the conversion.
3. Run the replacement so that external HREFs in your rich-text content are
   converted into Linky entities and the raw URLs are swapped for references to
   them.
4. Manage the resulting links centrally in Linky — update a URL once and every
   reference follows — and check them in bulk with a link checker such as
   Linkychecker.
