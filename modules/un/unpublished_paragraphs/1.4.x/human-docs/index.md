# Unpublished Paragraphs — manual setup guide

**Unpublished Paragraphs** (`unpublished_paragraphs`) is a small front‑end helper
for the contrib **Paragraphs** module. On a page built from paragraphs, it clearly
marks any **unpublished** paragraph and adds a floating **"Toggle visibility of
unpublished items"** button so a reviewer can show or hide those draft paragraphs
in place — without opening the edit form. It's a quick way to eyeball
work‑in‑progress content on the real rendered page.

By default an unpublished paragraph is hidden and given a distinctive pink dotted
border with an "Unpublished" corner label when revealed. The toggle button only
appears on pages that actually contain an unpublished paragraph, and clicking it
flips all of them on the page in and out of view at once. The module only touches
non‑admin (front‑end) routes, so your edit screens are left alone.

There's an important subtlety: this module doesn't grant anyone the *right* to see
unpublished paragraphs. Whether an unpublished paragraph is rendered to a given
user at all is decided entirely by core Paragraphs / entity access — the "proper
permission" referred to in its description. This module only marks and toggles the
paragraphs Drupal has already decided to render for that user. If someone can't see
the unpublished paragraph, there's simply nothing to toggle.

It has **no settings page, permission, or Drush command** of its own — it's two
render‑time hooks plus one CSS/JS asset library, active automatically wherever
paragraphs render. It depends on the **Paragraphs** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There's nothing to configure — enabling the module is all it takes.

1. Make sure a user who should preview drafts can actually **view unpublished
   paragraphs** (this is governed by core Paragraphs / entity access, e.g. via a
   role or a moderation workflow — not by this module).
2. As that user, visit a front‑end page that contains one or more unpublished
   paragraphs. Each unpublished paragraph is marked, and a dark **"Toggle
   visibility of unpublished items"** button appears fixed in the bottom‑right
   corner.
3. Click the button to reveal or hide all unpublished paragraphs on the page.

### Restyling it (optional)

There are no settings, but the appearance is easy to override from your theme's
CSS. Target `.unpublished-toggle` for the button and `.paragraph.unpublished` for
the marked paragraphs. The button label comes from a translatable string
(*"Toggle visibility of unpublished items"*), so you can change its wording through
Drupal's interface translation UI, and you can replace the whole asset library via
`libraries-override` in your theme's `.info.yml` if you want full control.
