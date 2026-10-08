# ai.txt — manual setup guide

**ai.txt** (`aitxt`) generates and lets you edit an `ai.txt` file for your site —
the emerging convention (analogous to `robots.txt`) for declaring how AI
crawlers and scrapers may use your content. The module serves the file
dynamically and gives administrators a web form to edit its contents per site, so
you don't have to hand‑place a static file in the docroot.

Like `robots.txt`, an `ai.txt` file is **advisory**: it declares your intent to
AI crawlers, but compliance is up to each crawler. The module publishes the
declaration; it does not block anyone. It has no access‑control role — it simply
generates a text file from what you type in the admin UI.

Use it to state, in one place, how you want AI systems to treat your site's
content, and to update that statement over time without editing files on disk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — edit the `ai.txt` contents from the
   admin settings form.

## Where it lives in the admin menu

The settings form is registered at `aitxt.admin_settings_form` (under
**Configuration**), and the generated file is served at your site's `/ai.txt`
path. The module provides its own permission to control who may edit the
contents.

## How to use it

1. Enable the module.
2. Open the ai.txt settings form and write your AI‑crawler directives.
3. Save — the `/ai.txt` file is generated from what you entered and served to any
   crawler that requests it.
