# Bifrost AI Provider — manual setup guide

**Bifrost AI Provider** (`ai_provider_bifrost`) connects Drupal's AI module to
**Bifrost**, an LLM gateway that sits in front of many upstream model vendors.
Instead of pointing Drupal at one vendor's API directly, you point it at your
Bifrost gateway, and the gateway handles routing, model selection and policy for
whatever models it fronts. That gives you one place to manage access, switch
models and apply organisation-wide rules, rather than configuring each vendor
separately inside Drupal.

Functionally it behaves like any other AI provider: once enabled and given a
gateway URL and credential, Bifrost shows up as a selectable provider anywhere
the AI module offers a provider choice (chat and related operations). The
difference is that the model you end up talking to is decided at the gateway, not
in Drupal.

Two things worth keeping in mind. The gateway credential is a real spending and
access credential, so it is stored through the **Key** module and should be
backed by an environment variable rather than saved in exported configuration.
And every prompt you send travels to the Bifrost endpoint and on to whatever
upstream model it routes to — treat that as data leaving your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and enable the
   module along with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — register Bifrost as a provider,
   supply the gateway URL, and store the credential securely via Key.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including Bifrost, are configured from
the **Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Enable the module, add your Bifrost gateway URL and store its credential as a Key
entity, then go to the AI module's default-provider settings and choose Bifrost
for the operations (such as chat) you want it to handle. From then on, any AI
feature that uses that operation routes through your Bifrost gateway. Requires
Drupal 11 or 12.
