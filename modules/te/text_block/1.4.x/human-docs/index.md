# Text Block — manual setup guide

**Text Block** (`text_block`) provides a block whose text is stored in
**configuration** rather than as a content entity. That single difference is the
whole point: because the text lives in config, it can be exported with
`drush config:export`, committed to version control, reviewed in a merge
request, and imported onto staging and production the same way as any other
configuration.

Drupal's own answer to "a block with some text in it" is a custom (content)
block, and that is the right answer when editors own the wording. It is the
wrong answer when developers own it: custom blocks are *content*, so they never
appear in a config export, do not travel through `drush config:import`, and have
to be recreated by hand or shipped as default content on every environment. Text
Block inverts that. Each block is a plugin whose body text is part of the
block's configuration, validated by the module's config schema, so it appears in
`block.block.*` config and moves with your normal config workflow. This makes it
a good fit for developer-owned, fixed snippets — a legal disclaimer, a footer
message, a site notice — that you want under source control and identical across
environments. It can also be used inside Layout Builder.

The module is deliberately tiny: a block plugin, a schema file and tests, with
core's **Block** module as its only dependency. It has no routes, no services,
and no settings form of its own.

There are two things worth being explicit about. First, editing a Text Block's
text means editing block configuration, which is governed by the
**Administer blocks** permission — there is no separate per-block editorial
permission, so this is not the tool for text that editors need to own. Second,
because the text is configuration, a `drush config:import` will **overwrite** any
change someone made through the UI on that environment. If editors need to change
the wording freely, use a core custom block instead; Text Block deliberately
trades that flexibility for deployability.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Text Block does not add a settings page. Instead it adds a new block type you
place through the normal block layout:

1. Go to **Structure → Block layout** and choose to place a block in a region.
2. Pick the **Text Block** from the list of available blocks.
3. Enter your text (with a text/filter format) in the block's configuration and
   save.

The block now renders your text, and — unlike a custom content block — its
wording travels with your configuration export. Who can see the block is
whatever the block layout grants; who can edit its text is anyone with the
**Administer blocks** permission.
