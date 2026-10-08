<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Model Registry (ai_model_registry) — agent index

**Drupal-native catalog of AI provider/model metadata (capabilities, pricing, lifecycle, governance, deployment) as config entities, consumed by runtime governance/budget modules.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI  •  **Depends on:** `system`
- **Entity:** `ai_model_registry_model` config entity, keyed `provider_id__model_id`; full add/edit/delete UI under Configuration » AI.
- **Service:** `ai_model_registry.model_metadata_repository` (`ModelMetadataRepository`) — normalized lookups + adapter merge.
- **Plugin type:** `ModelMetadataAdapter` (external metadata sources). Seed config: OpenAI, Ollama×2, LM Studio.
- **Permission:** `administer ai_model_registry` (restricted).
- **Security:** Managed only via the restricted entity UI; no anonymous/mutating public routes; stores metadata only, calls no provider and stores no API keys. No security findings.

See [plugins/adapters.md](plugins/adapters.md).
