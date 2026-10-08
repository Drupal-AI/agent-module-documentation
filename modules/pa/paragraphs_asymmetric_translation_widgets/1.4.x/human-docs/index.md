# Paragraphs Asymmetric Translation Widgets — manual setup guide

**Paragraphs Asymmetric Translation Widgets**
(`paragraphs_asymmetric_translation_widgets`) lets each language of a translated
entity hold a completely different set of paragraphs. Out of the box, the
Paragraphs module translates *symmetrically*: every translation of a node shares
the same paragraph items in the same order, and translators can only edit the
field values inside each paragraph — they cannot add, remove, or reorder
paragraphs per language. This module removes that restriction.

With it enabled and configured, a translator can build a page with three promo
paragraphs in English but only one in German, reorder sections differently per
language (video block first in Japanese, last in English), or delete a paragraph
in one translation while keeping it in the source. When a new translation is
created, the module automatically duplicates the source language's paragraphs as
a starting point, and from then on each language's paragraphs can diverge freely.

There is **no admin settings form**. You turn the behaviour on entirely by
choosing the module's widget on a content type's form display, on a *translatable*
paragraphs reference field. It ships a legacy inline widget (**Paragraphs Legacy
Asymmetric**) and, for the modern stable Paragraphs widget, it swaps in an
asymmetric variant automatically once the field is translatable. It depends on
the **Paragraphs** module (1.15+) and core's **Content Translation**.

> **Important migration note:** the maintainer warns that switching an existing
> site's fields from non-translatable to translatable can soft-unlink paragraphs
> that were already attached. Plan any such change to a live site carefully and
> test it first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated settings page. The behaviour is enabled per field on
**Structure → Content types → *(your type)* → Manage form display**.

## How to use it

1. Make sure your site has multiple languages and **Content Translation** is
   enabled.
2. On the content type, mark the Paragraphs reference field (an *entity reference
   revisions* field targeting paragraphs) as **translatable** — this is what
   engages the asymmetric behaviour.
3. Go to **Manage form display** for that content type and set the paragraphs
   field's widget:
   - Choose **Paragraphs Legacy Asymmetric** for the legacy inline widget, or
   - Keep the modern stable **Paragraphs** widget — the module automatically swaps
     it to its asymmetric version when the field is translatable.
4. Now, when translators open a translation, they get their own independent set of
   paragraphs to add to, delete from, and reorder.
