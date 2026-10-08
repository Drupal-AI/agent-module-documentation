# Representative Image — manual setup guide

**Representative Image** (`representative_image`) lets you define, per content
type (or other bundle), which image best **represents** an entity — and then
exposes that choice as a **token**. The token is the whole point: once one image
per node is settled, everything that consumes tokens — Metatag `og:image`
patterns, Pathauto, mail templates, Views rewrites, RSS feeds — can ask for the
representative image without knowing anything about your field structure.

The problem it solves comes up whenever something *outside* the node has to pick
one image. A node might have a hero image, an inline body image, a media
reference, and a fallback default, and every consumer ends up guessing which to
use — often with different answers, so a page shares one image on social media and
shows another in a listing. Representative Image makes that decision **once**, per
content type, with a defined behaviour for what to do when there is no image, and
publishes the result consistently.

You configure it by adding a **Representative Image** field to a bundle and
telling it which underlying image (or media) field to draw from, plus what to do
when no image is present (for example, a site-wide default). It supports plain
image fields and Media references alike, depends only on core, and targets
`^10.3 || ^11` (the release carries the legacy `8.x-1.5` version string).

> **Worth pairing with alt text.** A representative image with no alt text is
> still an accessibility problem. Modules such as
> `imagefield_default_alt_and_title` or `auto_alter` (documented elsewhere in this
> knowledge base) address that other half.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add and configure the Representative
   Image field on your content types, and use its token.

## Where it lives in the admin menu

Representative Image adds no central settings page. Its configuration lives with
each content type, on **Structure → Content types → *(type)* → Manage fields**
(where you add the Representative Image field) and **Manage display** (where you
control how it renders). See [Configuration](configuration/index.md).
