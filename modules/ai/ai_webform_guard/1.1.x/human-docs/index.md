# AI Webform Guard — manual setup guide

**AI Webform Guard** (`ai_webform_guard`) protects Webforms from spam by running
submissions through an AI model that classifies them, so spammy content can be
blocked before it is stored. It is an intelligent alternative or complement to
traditional defenses like CAPTCHA and Honeypot — instead of a puzzle or a hidden
field, it judges the content of the submission itself.

It builds on the AI module and the Webform module. When a form is submitted, the
submission content is **sent to the configured AI provider** to be classified.
Two things follow from that: submissions may contain personal data (PII), so
confirm that sending them to an external provider is acceptable for your site;
and there is a per‑call cost to the provider. The provider's API key is kept as a
secret through the AI module's Key configuration rather than in plain config.

As with any classifier, treat it as **one layer** of defense — combine it with
server‑side anti‑spam measures rather than relying on it alone. It has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Webform anti‑spam protections are configured per form under the Webform UI
(**Structure → Webforms**, then a form's settings). The AI provider that does the
classification is configured in the **AI** module. AI Webform Guard has no
standalone settings page of its own.

## How to use it

1. Make sure the **Webform** module and the **AI** module (with a working
   provider) are set up.
2. Enable AI Webform Guard.
3. Enable the AI spam protection on the webform(s) you want guarded.
4. Test with a known‑spam and a legitimate submission, and keep a server‑side
   anti‑spam layer in place alongside it.

> **Privacy:** submission text is sent to your AI provider for classification.
> Confirm this is acceptable for the personal data your forms collect.
