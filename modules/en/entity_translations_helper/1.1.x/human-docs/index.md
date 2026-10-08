# Entity translations helper — manual setup guide

**Entity translations helper** (`entity_translations_helper`) is a helper module
for working with entity translations, aimed mainly at developers and site builders
who hit the awkward parts of Drupal's translation API. Translated entities are one
of the places where correct Drupal code and *obvious* Drupal code diverge:
`Node::load()`, for instance, returns the entity in its **default** language rather
than the current one, so code that loads a node and reads a field can quietly serve
the wrong language in a block, a Views field, or a custom controller. This module
packages the decisions that get that right — checking whether a translation exists
before asking for it, choosing what to do when it doesn't, and remembering that a
translation is a distinct object whose changes must be saved.

Beyond the code helpers, it also has an **editor‑facing** side. It can expose the
add/edit form of related translation entities in a **modal** on the main entity
form — useful for non‑translatable entity reference fields that point at
translatable entities, and when you use core's "Hide non‑translatable fields on
translation forms" option. And on content creation it notifies the editor which
language they are working in, suggesting they switch if needed. That notice appears
on translatable, non‑modal forms without a language selector element, and currently
supports **nodes, taxonomy terms, and media**.

It depends on core's **Content Translation** module and has essentially no
configuration UI — it is infrastructure that other code and forms build on. The one
thing to establish before relying on the code helpers is **which fallback behavior
you want** when a translation is missing (return the default language, or return
nothing) — that choice belongs to your calling code, not to a helper's default.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside core Content Translation.

There is **no configuration page** for this module — it provides developer helper
utilities and form enhancements rather than a settings form.

## How to use it

Enable the module on a multilingual site. Its editor‑facing features then work
where they apply — the modal add/edit of related translation entities on a main
entity form, and the current‑language notice on node, taxonomy term, and media
creation forms. For custom code, use its helper utilities in place of hand‑rolled
translation logic (loading in the current language, checking `hasTranslation()`
before `getTranslation()`, and saving translated entities correctly), deciding the
missing‑translation fallback in your own code.
