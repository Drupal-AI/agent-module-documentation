<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dialogflow Webhook — manual setup guide

**Dialogflow Webhook** (`api_ai_webhook`) exposes a single POST endpoint at
`/api.ai/webhook` that receives fulfilment requests from a Google **Dialogflow**
agent (formerly Api.AI). When a request arrives, the module parses the Dialogflow
JSON and dispatches a Symfony event (`ApiAiEvent`); your own code — or another
module — subscribes to that event, builds the answer, and the controller returns
it to Dialogflow as JSON.

The module itself makes no AI or outbound calls. It is purely the plumbing that
turns an incoming Dialogflow fulfilment request into a Drupal event you can
respond to. To actually answer intents you write an event subscriber, or you
enable the bundled **`chatbot_api_apiai`** submodule to bridge into the Chatbot
API intent/response framework.

**Security — read this before going live.** The endpoint has three authentication
modes (`none`, `basic`, `headers`), and the **default is `none`**, which
authenticates every incoming request as the anonymous user — i.e. the endpoint is
open. Always switch it to `basic` or `headers` in production so only Dialogflow
can reach it. Failed attempts are rate-limited by IP through Drupal's flood
service. This version (`8.x-2.x`) supports Drupal 8, 9 and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required Dialogflow library) and enable the module.
2. [Configuration](configuration/index.md) — choose and set up the webhook's
   authentication mode. **Do this before exposing the endpoint.**

## Where it lives in the admin menu

The authentication settings form is at **Configuration → Web services → Dialogflow
Webhook** (`/admin/config/service/api_ai_webhook`), reachable with the *access
administration pages* permission.

## How to use it

1. Point your Dialogflow agent's fulfilment webhook at
   `https://your-site/api.ai/webhook`.
2. Set the authentication mode (see [Configuration](configuration/index.md)) and
   configure the matching credentials in Dialogflow.
3. Write an event subscriber for `ApiAiEvent::NAME` that inspects the incoming
   request and populates the response — or enable `chatbot_api_apiai` to answer
   intents through the Chatbot API framework.
4. Test with a Dialogflow-shaped JSON POST to `/api.ai/webhook`. Invalid payloads
   are logged and return an HTTP 500.
