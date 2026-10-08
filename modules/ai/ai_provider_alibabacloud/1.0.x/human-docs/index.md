# Alibaba Cloud Model Studio AI Provider — manual setup guide

**Alibaba Cloud Model Studio AI Provider** (`ai_provider_alibabacloud`) is a
connector that plugs Alibaba Cloud's Model Studio service — home of the **Qwen**
family of large language models — into Drupal's [AI module](https://www.drupal.org/project/ai).
On its own the AI module knows *how* to run chat, completion and embedding
operations but not *which* vendor to run them against; this provider fills that
gap, so once it is enabled and given an API key, Qwen models appear in the drop-
downs wherever the AI module lets you pick a provider.

You supply one credential: an Alibaba Cloud Model Studio API key. The module
stores it through Drupal's **Key** module rather than in plain configuration, and
sends it to Alibaba Cloud as a Bearer token over HTTPS (certificate verification
is left on). After that you choose which Qwen model each AI feature should use.

Keep one thing in mind before you route production content through it: everything
you send for an AI operation — prompts, and any content included in them — is
transmitted to Alibaba Cloud's servers. That is a data-handling and data-residency
consideration, since Alibaba Cloud is operated outside the US/EU; weigh it for
sensitive or regulated content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your API key as a Key entity
   and point the provider at Alibaba Cloud Model Studio.

## Where it lives in the admin menu

This module adds no menu items of its own. Its settings form lives with the AI
module's other provider settings under **Configuration → AI**, and its route is
`ai_provider_alibabacloud.settings_form`. You reach it from the AI providers
overview at `/admin/config/ai/providers`.

## How to use it

Enable the module, create a Key entity holding your Alibaba Cloud Model Studio API
key, enter (or select) that key on the provider's settings form, then pick a Qwen
model wherever the AI module offers a provider choice — for example as the default
chat provider, or on an individual AI feature. From then on those operations run
against Alibaba Cloud.
