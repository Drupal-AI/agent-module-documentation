# Favicons — manual setup guide

**Favicons** (`favicons`) lets you upload a single source image and have the module
generate all the favicon and app‑icon variants a modern site needs, then add the
markup and web manifest to the page head automatically. Instead of hand‑crafting
several icon files and hand‑writing `<link>` tags, you upload one PNG and the
module does the rest.

From your source image it generates a 180×180 `apple-touch-icon`, a `favicon.svg`,
a 96×96 icon, and a `site.webmanifest`, and it injects the corresponding icon and
manifest references into the `<head>` of every page. It runs late in the head hook
order so its tags take precedence.

Favicons is a theming/SEO helper: the icons it produces are static assets, and the
module has no content or access role beyond a single administrative permission that
gates its settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and clear the cache so it takes effect.
2. [Configuration](configuration/index.md) — upload your source icon in the
   settings form.

## Where it lives in the admin menu

Favicons adds a settings form (reachable from the module's entry on the **Extend**
page, or under **Configuration**), gated by the module's own administrative
permission. See [Configuration](configuration/index.md) for what to do there.
