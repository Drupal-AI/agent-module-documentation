# LB Translation Block Seed — manual setup guide

**LB Translation Block Seed** (`lb_translation_block_seed`) fills the gap between
creating a translation of a Layout Builder page and having a fully editable
translated layout. When a translation is created, it automatically **seeds** the
new translation's layout from the source language — copying the sections and
components, and cloning any inline blocks (and nested Paragraph entities) into
independent, language-specific copies — so editors start from a fully populated
translated page instead of rebuilding it by hand.

Because the cloned inline blocks are independent copies, translators can edit
blocks in the translation without touching the source. Section and component
structure (and UUIDs) are preserved, so the translated layout stays aligned with
the original. Beyond the initial seed, the module adds a **"Push to Translations"**
workflow: while editing an inline block on the source entity, an editor can flag
selected blocks to be re-cloned into one or more chosen translations. It works
with Content Moderation and integrates with **Layout Builder Asymmetric
Translation** (`layout_builder_at`), which provides the per-translation layout
storage this module seeds into. There is also a manual reseed option to rebuild a
translated layout from the latest source.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   its `layout_builder_at` dependency, and set up translatable layouts.

This module has **no configuration page** of its own — the maintainers note that
no additional configuration page is required. Its one setting is a permission
(covered below), and the rest happens automatically or from the Layout Builder
canvas.

## Where it lives in the admin menu

There is no dedicated settings page (`configure` is null). The behaviour is wired
into the translation workflow itself: create a translation and the layout seeds
automatically; edit an inline block and you get the "Push to Translations"
option. The one thing to set in the admin UI is the **push permission**.

## Permission

The module adds one permission, **Push Layout Builder block translations**
(`push layout builder block translations`, marked restricted). Grant it under
**People → Permissions** to the roles that should be allowed to push selected
inline-block updates from the source into translations.

## How to use it

1. Enable Layout Builder Asymmetric Translation (`layout_builder_at`), then this
   module.
2. Enable Layout Builder on the desired content type, enable Content Translation,
   and mark the Layout Builder field as translatable.
3. Grant the push permission to your translator roles.
4. Create a translation of an existing Layout Builder page — the translated layout
   and translated inline blocks are created automatically, ready to edit from the
   Layout Builder canvas.
5. To propagate later source changes, use **Push to Translations** when editing an
   inline block, or the manual reseed option to rebuild a translated layout.
