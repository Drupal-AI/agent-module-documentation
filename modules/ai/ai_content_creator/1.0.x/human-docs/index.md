# AI Content Creator — manual setup guide

**AI Content Creator** (`ai_content_creator`) is a writing assistant for Drupal.
You give it a prompt — a topic, an outline, an instruction — and it drafts
article text with an AI model, so you can produce a first draft in seconds instead
of starting from a blank page. It is meant to speed up content production, not to
replace an editor.

The output is a **draft**. AI-generated text can be inaccurate, can hallucinate
facts, and can raise licensing questions, so a human should always read, check,
and edit what the module produces before it is published. Think of it as a fast
ghostwriter whose work you always review.

Because it drafts with an AI model, the prompts (and any content you feed it) are
sent to the configured AI provider — text leaves your infrastructure and each
generation costs money against that provider's plan. Confirm that this external
sending is acceptable for your site before you rely on it. The module has no
access-control permissions of its own and works on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm you have a working AI provider.

## How to use it

Once enabled and pointed at a configured AI provider, you write a prompt
describing the content you want and the module drafts it for you. The workflow is
always: generate a draft, then **review and edit** before publishing — the module
adds no publishing safeguards of its own, so editorial review is your
responsibility. Keep confidential material out of prompts, since everything you
send goes to the external AI provider.
