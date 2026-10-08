# Entity Slug — manual setup guide

**Entity Slug** (`entity_slug`) provides generic, configurable **slugging** for any
fieldable entity by adding **Slug** and **Slug Path** field types. A slug is a
clean, URL‑friendly string — lowercased, hyphenated, ASCII — of the kind you want
for URLs, API identifiers or anchors, typically derived from a title or name.

The module is deliberately unopinionated: it does **not** enforce any particular
way to use the slug. What it *does* give you is the field types and the machinery
to fill them. You type text into a Slug field and it can be converted into a
URL‑friendly slug, using extensible plugins — currently a **token replacer** and a
**Pathauto cleaner** — to build the slug from your input. The **Slug Path** field
type goes further, letting you compose several slugs together into a path, and the
module supports some custom tokens for extra functionality.

It depends on the contributed **Pathauto** (`pathauto`) module, which supplies the
string‑cleaning used to produce tidy slugs, and supports Drupal 10 and 11. Since
the module doesn't impose uniqueness itself, one thing worth confirming for your
use case: if your slugs must be unique (a slug used in a URL should not collide),
make sure your workflow handles that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Pathauto dependency.

This module has no central settings form — configuration happens per field, when
you add a Slug or Slug Path field to a bundle, as described in "How to use it"
below.

## How to use it

1. Go to the bundle you want to slug, for example **Structure → Content types →
   *(your type)* → Manage fields**, and **Add field**.
2. Choose the **Slug** field type (or **Slug Path**, to compose multiple slugs into
   a path).
3. In the field's settings, configure how the slug is generated — for example using
   the token replacer or the Pathauto cleaner plugin, and any custom tokens you
   want to apply.
4. On the bundle's forms, editors can type into the field and have the text turned
   into a URL‑friendly slug.

Because the module does not enforce a use for the slug, wire it into your URLs,
identifiers or other features however your site needs — and confirm uniqueness
handling suits you if slugs must not collide.
