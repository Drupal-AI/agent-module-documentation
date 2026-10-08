# AI CKEditor Extras — manual setup guide

**AI CKEditor Extras** (`ai_ckeditor_extras`) adds a set of AI‑powered authoring
tools to Drupal's CKEditor, on top of the AI CKEditor integration. Editors get
four new tools they can run on selected text without leaving the editor:

- **Paraphrasing** — rewords a selection. You can pick a mode such as *simplify*,
  *expand*, *restructure*, or *synonymize*.
- **Tone** — rewrites a selection into a chosen tone of voice. The available tones
  come from a taxonomy vocabulary you point it at, and the prompt it uses is
  editable (it includes a `{{ tone }}` placeholder).
- **Flesch Score** — computes the Flesch reading‑ease score of the selection and
  can rewrite the text to improve it.
- **FAQ Generator** — turns selected content into a set of question‑and‑answer
  pairs.

Each tool sends the selected text to whichever AI provider you configure, so it
uses your provider credentials and can incur a cost. The prompts are
admin‑configurable per tool, which means operators control exactly what is sent
to the model. Because these are AI CKEditor plugins, there are no custom routes or
permissions of their own — access is governed entirely by which text formats a
role can use, so restrict the AI tools to the formats and roles you intend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add the tools to a text format.

## How to use it

1. Make sure the [AI](https://www.drupal.org/project/ai) module and **AI
   CKEditor** are installed with a working AI provider.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a CKEditor‑based text format.
3. Add the AI tools you want — Paraphrasing, Tone, Flesch Score, FAQ — to that
   format's toolbar. Each tool has a small configuration form where you pick the
   AI provider/model and set its options:
   - **Paraphrasing:** choose the mode (simplify, expand, restructure,
     synonymize).
   - **Tone:** select the taxonomy vocabulary that supplies the tone terms, and
     review/adjust the tone prompt (it uses the `{{ tone }}` placeholder). It can
     optionally auto‑create tone terms.
   - **Flesch Score / FAQ:** enable and pick a provider/model.
4. Review each tool's prompt before production use, restrict the format to trusted
   roles, and save. Editors working in that format can then select text and run
   any of the tools from the toolbar.

Depends on **AI CKEditor** (`ai_ckeditor`) and the AI provider stack. Works on
Drupal 10.3+ and 11.
