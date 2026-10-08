# Gutenberg AI Tools — manual setup guide

**Gutenberg AI Tools** (`gutenberg_ai_tools`) adds an **AI block** to the
Gutenberg editor. Instead of copying and pasting between your AI provider and
Drupal, an editor drops an AI Block into the page, types a question, and the
answer is generated and rendered right there in the editor. You can then edit or
add to the AI's answer, and combine the AI Block with other Gutenberg blocks to
build rich, interactive pages.

The module doesn't talk to an AI provider directly — it works through Drupal's
**AI** module. You configure your provider (OpenAI, Azure OpenAI, Google Gemini,
and so on) and its credentials through the AI module and its provider submodule,
then tell Gutenberg AI Tools which provider and model to use. Because each prompt
is a live call to a large language model, be mindful of **cost** (every "Ask AI"
is a billable request) and of **data egress** (the prompt text leaves your site
and goes to the AI provider).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it requires the
   AI and Gutenberg modules) and enable it.
2. [Configuration](configuration/index.md) — set the AI provider/model, key
   handling, and enable the AI Block per content type.

## Where it lives in the admin menu

The module's settings form is at **`/admin/config/openai/gutenberg-ai-settings`**,
where you select the AI provider and model. The provider's own credentials are
configured through the **AI** module.
