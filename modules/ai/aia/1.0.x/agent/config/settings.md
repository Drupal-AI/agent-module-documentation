<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Install, settings & AI backend

## Install / enable
```
composer require drupal/aia
drush en aia -y
```
Requires the `ai` module (`drupal/ai:^1.2`) and core `node`, `field`, `taxonomy`, `block_content`, `views`, `menu_link_content`. PHP `>=8.4`, core `^10.2 || ^11`. `paragraphs` is only needed for `generate_paragraph_type`. `aia_install()` installs the `aia_task` entity schema (and `aia_update_9001` backfills its `session_id` field).

Grant the single permission **`administer aia`** (`aia.permissions.yml`, `restrict access: true`) — it gates every route, the Drush actions in practice, and is the entity `admin_permission`. There is no anonymous or lower-tier access.

## Settings form — `aia.settings`
Route `aia.settings` → `/admin/config/development/aia/settings` (`AiaSettingsForm`, a `ConfigFormBase`). Config object `aia.settings` (no schema file ships; keys are written directly):
- `auto_clear_cache` (bool, default TRUE) — clear Drupal cache after a successful apply.
- `enable_logging` (bool, default TRUE) — verbose logging of AIA operations to the `aia` watchdog channel.

The form also displays (read-only) the current AI service class so you can confirm Mock vs. real.

## Choosing the AI backend
The AI backend is a service alias, `aia.ai_request_service`, defined in `aia.services.yml`. **By default it is `MockAIRequestService`** — deterministic, keyword-matched JSON, no provider or API cost — ideal for development, demos, and the test suite.

To use a real LLM, edit `aia.services.yml`: comment out the Mock definition and uncomment the `AIRequestService` block (constructor arg `@aia.provider_resolver`), then `drush cr`:
```yaml
aia.ai_request_service:
  class: Drupal\aia\Service\AIRequestService
  arguments:
    - '@aia.provider_resolver'
```
`AiProviderResolver` (`aia.provider_resolver`) reads the `ai` module's **default chat provider** (`getDefaultProviderForOperationType('chat')`) — configure one at `/admin/config/ai/providers` (Anthropic, Gemini, OpenAI, etc.). If no provider is configured, `AIRequestService::request()` throws a `RuntimeException` with a clear message. Verify the active service any time with `drush aia:info`.

## Menu / navigation
Admin links (`aia.links.menu.yml`) sit under *Configuration › Development*: overview `aia.overview` (`/admin/config/development/aia`), with child links *Execute Actions* (`aia.execute`) and *Settings*. Task History is a report at `/admin/reports/aia`.
