# LocalGov Utilities — manual setup guide

**LocalGov Utilities** (`localgov_utilities`) is a small collection of editorial
convenience helpers used across the **LocalGov Drupal** distribution. It is not a
single feature so much as a home for little utilities the distribution relies on —
the kind of thing that smooths the editor's day rather than adding a headline
capability.

Its main offering today is the **LocalGov Character Counter** submodule
(`localgov_char_count`), a friendly wrapper around the contrib **Textfield Counter**
module. It makes it easy to add live character‑count feedback to the **title** and
**summary** fields of LocalGov content types, so editors can see how many characters
they have used (and how many remain) as they type — helping keep titles and summaries
within recommended lengths for good search results and page design.

The base module is marked *hidden*: it is a distribution support module, normally
brought in by the distribution's dependencies rather than something you browse to and
switch on directly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   character‑count submodule.
2. [Configuration](configuration/index.md) — the LocalGov Character Counter settings
   form, field by field.

## Where it lives in the admin menu

The base module adds no admin page. The **LocalGov Character Counter** submodule
provides a settings form at **Configuration → Content authoring → LocalGov Character
Count** (`/admin/config/content/localgov-char-count`). That is where you set the
counts and choose which fields to apply them to — see
[Configuration](configuration/index.md).

## How to use it

1. Install the module and enable the **`localgov_char_count`** submodule (see
   [Installation](installation/index.md)).
2. Go to the **LocalGov Character Count** settings form, set the maximum lengths and
   the message text, and choose the title/summary fields to apply counting to.
3. Edit any content of a chosen type — as editors type in the title or summary, a
   live character count appears beneath the field.

Being part of the LocalGov Drupal distribution, it is designed to run on a LocalGov
site alongside the LocalGov content types.
