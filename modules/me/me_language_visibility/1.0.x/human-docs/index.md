# Language Visibility - Mercury Editor — manual setup guide

**Language Visibility - Mercury Editor** (`me_language_visibility`) adds a paragraph
**behavior** to [Mercury Editor](https://www.drupal.org/project/mercury_editor) that
controls which languages a paragraph is shown in — while still always showing it inside the
editor. On a multilingual site you may want a given paragraph to render only in selected
languages for visitors, yet remain visible to editors so they can work with it. This module
does exactly that: the paragraph renders only in the languages you choose on the front end,
but is always rendered on a Mercury Editor route so it can be edited.

This is especially useful when content is exported and imported programmatically to a
translation service — the paragraph stays present and editable in the interface language,
which is why it works with Mercury Editor where a pure entity‑access approach would not.
(The related [Paragraphs Language Visibility](https://www.drupal.org/project/paragraphs_language_visibility)
module uses the entity‑access subsystem, which hides paragraphs from the editor too, making
it unsuitable for Mercury Editor's visual interface.)

It is a content‑editing / multilingual feature and has no access‑control role of its own —
it governs display, not permissions. It requires the Mercury Editor module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   alongside Mercury Editor.

There is no separate settings form — you turn the behavior on per paragraph type and pick
languages in the paragraph's settings, as described under "How to use it" below.

## Where it lives in the admin menu

The module adds no dedicated admin page. You enable its behavior in the settings for the
paragraph types you want it on (under **Structure → Paragraphs types**), and it takes effect
in the Mercury Editor experience.

## How to use it

1. Install and enable the module and Mercury Editor — see
   [Installation](installation/index.md).
2. Open the settings for a **paragraph type** you want language‑aware, and **enable the
   language‑visibility behavior** for it.
3. When editing content, select the **languages** in which each such paragraph should be
   visible to visitors.
4. The paragraph then renders only in the selected languages on the front end, but remains
   visible on Mercury Editor routes so editors can always see and edit it.
