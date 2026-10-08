# Analyze AI Brand Voice — manual setup guide

**Analyze AI Brand Voice** (`analyze_ai_brand_voice`) uses AI to check your
content for **brand-voice consistency**. Keeping a consistent voice across many
pieces of content is hard to verify by hand; this module sends a piece of content
to a configured AI provider, which assesses how well it matches a brand voice and
returns advisory feedback.

It is a submodule of the **Analyze** ecosystem, so its results appear on the
entity's Analyze tab alongside any other analysis plugins you have enabled. It
does not replace an editor's judgement — the output is advice to consider, not a
verdict.

Because it works by sending content to an external AI provider, two things
matter. The provider's **API key is a credential** — keep it out of plain
configuration and store it securely. And the content you analyze **leaves your
infrastructure** to reach the provider, which is a governance decision for
anything confidential. Also keep an eye on **API cost**, since each analysis is a
paid call to the provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and connect an AI provider.

## How to use it

Once the module and its dependencies are installed and an AI provider is
configured (with the provider key stored as a secret), open an entity's **Analyze**
tab. The brand-voice analysis appears there, giving you an AI assessment of how
well the content matches your brand voice. Treat the result as advisory, send
only content you are comfortable sharing with the provider, and remember each run
has an API cost.
