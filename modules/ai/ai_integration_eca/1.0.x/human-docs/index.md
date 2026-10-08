# AI Integration - ECA — manual setup guide

**AI Integration - ECA** (`ai_integration_eca`) is the bridge between Drupal's
**AI** module and **ECA** (Event‑Condition‑Action, Drupal's no‑code automation
framework). It exposes AI operations — **Chat**, **Embedding**, **Moderation**,
**Speech‑to‑Text**, and **Text‑to‑Speech** — as ECA *actions*, so you can drop an
LLM call straight into a visual ECA model without writing any PHP. It replaces the
older `ai_eca` submodule and standalone `ai_eca` project.

In practice this lets you build AI‑driven business rules declaratively — for
example: auto‑generate a summary from body text when a node is saved, translate or
rewrite field text, run user submissions through a moderation model and branch on
the result, produce structured JSON output from a chat model, generate a vector
embedding for downstream use, transcribe an uploaded audio file, or synthesize
spoken audio and get back a file URL. Each action picks any configured AI
provider+model, reads its input from an ECA token, and writes the result to
another ECA token so later steps in the model can use it. You can chain several AI
actions in one model (moderate → chat → save, say).

Because these are ordinary ECA actions, **there is no settings page in this
module** — you configure the actions inside your ECA models, and access is governed
by ECA's own admin permissions. The module has no permissions, config schema, or
Drush commands of its own.

It depends on the **AI** module (`^1.2`), **AI Agents** (`^1.2`), **ECA**
(`^2 || ^3`), the **Token** module (`^1.15`), and core's **File** module, on Drupal
10.3+ or 11. Two optional submodules extend it: **AI Integration ECA – Agents**
(`ai_integration_eca_agents`), which adds an AI agent and an *Ask AI* form to build
or explain ECA models, and **AI Integration ECA – Automators**
(`ai_integration_eca_automators`), which wires AI Automators into ECA and
vice‑versa.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.

## Where it lives in the admin menu

The module adds no menu item or settings page. Its AI actions appear inside the
**ECA** modeller when you build an ECA model — under **Configuration → Workflow →
ECA** (`/admin/config/workflow/eca`). You'll also need the **AI** module
configured with at least one provider and model for the operation type you want to
use (**Configuration → AI**).

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and make sure the
   AI module has a working provider/model for the operation you need (Chat,
   Embedding, Moderation, Speech‑to‑Text, or Text‑to‑Speech).
2. Create or edit an ECA model and add one of the AI actions to it.
3. Configure the action:
   - **Model** — pick the provider + model to use.
   - **Token input** — the ECA token holding the input data (for Speech‑to‑Text
     this should be a file path; for Chat the prompt supplies the text).
   - **Token result** — the ECA token the AI response is written to, for later
     steps to consume.
   - **Chat** actions also have a **Prompt** (which supports token replacement, so
     you can interpolate values like `[node:title]`) and an optional **Schema** for
     structured JSON output. Set a persona with `system_name` / `system_prompt`
     keys in the action's YAML config.
   - The config‑driven actions (all except Moderation) have a **config** YAML field
     for model parameters such as `temperature`, `voice`, or `response_format`.
     These are validated against the provider's real capabilities — an invalid
     value blocks both saving and running the action.
4. Save the model. The AI action runs whenever the model's event fires. Note that
   Text‑to‑Speech saves the generated audio as `public://audio.mp3` and returns its
   URL in the result token.
