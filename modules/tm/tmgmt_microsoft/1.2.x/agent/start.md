<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Translator (tmgmt_microsoft) — agent index

A TMGMT translator plugin that sends translation jobs to the Azure Cognitive Services Translator
Text API v3. Depends on `tmgmt`. `configure` = `entity.tmgmt_translator.collection`. No permissions
of its own, no Drush. Provides a config schema.

- **Create the translator entity, settings (`api_key`, `auto_accept`), endpoints & request flow** →
  [configure/translator.md](configure/translator.md)

Key facts:
- Plugin `@TranslatorPlugin(id = "microsoft")` →
  `Drupal\tmgmt_microsoft\Plugin\tmgmt\Translator\MicrosoftTranslator` (continuous translator).
  UI class `MicrosoftTranslatorUi`.
- Settings (schema `tmgmt.translator.settings.microsoft`): `api_key` (Azure key, required),
  `auto_accept` (bool). Key validated via Connect button (`getToken()`).
- Endpoints are **hardcoded plugin defaults**: token `https://api.cognitive.microsoft.com/sts/v1.0/issueToken/`,
  translate `https://api.cognitive.microsofttranslator.com`.
- Flow: subscription key → JWT token → POST `/translate?textType=html&from=&to=&api-version=3.0`
  via Guzzle `http_client`. 50k char/segment cap; `<span class="notranslate">` guards.
- `tmgmt_microsoft_test/` is a test-only fixture module (not documented separately).
