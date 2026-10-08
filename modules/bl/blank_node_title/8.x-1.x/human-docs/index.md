# Blank Node Title — manual setup guide

**Blank Node Title** (`blank_node_title`) lets editors save a node without typing
a title. On save, the module fills in a generated title for you, so Drupal's
built-in "Title field is required" rule no longer blocks content creation.

This solves a real friction point for content types where a meaningful title isn't
natural — log entries, imported items, quick-capture or journal-style content. You
turn it on for just the content types that need it, and everything else keeps
Drupal's normal required-title behavior.

It works through two hooks. On the node add/edit form it relaxes the required-title
constraint for the content types you've selected. Then, when a node is saved with
an empty title (or a title that's just a `-`), it sets the title to
`"<content-type> - <long-formatted save time>"`, using the site's "long" date
format. So admin listings always have something to show, even when the editor left
the field blank.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds a single settings form at **Configuration → Content authoring →
Blank Node Title** (`/admin/config/content/blank-node-title`), which requires the
**Administer site configuration** permission.

## How to use it

1. After enabling, open **`/admin/config/content/blank-node-title`**.
2. Tick the content types whose title should be optional.
3. Save.

From then on, editors can leave the title empty when creating or editing those
content types, and the module supplies a generated fallback title on save.
Un-tick a content type at any time to restore Drupal's normal required-title
behavior for it.

> **Note:** on newer Drupal core versions the settings form still references the
> deprecated `entity.manager` service, which may produce a deprecation warning.
