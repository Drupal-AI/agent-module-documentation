# Inline Block Title Automatic - Symmetric Translation — manual setup guide

**Inline Block Title Automatic - Symmetric Translation**
(`inline_block_title_automatic_st`) is a small **glue module** that makes two
other modules work together smoothly. It bridges
[Inline Block Title Automatic](https://www.drupal.org/project/inline_block_title_automatic),
which derives a Layout Builder inline block's admin title automatically, and
[Layout Builder Symmetric Translation](https://www.drupal.org/project/layout_builder_st),
which adds a translate form for inline blocks.

Used together without this bridge, the translate form still shows the block-title
(info) field and can raise a "duplicate block title" validation error when an
editor tries to translate an inline block — awkward, since the whole point of
Inline Block Title Automatic is that editors should not have to invent titles. This
module fixes that: when it detects the inline-block *translate* form, it hides the
title field (supplying a default label if one is empty) and skips the
duplicate-title validation, so translating a block just works.

It is completely **zero-configuration**. There are no settings, routes, or
permissions — install it alongside both dependencies and it takes effect
automatically. Like Layout Builder Symmetric Translation itself, it is a stopgap
until Layout Builder translation lands in Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its two
   dependencies with Composer, and enable it.

There is **no configuration page** for this module — it has no settings form and
takes effect automatically once its dependencies are enabled.

## Where it lives in the admin menu

This module adds no admin page. It works invisibly on the inline-block translate
form provided by Layout Builder Symmetric Translation — you will simply notice
that translating an inline block no longer asks for a title or throws a
duplicate-title error.
