# Default Content Tools — manual setup guide

**Default Content Tools** (`default_content_tools`) gives you control over the
"default content" that modules and recipes ship — the sample nodes, taxonomy and
other content that some extensions import automatically when you install them or
apply a recipe. It lets you **suppress** that automatic import, or **delete**
default content that was already imported, so you decide what actually ends up on
your site.

Default content is a convenience — a module can arrive with ready‑made example
pages or seed data — but it is not always wanted. On a production build you might
want none of it; on a site you have already built you might want to remove
content a recipe added earlier. Default Content Tools integrates with both
Drupal core's Default Content API and the contributed
[Default Content](https://www.drupal.org/project/default_content) module to make
that possible from the admin UI, without editing code.

It works with core alone; installing the contributed Default Content module (and,
optionally, Recipe Tracker for a fuller log of applied recipes) enhances what it
can see and manage. This is a developer / site‑builder helper — it does not add
front‑end features — and it supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — where to suppress imports and how to
   delete already‑imported default content.

## Where it lives in the admin menu

After enabling, its settings sit at **Configuration → Content Authoring →
Default Content Tools**, where you choose whether to suppress default‑content
imports globally. Deletion of content already imported by a specific module or
recipe is managed from that module's / recipe's entry on the extension pages.
See [Configuration](configuration/index.md) for the details.
