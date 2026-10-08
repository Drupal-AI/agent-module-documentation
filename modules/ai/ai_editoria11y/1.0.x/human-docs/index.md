# AI Editoria11y — manual setup guide

**AI Editoria11y** (`ai_editoria11y`) blends AI assistance into the
**Editoria11y** accessibility checker. Editoria11y flags accessibility problems
in your content as you edit — missing alt text, awkward headings, and so on. This
module adds a **"Fix with AI"** button to those flagged issues, so an editor can
ask the AI to suggest a fix, such as rewriting alt text or restructuring a
heading.

It stitches together several pieces: Editoria11y for the accessibility checks,
core CKEditor 5 and the AI module's CKEditor integration for applying changes in
the editor, and the AI module for the model itself. When you click "Fix with AI",
the relevant content is sent to your configured AI provider and a suggested fix
comes back.

Because these are AI suggestions, they should be **reviewed** before you accept
them — don't blindly apply a generated fix. And as with any AI feature, the
content sent to the provider is an external egress, so confirm that's acceptable,
and keep the provider's API key as a secret in the AI module's Key
configuration.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Editoria11y / AI / CKEditor dependencies.

## Where it lives in the admin menu

AI Editoria11y has no standalone settings page. It works within Editoria11y's
checks and the CKEditor 5 editor once its dependencies are configured and its
permission is granted. Editoria11y itself is configured at its own settings page;
the AI provider is configured through the AI module.

## How to use it

1. Have Editoria11y set up and running its accessibility checks on your content,
   and the AI module configured with a provider (API key stored as a **Key**
   entity — see [Installation](installation/index.md)).
2. Grant the module's permission to the editors who should be able to use the
   "Fix with AI" feature.
3. While editing content, when Editoria11y flags an accessibility issue, click
   **Fix with AI** to have the AI propose a fix.
4. Review the suggestion and apply it only if it's correct.

The "Fix with AI" action is assistance, not automation — a human stays in control
of what actually gets saved.
