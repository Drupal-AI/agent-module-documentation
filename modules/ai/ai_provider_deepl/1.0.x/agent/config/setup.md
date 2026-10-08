<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & setup — ai_provider_deepl

## API key (via Key module)
1. Get a DeepL API key (Free or Pro) from your DeepL account.
2. Create a **Key** entity holding that value (Key module; env-provider or file-provider recommended
   so the secret is not stored in config/DB).
3. Visit **`/admin/config/ai/providers/deepl`** (route `ai_provider_deepl.settings_form`, permission
   **`administer ai providers`**) and select that Key in the **DeepL API Key** field (`key_select`).

The config object **`ai_provider_deepl.settings`** stores only the Key entity **name** in `api_key`,
never the secret. At translation time `DeepLProvider::loadApiKey()` resolves it server-side with
`keyRepository->getKey($name)->getKeyValue()`. The key is never written to config, logs,
`drupalSettings`, or markup. Free vs Pro endpoint is derived from the key itself by the DeepL SDK — no
endpoint setting is exposed here.

## Language variants
DeepL requires a specific regional target for three languages. The form
(`src/Form/DeepLConfigForm.php`, `LANGUAGE_VARIANTS`) offers a select per language, saved under
`ai_provider_deepl.settings:language_variants`:
- **en** → `en-gb` (British) or `en-us` (American)
- **pt** → `pt-br` (Brazilian) or `pt-pt` (other Portuguese)
- **zh** → `zh-hans` (simplified) or `zh-hant` (traditional)

`translateText()` remaps a target language to the chosen variant before calling DeepL.

## Becoming the default translate_text provider
On form submit, `submitForm()` calls
`aiProviderManager->defaultIfNone('translate_text', 'deepl', 'default')` — so DeepL becomes the AI
module's default `translate_text` provider **only if no default is already set**. It never overrides
an existing default.

## Config schema & install defaults
- `config/schema/ai_provider_deepl.schema.yml` types `api_key` (string) and `language_variants` (a
  mapping of language code → variant string).
- `config/install/ai_provider_deepl.settings.yml` ships `api_key: ''` and empty `en`/`pt`/`zh`
  variants — the module is installed but **not usable** until a key is selected (`isUsable()` returns
  FALSE with no `api_key`).

## Consuming it
Any code/module that uses the AI module's `translate_text` operation (e.g. via the AI provider plugin
manager, or a translation workflow that routes through the AI module) will use DeepL once it is the
selected/default provider. This module adds no UI for translating content itself — it only registers
the provider.
