<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LM Studio Provider registers a local LM Studio server as an AI provider for the Drupal AI module via its OpenAI-compatible HTTP API.

---

`ai_provider_lmstudio` connects the [AI module](https://www.drupal.org/project/ai) to a
[LM Studio](https://lmstudio.ai/) server running on a local or self-hosted machine. LM Studio
exposes an OpenAI-compatible API; this module points the AI module at that server by host name and
optional port, then offers **chat** and **embeddings** operations against whatever models the server
is serving. Models are discovered from the server's `/v1/models` endpoint. No API key is required —
LM Studio's local server is unauthenticated, and a legacy `api_key` config value was removed by an
update hook. An install hook migrates configuration from the older AI-core submodule
(`provider_lmstudio`) when present. It is aimed at developers and data scientists who want to run and
tune models locally before deploying at scale. Supports Drupal 10.2+ and 11.

---

- Add a local LM Studio server as an AI provider.
- Run chat completions against a model loaded in LM Studio.
- Generate embeddings from an LM Studio embeddings model.
- Test and tweak models locally before deploying to production.
- Keep prompt and completion data on a local machine.
- Point Drupal at `http://127.0.0.1:1234` for a default LM Studio server.
- Configure the server host name and port from one admin form.
- Discover the models LM Studio is currently serving via `/v1/models`.
- Reuse OpenAI-style AI-module flows against the local endpoint.
- Select LM Studio as the provider for a chat operation in AI settings.
- Select LM Studio as the provider for an embeddings operation.
- Avoid per-token third-party LLM vendor cost during development.
- Prototype AI features (assistants, RAG, summarization) with a local model.
- Migrate from the older `provider_lmstudio` AI-core submodule automatically.
- Run inference for privacy-sensitive content without leaving the machine.
- Set chat parameters (max tokens, temperature, penalties, top_p) via the AI module.
- Complement cloud providers with a local option for offline work.
- Provide a low-cost backend for experimenting with open models.
- Support Drupal 10.2, 11 sites running the AI module.
- Drive AI-module features from a GUI-managed local model catalog.
