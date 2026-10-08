<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure AI Entity Intake

**Settings** `/admin/config/ai/entity-intake` (`administer ai entity intake`): sets the module-wide default `provider_model` (a drupal/ai simple-option string) used when a profile has no override.

**Entity definitions** (`ai_entity_definition`, config entity) `/admin/config/ai/entity-intake/definitions`: describe a target entity type/bundle and the fields the AI may fill, including per-field model overrides used by the multi-pass extractor.

**Intake profiles** (`ai_intake_profile`, config entity) `/admin/config/ai/entity-intake/profiles`: scope which definitions a profile may create and set a profile-level `provider_model` override. Each profile mints a dynamic `use ai intake profile {id}` permission (via `AiIntakePermissions::profilePermissions`) — grant it to the roles allowed to submit intakes against that profile.

**Provider resolution** (`LlmClient::resolveProvider`): profile override → module `provider_model` setting → AI module default for the `chat_with_structured_response` pseudo-type.

**Workflow:**
1. A profile-holder creates an `ai_intake` at `/admin/content/ai-intake/add` (route gated by `ai_entity_intake.intake_access:create`).
2. Cron runs the `ai_entity_intake_extraction` queue; `MultiPassExtractor` calls the AI provider and stores normalized suggestions.
3. Reviewers (`review ai entity intake suggestions`) open `/…/{ai_intake}/review`, then **Use** a suggestion → redirected to the bundle's native add form, pre-filled by `hook_entity_prepare_form`; saving creates a draft entity. `create entities from ai intake` plus the target entity's own create access are both required.
4. Failed/dismissed intakes can be requeued.

**Access matrix** (`AiIntakeAccessControlHandler`): view/delete = `view any ai intake` OR (owner AND still a profile-holder); update = `view any ai intake` only; review = `review ai entity intake suggestions`.
