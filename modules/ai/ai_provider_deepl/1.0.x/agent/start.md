<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepL Provider (ai_provider_deepl) — agent index

**DeepL** provider plugin for Drupal's **`ai`** module. It exposes DeepL's **text-translation
API** as the AI module's **`translate_text`** operation and nothing else — it is not a
chat/LLM provider. Requires **`ai`** and **`key`** plus the official **`deeplcom/deepl-php`**
library. Version **1.0.0-alpha3** (an **alpha**, not security-advisory covered). Core `^10.2 || ^11`.

## What it actually is
- One provider plugin: `src/Plugin/AiProvider/DeepLProvider.php`, id **`deepl`**, extends
  `AiProviderClientBase`, implements `TranslateTextInterface` + `ContainerFactoryPluginInterface`.
- `getSupportedOperationTypes()` returns exactly **`['translate_text']`**.
- `getConfiguredModels()` returns a single pseudo-model **`default`** ("Default") — DeepL has no
  model list; the AI module still needs a model id, so `default` is it.
- The provider wraps the **`\DeepL\Translator`** client from `deeplcom/deepl-php`. All HTTP goes
  through that SDK; this module writes no HTTP client of its own.

## Where things live
- Provider mechanism (client, key loading, translateText, options): **agent/providers/operations.md**
- Config form, API key via Key module, language variants, default-provider wiring: **agent/config/setup.md**
- Config route `ai_provider_deepl.settings_form` → `/admin/config/ai/providers/deepl`,
  permission **`administer ai providers`** (admin-gated). Menu link under `ai.admin_providers`.
- `config/install/ai_provider_deepl.settings.yml` — `api_key` (a Key entity id) + `language_variants`.
- `definitions/api_defaults.yml` — the `translate_text` parameter schema surfaced via `getApiDefinition()`.

## Facts an agent should not get wrong
- **The API key is a Key entity id**, resolved server-side at call time via
  `keyRepository->getKey(...)->getKeyValue()`. The config stores only the key **name**, never the secret.
- **Free vs Pro endpoint is auto-selected by the SDK** from the key itself (a `:fx` suffix = free tier
  → `api-free.deepl.com`, otherwise `api.deepl.com`). This module exposes **no** base-URL / server-URL
  override — there is nothing to point at an arbitrary host.
- **Language variants**: DeepL wants a specific target for `en`, `pt`, `zh` (e.g. `en-GB` vs `en-US`).
  The config form lets an admin pick the variant per language; `translateText()` rewrites the target
  language to the chosen variant before calling DeepL. Source language has its regional variant
  stripped (`LanguageCode::removeRegionalVariant`).
- On any SDK exception, `translateText()` returns a `TranslateTextOutput` with an empty result, the
  original text, and the exception message as the error — it does not throw.
- The stray `@var \OpenAI\Client` / "OpenAI client" docblocks in the source are copy-paste leftovers;
  the real client is `\DeepL\Translator`. Ignore them.
