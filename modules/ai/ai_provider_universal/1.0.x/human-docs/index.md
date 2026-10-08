# AI Provider: Universal — manual setup guide

**AI Provider: Universal** (`ai_provider_universal`) is a flexible, multi-instance
provider for Drupal's [AI module](https://www.drupal.org/project/ai). Instead of
hard-coding one vendor, it lets you define **servers** and **models** as
configuration entities — so you can register several **OpenAI-compatible
endpoints** (a hosted service, a self-run server, a proxy, or several of each) and
make all of their models available to the AI module from a single provider.

This is useful when a site needs to reach more than one OpenAI-style backend, or
when you want the endpoints and models to live in configuration you can export and
deploy rather than being fixed by a single-vendor module. Any model you define
becomes selectable wherever the AI module offers a provider choice.

Where an endpoint needs an API key, the credential is stored through Drupal's
**Key** module (env-backed). When operations run, prompt content is sent to the
configured endpoint, so cost and data egress depend on which server you point each
model at.

> **Note:** at the time of writing the release is **1.0.0-beta2** — a beta — and it
> targets **Drupal 11.1 or 12** only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — define server and model config
   entities and store any API keys.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`), where you manage the server and model config
entities. It also defines its own permission for administering the provider.

## How to use it

Enable the module, define one or more servers (each an OpenAI-compatible base URL,
with an API key stored as a Key entity where required) and the models they serve,
then choose **Universal** and a model wherever the AI module offers a provider
choice.
