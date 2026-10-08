# Chatbot API — manual setup guide

**Chatbot API** (`chatbot_api`) is a framework — an API layer — for connecting
Drupal content to chatbots and personal assistants such as Alexa, Dialogflow,
Google Home, or Wit.ai. Normally each of those platforms needs its own custom code
to handle requests and responses, duplicating effort. Chatbot API gives you a
common layer so you write your integration logic once, without worrying about each
platform's request/response plumbing.

By itself this module does nothing visible: it defines plugin types (chatbot
"intents" as plugins, plus push/query handlers) and services that other modules
build on. You install it because another module requires it, or because you're
building your own integration driver. Concrete platform support lives in separate
provider modules — for example an Alexa submodule paired with the Alexa module, or
a Dialogflow driver — which have moved out of the base module in this 2.x branch.

The bundled submodule **`chatbot_api_entities`** adds the ability to push entity
data to a remote chatbot API (for example syncing content so the remote service can
resolve it as slots/entities). That push is gated by a restricted **Administer
chatbot api entities** permission, and outbound calls use Drupal's HTTP client
(Guzzle) with normal TLS verification. Any actual API credentials live in the
concrete provider plugin you add, not in this base module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module and (optionally) the entities submodule, and grant its permission.

There is **no configuration form** in the base module. Configuration of an actual
chatbot connection is provided by the concrete provider plugin you install on top.

## How to use it

On its own, Chatbot API is scaffolding. To actually connect Drupal to a
conversational assistant:

1. Enable `chatbot_api` (and, if you want to push entity data to a remote API, the
   `chatbot_api_entities` submodule).
2. Add a concrete provider module/driver for your platform (Alexa, Dialogflow,
   etc.), or build your own by implementing the intent and push/query handler
   plugins this module defines.
3. Configure the remote API's credentials in that provider plugin.

The framework's Views integration lets you build a View of content, iterate through
it from a device, and drill into an item to "know more"; intents are implemented as
plugins whose ID is the intent name, so the same intent can serve multiple
platforms.
