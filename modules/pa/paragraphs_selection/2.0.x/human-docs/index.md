# Paragraphs Selection — manual setup guide

**Paragraphs Selection** (`paragraphs_selection`) flips the way Drupal decides
which paragraph types a field will accept. Normally, each Paragraphs *field* names
the bundles it allows — so if you have thirty paragraph types spread across
fifteen referencing fields, adding a new type means editing every field that
should accept it. That's easy to forget, and a new type ends up available in four
places and missing from a fifth for weeks until someone notices. This module lets
each **paragraph bundle declare where it may be used** instead. Whether a
"Full-width hero" belongs in a page body is really a property of the hero, not of
every field that might hold one — so declaring it bundle-side makes adding a type
a single edit, and the constraint travels with the thing it describes.

In short, it reverses the entity-reference selection handling that Paragraphs
normally does, letting bundles provide the entity/field/weight configuration that
would otherwise live in each parent field's settings. This suits large content
models and gives you a slightly different config-management approach. A submodule,
**paragraphs_selection_paragraphs_sets_support**, adds compatibility with the
Paragraphs Sets module.

Two things are worth knowing before you rely on it. First, **the two models must
agree**: the field's own allowed-bundles setting still exists, so you need to
establish whether this module *replaces* it, *intersects* with it, or is *applied
on top of* it — a type permitted on one side but not the other is exactly the
confusion the module set out to remove. Second, **this is content modelling, not
access control**: it shapes what an editor is offered in the widget, but it does
not stop a migration, a JSON:API write, or existing content from placing a
paragraph somewhere the rule now forbids. It depends on the **Paragraphs** module
and supports Drupal 9 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   optionally enable the Paragraphs Sets support submodule.

There is **no central settings page**. You declare where a bundle may be used from
the paragraph type / field configuration, as described below.

## How to use it

1. Make sure the **Paragraphs** module is enabled, then enable Paragraphs
   Selection (see [Installation](installation/index.md)).
2. For each paragraph bundle, declare where it may be used — the entity, field,
   and weight configuration that would otherwise have lived in each parent field's
   allowed-bundles setting. This moves the "where can this be placed" decision to
   the bundle itself.
3. Because the field's own allowed-bundles setting still exists, decide and
   document how the two interact on your site (replace / intersect / on top), so
   editors get a consistent set of options in the widget.
4. If you use the **Paragraphs Sets** module, enable the
   **paragraphs_selection_paragraphs_sets_support** submodule so selection rules
   apply there too.

> **Remember:** these rules govern the editing widget, not access. To actually
> prevent a paragraph from being stored somewhere, you still need appropriate
> validation/access at the data layer — migrations and API writes bypass the
> widget entirely.
