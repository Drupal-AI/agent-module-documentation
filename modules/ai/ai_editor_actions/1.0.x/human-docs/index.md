# AI Editor Actions — manual setup guide

**AI Editor Actions** (`ai_editor_actions`) adds AI-powered text actions to the
**CKEditor 5** rich-text editor. With it, an author can select text in the body
field and ask the AI to **rewrite**, **summarize**, or **translate** the
selection right inside the editor — no copy-pasting into a separate tool.

It builds on the Drupal AI module: the selected text is sent to whatever AI
provider you have configured, and the result comes back into the editor. Because
this is real generated text, authors should **review** the output before
publishing rather than trusting it blindly.

There are a couple of things to be aware of. The selected text is an **egress** —
it leaves your site and is processed by the AI provider under its terms, so
confirm that's acceptable for the content being edited. And the provider's API
key is a secret stored through the AI module's Key configuration, never pasted
into plain settings.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its CKEditor 5 / AI dependencies.

## Where it lives in the admin menu

AI Editor Actions has no standalone settings page. You turn its actions on per
text format: go to **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`), edit a CKEditor 5 format, and add
this module's AI buttons to the editor toolbar. From then on the actions appear
in that format's editor.

## How to use it

1. Make sure the AI module has a working provider, with its API key stored as a
   **Key** entity (see [Installation](installation/index.md)).
2. In a CKEditor 5 text format, drag this module's AI text-action button(s) into
   the active toolbar and save the format.
3. While editing content in that format, select some text and choose the AI
   action — rewrite, summarize, or translate — to have the AI transform the
   selection in place.
4. Review the generated text before saving or publishing.

Grant the module's permission only to the authors you want to be able to run
these AI actions.
