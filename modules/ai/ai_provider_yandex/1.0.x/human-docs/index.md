# AI Provider Yandex — manual setup guide

**AI Provider Yandex** (`ai_provider_yandex`) plugs **YandexGPT** into Drupal's
AI module as a selectable provider. Once it is installed and given an API
credential, YandexGPT's text‑generation and chat models show up in the same
provider dropdowns that every other AI feature on your site uses — so any
module built on the AI framework (assistants, content tools, search) can be
pointed at YandexGPT instead of, or alongside, another provider.

The module does not add a feature of its own that you see on the front end. Its
whole job is to be the "adapter" between Drupal's AI abstraction and Yandex's
cloud API. You install it, store your Yandex key securely, and then choose
YandexGPT wherever a provider is offered.

It depends on the **Key** module, so your Yandex API key or IAM credential lives
as a Key entity (backed by an environment variable or secret store) rather than in
plain configuration.

**Data‑residency note:** YandexGPT is a **non‑US cloud service (Yandex,
Russia)**. When a feature uses this provider, the prompt and content you send are
transmitted over HTTPS to Yandex's servers. Confirm that sending your content to
that provider is acceptable for your organisation's privacy and compliance rules
before you route real content through it.

This guide is written for a **human** setting the provider up through the admin
UI and the command line. If you want a terse, token‑cheap reference for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and store your Yandex credential as a Key.

## How to use it

There is no standalone settings page for this module. You use it in three steps:

1. **Store your Yandex credential** as a Key (see
   [Installation](installation/index.md)).
2. **Select and configure the provider.** Yandex now appears as a provider in
   the AI module's provider administration (under **Configuration →** the **AI**
   section). Choose the Key you created and, if needed, set which YandexGPT model
   answers each type of request.
3. **Point a feature at it.** In any AI‑powered feature, pick YandexGPT (or set
   it as a default provider for an operation type such as *chat*) and that
   feature's calls go to Yandex.
