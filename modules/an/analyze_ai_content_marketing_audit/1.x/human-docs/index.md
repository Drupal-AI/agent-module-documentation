# Analyze AI Content Marketing Audit — manual setup guide

**Analyze AI Content Marketing Audit** (`analyze_ai_content_marketing_audit`) uses
AI to audit your content for **marketing usability and effectiveness**. It looks
at content across dimensions such as usability, knowledge level, actionability,
accuracy, business value, messaging, and brand-voice fit, and returns an advisory
assessment to help you judge how well a piece works as marketing.

It is a submodule of the **Analyze** ecosystem, so its results appear on the
entity's Analyze tab next to any other analysis plugins you have enabled. The
output is advice for a human to weigh, not a final score.

Like the other AI analysis modules, it works by sending content to a configured
AI provider. That means the provider's **API key is a credential** to keep out of
plain configuration, and the content you audit **leaves your infrastructure** to
reach the provider — a governance decision for anything confidential. Each audit
is a paid call, so watch **API cost** too.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect an AI provider.

## How to use it

Once the module and its dependencies are installed and an AI provider is
configured (with the provider key stored as a secret), open an entity's **Analyze**
tab. The marketing audit appears there, giving you an AI assessment of the
content's marketing effectiveness. Treat the result as advisory, send only
content you are comfortable sharing with the provider, and remember each run has
an API cost.
