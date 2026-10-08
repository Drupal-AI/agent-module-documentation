# Azure OpenAI Augmentor — manual setup guide

**Azure OpenAI Augmentor** (`augmentor_azure_openai`) is a provider submodule for
the [Augmentor](https://www.drupal.org/project/augmentor) framework. It adds Azure
OpenAI as an Augmentor provider, so Augmentor-based AI transformations — summaries,
classification, generation — can be powered by Azure OpenAI models. It is aimed at
organisations that use Microsoft's hosted OpenAI service rather than the public
OpenAI endpoint.

Once installed, it appears as a provider you can select when creating an augmentor.
You supply your Azure OpenAI **endpoint** and **API key**, and Augmentor routes its
operations through Azure. Because those are credentials and Azure is an external
service, the same discipline applies as with any AI provider: store the endpoint
and key securely (environment-backed, never in committed config), and remember
that content sent to Azure **leaves your infrastructure** and incurs cost and
egress. It depends on the `augmentor` framework and supports Drupal 9.3, 10 and 11.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up the Azure endpoint and key securely.

## How to use it

1. In the **Augmentors** area (under Configuration, gated by *Administer
   augmentors*), add an augmentor and choose the **Azure OpenAI** provider.
2. Enter your Azure OpenAI **endpoint** and select the model/deployment, and
   provide the **API key** — via a **Key** entity so the secret is not stored in
   plain config (see installation).
3. Configure the operation (summary, classification, generation) and save.
4. Run the augmentor from wherever Augmentor is wired in (CKEditor, ECA, Search
   API, or an entity field).

### Credentials

Keep the Azure endpoint and API key out of committed configuration. Store the key
in an environment variable and expose it through a **Key** entity (env provider):
with DDEV, `ddev dotenv set .ddev/.env --azure-openai-api-key=<value>` (never
commit `.ddev/.env`), then `ddev restart`, and reference that variable from the
Key entity you select in the augmentor form.
