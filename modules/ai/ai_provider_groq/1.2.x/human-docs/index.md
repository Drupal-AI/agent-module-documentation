# Groq Provider — manual setup guide

**Groq Provider** (`ai_provider_groq`) connects Drupal's AI module to **Groq**,
whose distinguishing feature is **latency**. Groq runs inference on purpose-built
hardware and returns tokens substantially faster than general-purpose GPU
inference. That speed changes what an AI feature can be, not just how it feels: a
summarisation that takes eight seconds is a background job with a spinner; one
that returns in under a second can run while an editor watches. Speed like that
matters most for anything interactive — inline suggestions, autocomplete, an
editorial assistant, or a search that reformulates a query before running it.

Once enabled and given an API key, Groq appears as a selectable provider wherever
the AI module offers a provider choice. It serves a range of models, including
open-weight ones — which lowers the risk of being stranded if a specific model is
withdrawn, since the same weights can often be run elsewhere.

The API key is stored via the **Key** module from an environment variable rather
than in exported configuration. As with every provider: the key is a spending
credential (set a limit and watch it), a prompt is a disclosure (whatever you send
leaves the site), and a pinned model needs a plan for when it changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — supply your Groq API key on the
   provider settings form and choose it for AI operations.

## Where it lives in the admin menu

This provider has its own settings form (`ai_provider_groq.settings_form`),
reached from the AI module's provider settings under **Configuration → AI**
(`/admin/config/ai`).

## How to use it

Get a Groq API key, enable this module, store the key as a Key entity, and enter
it on the Groq provider settings form. Then select Groq for the AI operations you
want on the AI default-provider settings — it is a natural fit for the interactive
ones where response time is visible to the user. This is a release candidate
(1.2.0-rc1); requires Drupal 10.2 or 11.
