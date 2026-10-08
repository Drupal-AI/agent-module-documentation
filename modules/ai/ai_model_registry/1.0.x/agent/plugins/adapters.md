<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Model Registry — metadata adapters & repository

**Config entity:** `ai_model_registry_model`, keyed by compound `provider_id__model_id`. Fields: capabilities (chat, embeddings, structured output, tool use, vision), `cost_prompt_1k`, `cost_completion_1k`, `data_residency`, `uses_input_for_training`, `risk_level`, `eol` (lifecycle), `local`, and a free-form `metadata` map.

**Repository:** `ai_model_registry.model_metadata_repository` (`ModelMetadataRepository`, constructed with `@entity_type.manager` and the adapter plugin manager) normalizes each record into a predictable array shape and merges adapter-contributed records with stored entities. Other modules call it for lookups.

**Adapter plugin type:** `ModelMetadataAdapter` (annotation + attribute variants; manager `plugin.manager.ai_model_registry_model_metadata_adapter`). Implement one to feed metadata from an external source (remote gateway, provider API, spreadsheet) without editing this module; base class `ModelMetadataAdapterPluginBase`.

Consumers such as AI Policy Gateway read this catalog rather than maintaining their own.
