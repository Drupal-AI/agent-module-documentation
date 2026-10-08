# Class It Up — manual setup guide

**Class It Up** (`classitup`) is a themer's convenience module. It adds CSS classes
to rendered markup based on information Drupal already knows about the content and
its context — so you get useful, machine-safe styling hooks without writing your
own preprocess functions or maintaining templates that differ only in the classes
they add. It follows Drupal's CSS naming guidelines.

At the time of writing it adds classes such as: region machine names as classes on
blocks; the block type as a class on custom blocks; a `page--content-item` class on
pages that show a single full content item (a node); and a
`page--content-item--[content-type]` class carrying the node's bundle. The exact
set of classes it emits is expected to evolve — the maintainers explicitly invite
suggestions — so treat it as a living convenience layer rather than a fixed
contract, and feel free to mine it for preprocess examples you could copy into your
own theme.

The class values are derived from Drupal metadata, so they are always safe machine
names. The module has no access-control role, no permissions, and no settings — it
simply emits classes. It is designed to be depended on by themes (custom or
contrib) that want these hooks available. Note that for adding custom classes to
*fields* specifically, the maintainers recommend the separate **Field Formatter
Class** module rather than Class It Up. It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. Once
enabled, the classes are added automatically to the relevant markup, ready for you
to target in your theme's CSS.

## How to use it

There is nothing to configure. Enable the module, then use your browser's inspector
on a page to see the new classes (for example the `page--content-item` and
`page--content-item--[content-type]` classes on a full node page, or region and
block-type classes on blocks). Write CSS in your theme that targets those classes.
