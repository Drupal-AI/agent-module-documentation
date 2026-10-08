# Paragraphs Features — manual setup guide

**Paragraphs Features** (`paragraphs_features`) adds a set of editor-experience
enhancements to the Paragraphs widget — add-in-between buttons, a delete
confirmation step, a single-action button, advanced drag-and-drop, and a
CKEditor 5 "Split paragraph" tool. It layers usability on top of the contrib
Paragraphs module without replacing it.

Most of the features are toggled **per field**, through the Paragraphs widget's
third-party settings on a form display. **Add in between** inserts "+ Add" buttons
between existing paragraphs (with a configurable number of type links) so new
items land exactly where you want them; **Delete confirmation** adds a confirm step
before a paragraph is removed; **Show drag & drop** exposes Paragraphs' advanced
drag-and-drop reorder UI; and a collapse-all toggle is available too. Because they
are set per widget, different paragraph fields can have different feature sets.

A single **global** setting reduces the actions drop-down to a plain button
whenever only one action is available, saving a click across the whole site. And
the module ships a CKEditor 5 **Split paragraph** toolbar button that lets an editor
split a rich-text paragraph into two at the cursor. It works by altering the
Paragraphs widget through field-widget hooks and attaching JavaScript — it adds no
new entity types or permissions, and stores its options as ordinary configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Paragraphs.
2. [Configuration](configuration/index.md) — the one global setting, the per-field
   widget features, and how to add the Split paragraph button to a text format.

## Where it lives in the admin menu

- The **global** setting is at **Configuration → Content authoring → Paragraphs
  features** (`/admin/config/content/paragraphs_features`).
- The **per-field** features live on **Structure → Content types → *(type)* →
  Manage form display**, on the gear icon of the Paragraphs widget.
- The **Split paragraph** button is added on **Configuration → Content authoring →
  Text formats and editors** (`/admin/config/content/formats`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a content type with a Paragraphs field, open **Manage form display**, click
   the gear icon on the Paragraphs widget, and switch on the features you want
   (add in between, delete confirmation, drag & drop, collapse all).
3. Optionally turn on the global one-click button setting.
4. To give editors the split tool, add the **Split paragraph** button to the
   CKEditor 5 toolbar of the text format used inside your paragraphs.

See [Configuration](configuration/index.md) for the details of each option.
