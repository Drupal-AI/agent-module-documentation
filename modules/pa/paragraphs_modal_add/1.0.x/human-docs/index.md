# Paragraphs Modal Add — manual setup guide

**Paragraphs Modal Add** (`paragraphs_modal_add`) is a small editing-experience
tweak for the Paragraphs module: it lets editors **add a paragraph through a modal
dialog** instead of the default inline add flow. Inspired by the Paragraphs Modal
Edit module, it moves the "add paragraph" action into a Drupal modal, which keeps
the edit form tidier when a paragraph field offers many types to choose from.

It only affects how paragraphs are added — the paragraph types, fields, and the
content itself are unchanged. There is nothing to configure and no access-control
role; enabling the module is all it takes. It depends on the **Paragraphs**
module and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. The modal add behavior is
active as soon as it is enabled.

## How to use it

1. Make sure the **Paragraphs** module is enabled and you have a Paragraphs field
   on a content type.
2. Enable Paragraphs Modal Add (see [Installation](installation/index.md)).
3. Edit a piece of content and add a paragraph — the add action now opens in a
   modal dialog. Pick the paragraph type in the dialog and continue editing as
   usual.
