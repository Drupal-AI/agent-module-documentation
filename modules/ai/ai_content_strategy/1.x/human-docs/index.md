# AI Content Strategy — manual setup guide

**AI Content Strategy** (`ai_content_strategy`) helps you decide *what* content to
create. Planning an editorial calendar — spotting gaps, choosing topics, and
shaping site structure — is exactly the kind of judgement AI can advise on. This
module analyses your site's existing content and returns **strategy
recommendations** through a configured AI provider, informed by the E-E-A-T
framework (Experience, Expertise, Authoritativeness, Trustworthiness) that guides
quality content planning.

The output is **advisory**. The module surfaces recommendations — content gaps,
topic ideas, structural suggestions — that a human editor reviews and acts on. It
does not create or publish anything itself; it guides the people who do.

It builds on the Drupal **AI** module, and the usual AI considerations apply: the
provider API key is a credential that must stay out of plain config, and the
content it analyses is sent to the external AI provider, which is a governance
decision for anything confidential. The module also depends on core's Menu UI and
provides its own permissions. It works on Drupal 10.2+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI module and a provider are in place.

## How to use it

Grant the module's administration permission only to the strategists or editors
who should run analyses, since each run sends content to the AI provider and costs
money. Point it at your site's content, let it analyse and return recommendations,
and treat the result as a planning aid — a human decides which topics and
structural changes to pursue. Only send content you are comfortable sharing with
the external provider.
