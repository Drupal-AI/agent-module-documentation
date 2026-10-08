# FAQ Block — manual setup guide

**FAQ Block** (`faq_block`) provides a configurable block for building a Frequently
Asked Questions section as an expand/collapse **accordion**. A site builder adds as
many question/answer pairs as needed — each answer authored in the rich‑text
editor — gives the section an optional title and intro description, picks a colour for
the toggle icon, and places the block. The front end renders it as a tidy accordion,
so visitors click a question to reveal its answer.

It is a lightweight alternative to building a full FAQ content type: the questions and
answers are stored as **block configuration**, which means they are exportable with
the rest of your configuration. You can place multiple independent FAQ blocks on
different pages, each with its own content and styling. The block works both in the
classic Block Layout and inside Layout Builder.

The markup and styles are overridable — the module renders through a `faq_block` Twig
template you can copy into your theme, and its accordion JavaScript and CSS are
attached automatically. Files embedded in answers are tracked for file usage and
promoted from temporary to permanent when you save.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the block configuration form, field by
   field, and how to place the block.

## Where it lives in the admin menu

FAQ Block adds no standalone settings page. All of its configuration happens on the
**block** itself: place the *FAQ Block* from **Structure → Block layout**
(`/admin/structure/block`) or from a **Layout Builder** section, and fill in its
configuration form when you add it.
