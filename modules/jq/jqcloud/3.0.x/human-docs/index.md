# jQCloud — manual setup guide

**jQCloud** (`jqcloud`) displays your **taxonomy terms as a word cloud** — a
cloud‑like arrangement of tags rendered with the jQCloud jQuery plugin, where more
frequently used terms appear larger. It's a nice way to give visitors a visual entry
point into the topics on your site.

The module has one clear job, done through **blocks**: for each taxonomy vocabulary
on your site it generates a block named *"jQCloud with [VOCABULARY_NAME]
vocabulary"*, which you place wherever you want the cloud to appear. Term content
follows normal taxonomy access — the module simply renders it — so it has no
access‑control role of its own. It depends on core's **Block** module.

One setup detail to be aware of: jQCloud relies on the third‑party **jQCloud
JavaScript library**, which you download and place in your site's `/libraries`
directory (with a small file‑renaming step). The installation guide walks through
this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, add the jQCloud
   library, and enable it.

This module has **no central settings form**. You use it entirely by placing the
per‑vocabulary blocks it generates — see "How to use it" below.

## Where it lives in the admin menu

jQCloud adds no configuration page. You work with it from the **Block layout** page
at **Structure → Block layout** (`/admin/structure/block`), where its per‑vocabulary
blocks are available to place.

## How to use it

1. Make sure you have at least one **taxonomy vocabulary** with terms (create one at
   **Structure → Taxonomy** if needed).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. In the region where you want the cloud, click **Place block** and choose the block
   named **"jQCloud with [VOCABULARY_NAME] vocabulary"** for the vocabulary you want
   to display.
4. Configure the block's visibility and region as usual, then save the block layout.

The chosen vocabulary's terms will render as a word cloud in that region.
