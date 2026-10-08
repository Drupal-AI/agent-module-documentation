# OpenAI Client — manual setup guide

**OpenAI Client** (`openai_client`) provides OpenAI API integration for Drupal:
a client service plus a couple of ready‑made user interfaces for calling OpenAI
from your site. You configure your OpenAI API token, the module fetches the list
of models your account can use, and you pick a default model to chat with. It
also adds an **AI conversation** content type so you can hold a chat with the
default model, and an example **image creator** form at
`/openai-client/create-image` (behind an *openai_client create image form*
permission). If the chosen model supports it, you can even include images in a
chat conversation by pasting them as Base64.

For developers, the module exposes an `openai_client.wrapper` service with a small
interface — `getClient()`, `getModels()`, `hasToken()`, `fastChatQuery()`,
`getDefaultModel()`, `imageCreate()` and helpers — so you can build your own
OpenAI‑backed features on top of it.

A few things to keep in mind: the module **sends prompts and content to OpenAI**,
so confirm that data egress is acceptable for your site before enabling it widely.
Authentication uses an **OpenAI API key**, which you should store as a secret and
never commit to configuration. And any interface that lets people invoke OpenAI
should be gated by the module's permission to trusted users, both to control who
can send data and to keep API usage and cost in check. (The module is an
independent project and is not affiliated with OpenAI.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set your OpenAI API token and choose
   the default chat model.

## Where it lives in the admin menu

The settings form is at **Configuration → System → OpenAI Client**
(`/admin/config/system/openai-client`). See
[Configuration](configuration/index.md).

## How to use it

Once your token and default model are set, create an **AI conversation** node to
chat with the model. To try image generation, grant the *openai_client create
image form* permission and visit `/openai-client/create-image`. To build custom
functionality, call the `openai_client.wrapper` service from your own module.
