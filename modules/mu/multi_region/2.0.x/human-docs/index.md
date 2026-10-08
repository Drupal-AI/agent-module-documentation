# Multi Region — manual setup guide

**Multi Region** (`multi_region`) lets you **group your site's languages into
geographic regions**. On a multilingual Drupal site you might have several
languages that really belong together as a "region" — for instance a group of
European languages, or a set of languages for the Americas. Multi Region gives you
a way to define those regions, assign languages to each, and then present them
together.

Its most visible feature is a **block** that lists the regions and the languages
belonging to the selected one, so visitors can choose their region and then their
language. You can also use the region grouping programmatically if you are
building something more custom. The module depends on core's **Language** module,
since regions are built on top of your configured site languages.

Setting it up is straightforward: add your languages as usual, define your regions
and assign languages to each on the module's admin screen, then place the block (or
use it in code). It provides its own permission for who may manage regions. Note
that regions here are about grouping languages for presentation — if you plan to
use them to segment content, check that the grouping composes sensibly with your
content access and publishing setup.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its Language dependency.
2. [Configuration](configuration/index.md) — add languages, define regions, assign
   languages, and place the block.

## Where it lives in the admin menu

The regions are managed at **Configuration → Regional and language → Regions**.
Languages themselves are managed nearby at **Configuration → Regional and
language → Languages** (`/admin/config/regional/language`), and the region block is
placed from **Structure → Block layout**.
