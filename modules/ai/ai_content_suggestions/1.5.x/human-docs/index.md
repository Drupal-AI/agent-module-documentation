# AI Content Suggestions — manual setup guide

**AI Content Suggestions** (`ai_content_suggestions`) puts an AI second opinion
right inside the content editing experience. When an editor is working on a node,
the module can send the content to a configured AI provider and surface
suggestions — a punchier **title**, a **summary**, a **tone** adjustment, and
other alternatives — that the editor can accept or reject on the spot. It turns
"I wish I had a better headline" into a one-click suggestion.

Suggestions are **drafts**. Nothing the AI proposes is applied automatically; the
editor chooses what to take, and anything accepted flows through normal content
handling and review. This keeps a human firmly in control of what actually gets
published.

It builds on the Drupal **AI** module ecosystem and uses Field Widget Actions to
place the suggestion buttons next to the fields they act on. The usual AI
considerations apply: the provider API key is a credential that must stay out of
plain config, and the content sent for suggestions leaves your infrastructure to
the AI provider — a governance decision for anything confidential. The module
provides its own permissions and works on Drupal 10.4+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI module and a provider are in place.

## How to use it

Grant the module's permissions to the editors who should see AI suggestions while
editing. As they write, the suggestion actions appear beside the relevant fields;
clicking one sends that content to the AI provider and shows alternatives to
accept or ignore. Remind editors that each suggestion is a billed AI call and
sends the content externally, so confidential material should stay out of the
fields they run suggestions on.
