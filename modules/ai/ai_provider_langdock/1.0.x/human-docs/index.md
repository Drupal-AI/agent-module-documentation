# Langdock Provider for Drupal AI — manual setup guide

**Langdock Provider for Drupal AI** (`ai_provider_langdock`) connects Drupal's AI
module to the **Langdock** LLM platform. Langdock is a hosted platform that
provides access to a range of language models behind one API; this module lets the
AI module route its operations (chat/completion and the like) to Langdock's
models. Once enabled and given an API key, Langdock appears as a selectable
provider wherever the AI module offers a provider choice.

It has its own settings form where you supply the Langdock connection details and
API key. Beyond that, which capabilities you can use follow from the AI module and
the Langdock models you have access to.

The security points are the familiar ones. Authenticate with the Langdock API key
stored as a **secret** — use a **Key** entity backed by an environment variable
rather than putting it in exported configuration or code. And content sent to
Langdock leaves the site, so handle sensitive prompts with that in mind. The
module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI dependency.
2. [Configuration](configuration/index.md) — supply the Langdock connection and
   API key on the provider settings form, and choose it for AI operations.

## Where it lives in the admin menu

This provider has its own settings form (`ai_provider_langdock.settings_form`),
reached from the AI module's provider settings under **Configuration → AI**
(`/admin/config/ai`).

## How to use it

Get a Langdock API key, enable this module, store the key as a secret (a Key
entity backed by the environment), and enter the connection details on the
Langdock provider settings form. Then select Langdock for the AI operations you
want on the AI default-provider settings. This is a **beta** release; requires
Drupal 10.5 or 11.
