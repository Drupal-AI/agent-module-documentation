# Paragraphs Sets Plugins UI — manual setup guide

**Paragraphs Sets Plugins UI** (`paragraphs_sets_plugins_ui`) is a companion to
the [Paragraphs Sets](https://www.drupal.org/project/paragraphs_sets) module. A
"paragraph set" is a predefined group or template of paragraphs — a ready‑made
arrangement an editor can drop into a field in one click instead of adding each
paragraph by hand. Normally you define those sets in code or configuration files;
this module adds a **user interface** so you can create and save them straight
from the admin UI instead.

In practice it lets site builders and editors assemble a group of paragraphs and
save it as a reusable **Paragraphs Set** entity. You can build **structure‑only**
sets (just the skeleton of paragraph types) or **structure‑plus‑content** sets
that also carry the text, links, and images you entered, so a whole starter
layout can be reused across pieces of content.

It changes only how paragraph sets are *defined* — it does not alter your content
or affect access control. It depends on the Paragraphs Sets module, which in turn
depends on Paragraphs.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Paragraphs Sets dependency.

There is **no dedicated settings page** for this module — it has no configuration
form of its own. You use it directly from the paragraphs editing experience,
described in "How to use it" below.

## How to use it

Once the module is enabled, the ability to save paragraph sets from the UI becomes
available wherever you edit a Paragraphs field:

1. Make sure Paragraphs Sets is set up on the field you are working with (its set
   selector appears above your Paragraphs field).
2. Build the arrangement of paragraphs you want to reuse — add the paragraph
   types, and, if you want a content‑carrying set, fill in their text, links, and
   images.
3. Use the module's UI to **save** that arrangement as a Paragraphs Set entity,
   choosing whether to keep only the structure or the structure together with the
   content you entered.
4. From then on, that saved set appears in the Paragraphs Sets selector, ready to
   be inserted into any content using the same field.
