<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Node Translate Google is a provider plugin that lets the Auto Node Translate module machine-translate node content using the Google Cloud Translation v3 API, with optional glossary support.
---
The module implements an `AutoNodeTranslateProvider` plugin (`GoogleTranslationApi`) that calls Google's `TranslationServiceClient` (v3) to translate field text between languages. It authenticates with a Google Cloud service-account credentials JSON file that the administrator uploads through the settings form; the project id and location are also configured there. Text longer than 20,000 characters is chunked and translated recursively. When a per-target-language glossary id is configured, the provider passes a `TranslateTextGlossaryConfig` (with case sensitivity controlled by the `case_sensitive` setting) so translations honor a controlled vocabulary.

Operationally the settings form lives at `/admin/config/regional/google` and is gated by the core `administer site configuration` permission. Security posture is sound: the uploaded service-account credentials file is stored via a `managed_file` element with `#upload_location => 'private://'`, so the sensitive JSON goes to the private filesystem rather than a web-accessible directory, and the file is only accepted with a `json` extension. Translation calls go through the official Google Cloud PHP SDK (TLS handled by the SDK; no `verify => false` in module code). The credentials file id is stored in config; ensure the private filesystem is correctly protected.
---
- Enable Auto Node Translate and this Google provider.
- Create a Google Cloud project and enable the Translation API.
- Generate a service-account credentials JSON with Translate permissions.
- Upload the credentials JSON at `/admin/config/regional/google`.
- Set the Google Cloud project id and location (e.g. `global`).
- Select Google as the provider for auto node translation.
- Translate node fields from a source to a target language automatically.
- Configure a glossary id per target language for controlled terms.
- Toggle case-sensitive glossary matching.
- Translate long text (module chunks at 20,000 characters).
- Keep the service-account JSON in `private://` (module enforces this).
- Restrict the settings form via `administer site configuration`.
- Combine with Content Translation for multilingual nodes.
- Review translated output (HTML entities are decoded on return).
- Rotate the service-account key by re-uploading a new JSON.