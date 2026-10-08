# AI Evaluations — manual setup guide

**AI Evaluations** (`ai_evaluations`) runs evaluations against the responses of
an **AI Chatbot** or **AI Assistant**. It tests and scores an assistant's answers
— against expected outputs or criteria — so you can measure the quality and
accuracy of your chatbot over time, rather than guessing whether a change made it
better or worse.

It builds on the AI Assistant API and AI Chatbot modules and uses core Views to
present results. Run a set of test prompts through your assistant, score the
answers, and store the results so you can compare across configurations and
track quality as you iterate.

This is a developer/QA-oriented feature. The evaluations send test prompts and
content to your AI provider (an external egress) and store the results, so grant
the module's permission only to trusted developers and admins, and handle the
stored evaluation data — which may include sample content — appropriately.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its AI Chatbot / Assistant dependencies.

## Where it lives in the admin menu

AI Evaluations has no standalone settings route (`configure` is null); you work
with it through its evaluation screens, which are gated by its own permission and
presented with Views. Configure the underlying AI Assistant and AI Chatbot
through their own modules.

## How to use it

1. Have an AI Assistant / AI Chatbot set up and working, with the AI provider's
   API key stored as a **Key** entity (never in plain config).
2. Grant the module's permission only to the trusted developers and admins who
   should run evaluations.
3. Configure and run evaluations — feeding test prompts to the assistant and
   scoring the answers against your criteria.
4. Review the stored results (surfaced through Views) to track quality over time.

Because every run sends prompts to the AI provider, keep an eye on provider cost,
and treat the stored evaluation data with the same care as the content it samples.
