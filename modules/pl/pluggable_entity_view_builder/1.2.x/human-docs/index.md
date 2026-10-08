# Pluggable Entity View Builder — manual setup guide

**Pluggable Entity View Builder** (`pluggable_entity_view_builder`) — "PEVB" for
short — moves entity rendering out of preprocess functions and Twig templates and
into **PHP classes: one class per bundle, a method per view mode**. It comes from
[Gizra](https://www.gizra.com), who rely on it heavily in their Drupal‑starter,
and it is deliberately opinionated.

Drupal's normal theme layer spreads a bundle's rendering across several places — a
preprocess function prepares variables, a template arranges them, per‑field
formatters render each field, and an alter hook may adjust any of it. That is four
files in three directories with no type checking, no IDE autocompletion, and
nothing an editor can follow. PEVB inverts that: the logic that decides what a
card, teaser, or full page shows lives in one injectable, typed, testable class
that returns an ordinary render array.

Two consequences are worth understanding **before** you adopt it:

1. **Cache metadata becomes the class's responsibility.** A render array built in
   PHP carries only the cache contexts, tags, and max‑age you give it — the theme
   layer will not supply them for you. A component that varies by user (or by
   anything else) must declare that itself, or it will be cached incorrectly.
2. **It is a team decision, not a per‑feature one.** A codebase with half its
   rendering in templates and half in view builders is harder to work in than
   either approach alone. Adopt PEVB consistently across the project, or not at
   all.

The module ships example submodules — a general example and a Paragraphs example —
so you can see the approach working quickly before writing your own view builders.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally turn on an example submodule.

There is **no configuration page** for this module — it has no settings form. You
work with it in code, described in "How to use it" below.

## How to use it

PEVB is a developer tool. The quickest way to see it in action is the bundled
example:

1. Enable the **Pluggable Entity View Builder Example** submodule and clear caches
   so the new settings take effect.
2. Create an Article node with a title, body, some tags, and an image. Nothing
   changes yet, because the example has not overridden core's default Node view
   builder.
3. Enable the override setting and reload the node — its theming now comes from
   the example's PHP view‑builder class instead of core templates.
4. For Paragraphs, enable the **Pluggable Entity View Builder Paragraphs
   Example** submodule; the Article type gains a Paragraphs field, and you can
   create Paragraphs and see them rendered from classes.

For your own bundles you define a view‑builder class per bundle with a method per
view mode, inject whatever services it needs through the constructor, attach the
correct cache metadata, and return a render array.
