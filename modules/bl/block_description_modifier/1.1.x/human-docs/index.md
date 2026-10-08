# Block Description Modifier — manual setup guide

**Block Description Modifier** (`block_description_modifier`) improves how
**inline blocks in Layout Builder** are labelled, so they're easier to tell apart
while you're building a layout. When you add several inline blocks to a page,
Layout Builder's default descriptions can be vague or repetitive; this module
gives you control over the admin label/description shown for those blocks.

It is a site-building convenience aimed at editors and layout builders — it does
not change what visitors see, only how blocks are identified in the Layout
Builder interface. It depends on core's Block content, Layout Builder, and Inline
Entity Form modules, and provides its own permission so this behaviour can be
delegated. It targets Drupal 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module works inside **Layout Builder**, which you reach from a content
type's or entity's **Manage display** tab (for example
`/admin/structure/types/manage/{type}/display`) once Layout Builder is enabled
for that display. Its effect appears when you add or edit an inline block within
a layout.

## How to use it

1. Make sure Layout Builder is enabled for the content type or entity display you
   want to work with.
2. Grant the permission this module provides (at **People → Permissions**) to the
   roles that build layouts.
3. Edit a layout and add or configure an **inline block**. The block's
   description/label is now shown in a clearer, configurable way, making inline
   blocks easier to identify as you assemble the layout.

There is no central settings page — the behaviour applies within the Layout
Builder editing experience.
