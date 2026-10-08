<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Model Registry is a Drupal-native catalog of AI provider/model metadata — capabilities, pricing, lifecycle, data residency, training-use and local-deployment attributes — so governance, routing, budget, and dashboard modules can decide without hard-coding provider details.
---
Each `ai_model_registry_model` configuration entity describes one provider/model pair, keyed by a compound `provider_id__model_id`. A repository service (`ai_model_registry.model_metadata_repository`) normalizes every record into a predictable array shape and merges records contributed by `ModelMetadataAdapter` plugins, letting other modules feed metadata from a remote gateway, provider API, or spreadsheet without touching this module. A full entity UI (list/add/edit/delete) manages the catalog under Configuration » AI. Fields cover capabilities (chat, embeddings, structured output, tool use, vision), cost (`cost_prompt_1k`, `cost_completion_1k`), governance (`data_residency`, `uses_input_for_training`, `risk_level`), lifecycle (`eol`), a `local` flag, and a free-form `metadata` map. Four seed models (OpenAI, Ollama x2, LM Studio) ship as default config.

The module is intentionally standalone: runtime modules such as AI Policy Gateway and an evaluation harness consume its metadata instead of owning their own catalog. Management is gated by the restricted `administer ai_model_registry` permission through the standard entity UI; there are no anonymous or mutating public endpoints, and no provider is called (it stores metadata only, no API keys).
---
- Maintain one catalog of AI provider/model metadata for the whole site.
- Record model capabilities (chat, embeddings, structured output, tool use, vision).
- Store per-model cost fields for budget estimation.
- Track governance attributes: data residency, training-use, risk level.
- Flag deprecated or retiring models via the `eol` lifecycle field.
- Mark self-hosted models with the `local` flag.
- Add provider-specific attributes in the free-form metadata map.
- Let other modules read normalized model lookups via the repository service.
- Feed metadata from external sources with a ModelMetadataAdapter plugin.
- Merge adapter-contributed records with locally stored ones.
- Add, edit, or delete model records in the entity UI.
- Key records by compound `provider_id__model_id`.
- Seed the catalog with OpenAI, Ollama, and LM Studio defaults.
- Supply model metadata to AI Policy Gateway for governance decisions.
- Drive routing/budget decisions from a single source of truth.
- Avoid hard-coding provider details across runtime modules.
- Restrict catalog management to admins via a restricted permission.
- Export the catalog as configuration for deployment.
- Signal an end-of-life model to health/monitoring tooling.
