# LocalGov Core — manual setup guide

**LocalGov Core** (`localgov_core`) is the foundational helper module for the
[LocalGov Drupal](https://localgovdrupal.org/) distribution. Rather than one
feature, it does two jobs: it pulls in the shared set of contrib modules that a
LocalGov build relies on (field_group, linkit, metatag, pathauto, token, and
friends), and it provides a handful of cross-cutting building blocks that the rest
of the distribution — and your own site — can use.

The headline building block is the **Page Header block**, which derives a page
title, subtitle, and lede from the current route's entity or View, and fires an
event so other modules can override the title, subtitle, lede, visibility, or cache
tags. Alongside it the module ships a "Powered by LocalGov Drupal" block, a default-
block installer that places modules' default blocks into theme regions, a
field-rename helper for update hooks, LocalGov-specific Linkit autocomplete
matchers, a read-only entity-reference "labels" widget, and a file-link preprocess
that appends the file type and size to document links. It also declares some shared
social/contact field storages and a `localgov_card` view mode.

It has no settings form and no permissions of its own. Most of it is machinery that
other modules build on; the parts you interact with directly are the Page Header
block, the submodules, and the shared fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the sizeable
   dependency set), enable the module, and choose submodules.
2. [Configuration](configuration/index.md) — the Page Header block, the submodules,
   and the shared fields the module provides.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The pieces you place or
manage appear in the usual core locations — the **Page Header** and **Powered by
LocalGov Drupal** blocks under **Structure → Block layout**, the widgets and view
mode on the relevant **Manage form/display** tabs, and submodule features in their
own right. See [Configuration](configuration/index.md).
