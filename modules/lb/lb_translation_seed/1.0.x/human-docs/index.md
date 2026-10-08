# Layout Builder Translation Seed — manual setup guide

**Layout Builder Translation Seed** (`lb_translation_seed`) automatically
populates the Layout Builder layout of a newly created translation from a source
language. When an editor creates a translation of a Layout Builder–enabled entity
(such as a node), the module copies the source language's sections, components,
and inline blocks into the new translation — so instead of a blank layout, the
editor gets a starting layout to customise. It fills the gap between "create
translation" and "have a layout ready to edit," removing the manual rebuild step.

After the initial seed, each translation lives **independently** — you continue
editing per-translation layouts with **Layout Builder Asymmetric Translations**
(`layout_builder_at`), which this module depends on for its per-translation
storage. Seeding is driven by **configurable rules** for source → target language
pairs (optionally filtered by entity type and bundle), so several rules can
coexist on one site — for example `en → en-us`, `en → en-gb`, and `fr → fr-ca`.
Every cloned component gets a freshly generated UUID, and inline blocks are
deep-cloned so editing translated content never bleeds back into the source.

Unlike a module that requires an editor to tick a checkbox, seeding happens
automatically on the translation's first save when a matching rule exists. A
manual **"Reseed layout from source"** button (permission-gated) lets editors
re-baseline a translation from the latest source when needed. The module requires
**Drupal 11.1+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and
   `layout_builder_at`, and make the Layout field translatable.
2. [Configuration](configuration/index.md) — define the seeding rules and grant
   the permissions.

## Where it lives in the admin menu

Its settings form lives at **Configuration → Regional & language → Layout Builder
Translation Seed** (`/admin/config/regional/lb-translation-seed`), where you add
and manage seeding rules. See [Configuration](configuration/index.md) for the
walkthrough.

## How to use it

1. Enable `layout_builder_at` and this module.
2. Enable Layout Builder (with overrides) on each bundle whose layouts should be
   translatable, and mark the Layout field translatable in the content-language
   settings.
3. Add one or more seeding rules on the settings form.
4. Create or translate a node in a configured target language — its layout is
   populated automatically from the source.
