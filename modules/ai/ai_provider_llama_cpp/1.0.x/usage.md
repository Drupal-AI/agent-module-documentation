<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The llama.cpp provider registers a self-hosted llama.cpp server as an AI provider for the Drupal AI module through its OpenAI-compatible `/v1` HTTP API.

---

`ai_provider_llama_cpp` plugs a running `llama-server` instance into the [AI module](https://www.drupal.org/project/ai) as a provider, exposing chat completions and embeddings. Because llama.cpp speaks the OpenAI API shape, existing OpenAI-style AI-module flows work unchanged against the local endpoint. The provider auto-discovers the models the server currently serves from `/v1/models`, converts each raw model id into a machine name, and caches the mapping in Drupal State so a temporarily offline server does not empty the model list. No API key is required — the module targets local and privately-hosted deployments where prompt data stays on infrastructure the operator controls. Configuration is a single admin form (host name + port). The upstream project is marked obsolete, with development moved to a multi-instance successor. Supports Drupal 10.2+ and 11.

---

- Add a self-hosted llama.cpp server as an AI provider.
- Run chat completions against a locally-hosted GGUF model.
- Generate embeddings from a llama.cpp embeddings model.
- Reuse OpenAI-style AI-module flows against a local endpoint.
- Keep prompt and completion data on operator-controlled infrastructure.
- Avoid per-token third-party LLM vendor cost.
- Point Drupal at `http://127.0.0.1:8080` for a local `llama-server`.
- Point Drupal at `http://host.docker.internal` from a DDEV/Docker environment.
- Auto-discover the models a server is serving via `/v1/models`.
- Cache the model list in State so an offline server keeps its selectable models.
- Configure the server host name and port from one admin form.
- Select llama.cpp as the provider for a chat operation in AI settings.
- Select llama.cpp as the provider for an embeddings operation.
- Test connectivity to the server from the settings form before saving.
- Serve on-prem/private models without an API key.
- Complement cloud AI providers with a local fallback for development.
- Run inference for privacy-sensitive content without leaving the network.
- Drive AI-module features (assistants, RAG, moderation flows) from a local model.
- Support Drupal 10.2, 11 deployments of the AI module.
- Provide a low-cost local backend for prototyping AI features.
