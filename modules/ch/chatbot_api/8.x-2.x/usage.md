<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chatbot API

## What it is / when to use

- Provides a framework/API for building chatbot and personal-assistant integrations in Drupal.
- The `chatbot_api_entities` submodule can push entity information to remote chatbot APIs (e.g. intent/entity syncing).
- Use as a base for connecting Drupal content to external NLU/chatbot platforms.

---

## Install & configure

- Enable `chatbot_api`; optionally enable the `chatbot_api_entities` submodule for entity push.
- Grant `administer chatbot api entities` to configure entity-to-API syncing (declared `restrict access: true`).
- Push handlers are pluggable and receive the `http_client` service for outbound calls.
- Configure remote API credentials per the specific push-handler plugin you install.

---

## Usage & API notes

- Defines plugin types and services (`chatbot_api.services.yml`) that other modules build on.
- The entities submodule dispatches entity CRUD to push handlers (`PushHandlerBase`) that call remote APIs via Guzzle `http_client`.
- Query handler plugins (e.g. `DefaultEntity`) load entities for API responses using entity queries.
- Ships Drupal Console commands (`console.services.yml`) for scaffolding.
- Outbound HTTP uses Drupal's `http_client` (Guzzle) — TLS verification follows Guzzle defaults (enabled).
- No anonymous mutation routes are declared by the base module.
- The framework is intended to be extended with concrete provider plugins (API.AI/Dialogflow, etc.).
- Entity push is gated by the `administer chatbot api entities` permission.
- Includes automated tests under `tests/`.
- Config schema is provided for the entities submodule's views.
- Credentials/keys are handled by the concrete provider plugin, not the base API.
- Use with a provider submodule to actually connect to a chatbot backend.
- Entity queries in query handlers respect the passed entity storage.
- Extend by implementing new PushHandler/QueryHandler plugins.
- Suited to sites exposing content to conversational assistants.
- Review any provider plugin you add for how it stores API keys.
