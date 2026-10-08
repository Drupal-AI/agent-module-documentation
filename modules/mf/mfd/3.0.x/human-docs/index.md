# Multilanguage Form Display — manual setup guide

**Multilanguage Form Display** (`mfd`) makes editing translated content easier by
bringing every language's translatable fields onto a **single node form**. Normally,
translating content in Drupal means saving the source, then switching to a separate
translation edit page for each language, one at a time. This module supplies a field
type/widget that, when added to a translatable bundle, exposes the other languages'
translatable inputs right there on the node form — so an editor fills in all
languages at once and saves them together in a single submit.

It works especially nicely with a multi-column form layout: using the
`field_layout` module you can put the default fields in one column and the
Multilanguage Form Display field in a second, giving a side-by-side editing
experience. Under the hood, after the entity saves, a submit handler writes the
collected per-language values into each existing translation.

It requires core's **Content Translation**, **Language**, and **Locale** modules.
Two permissions gate its behaviour: **`edit multilingual form`** (who may use the
inline multilingual editing) and **`show multilingual translate table`** (an
optional translation table on node view). Validation guards keep the setup coherent —
you can't add the field to a non-translatable bundle, can't disable translation on a
bundle that has the field, and can't mark the field itself translatable.

> **Known issue — core patch required.** Because of a bug in core's `WidgetBase`
> class, this module needs a core patch to work; without it you'll see an
> "Illegal string offset '_original_delta'" warning. See the module's project page
> and Drupal core issue
> [#2991986](https://www.drupal.org/project/drupal/issues/2991986) for the patch and
> how to apply it with Composer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (and the required
   core patch) and enable the module and its translation dependencies.

There is **no configuration page** — you add the field to a bundle's form and grant
the permissions, described in "How to use it".

## Where it lives in the admin menu

The module adds no settings page. You use it from **Structure → Content types →
*(your type)* → Manage fields / Manage form display**, and you grant its permissions
at **People → Permissions**.

## How to use it

1. Enable the module and apply the required core patch (see
   [Installation](installation/index.md)).
2. Ensure the target content type is **translatable** (Content Translation enabled
   for that bundle).
3. Add a **Multilanguage Form Display** field to the bundle via **Manage fields**.
   (You cannot add it to a non-translatable bundle — validation prevents it.)
4. Optionally arrange the form into columns with `field_layout` for side-by-side
   editing.
5. Grant **edit multilingual form** to the roles that should edit all languages
   inline, and optionally **show multilingual translate table** for the on-view
   translation table.
6. Edit a node: the other languages' translatable fields now appear on the one form,
   and saving writes all translations at once.
