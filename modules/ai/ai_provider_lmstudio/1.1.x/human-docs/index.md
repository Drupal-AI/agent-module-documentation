# LM Studio Provider — manual setup guide

**LM Studio Provider** (`ai_provider_lmstudio`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[LM Studio](https://lmstudio.ai/), a desktop application that downloads and runs
large language models **locally** on your own machine or server. LM Studio
exposes an OpenAI‑compatible local server (typically at a URL like
`http://localhost:1234/v1`), and this module registers that server as an AI
provider so any AI feature on your site can send its work to a model you host
yourself instead of a cloud service.

The headline reason to use it is **data handling**: because the model runs on
your own infrastructure, prompts never leave it. For sensitive or regulated
content that can be the deciding factor. The trade‑off is that you are
responsible for running and securing the LM Studio server — point the provider
only at a **trusted local endpoint**, and if that server is reachable across a
network rather than just `localhost`, put authentication or network isolation in
front of it.

It depends only on the AI module, targets Drupal 10.2+ and 11, and has its own
settings form for the endpoint. Because a local LM Studio server usually needs no
API key, a credential is often optional here — unlike the cloud providers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   module requirement, and enable the module.
2. [Configuration](configuration/index.md) — point the provider at your LM Studio
   endpoint and (optionally) supply a key.

## Where it lives in the admin menu

Once enabled, the provider is configured from its settings form under
**Configuration → AI** (the AI module's settings area, `/admin/config/ai`), and a
direct **Configure** link appears next to the module on the
**Extend** page (`/admin/modules`). You do not add menu items or blocks — the
provider simply becomes selectable wherever the AI module offers a provider
choice.

## How to use it

Enable the module, tell it where your LM Studio server is listening, then choose
LM Studio (and one of its loaded models) as the provider for whichever AI
operation you want to run locally — chat, completions, and so on.
