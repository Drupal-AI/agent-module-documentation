<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Google translation provider

**Route:** `/admin/config/regional/google` (`administer site configuration`).

## Steps
1. In Google Cloud: create a project, enable the **Cloud Translation API**, and create a service account with translation access; download its JSON key.
2. Upload that JSON in **Google API Credentials** — the field is a `managed_file` with `#upload_location => 'private://'` and a `json` extension validator, so it is stored in the private filesystem and marked permanent on save.
3. Set **Project ID** (`google_api_project`) and **Location** (`google_location`, e.g. `global`).
4. (Optional) For each language enter a **Glossary** id (`google_api_glossary_mappings_<langcode>`) and toggle **Case sensitive**.

## Runtime behavior
- `GoogleTranslationApi::translate($text, $from, $to)` builds `locationName(project, location)` and calls `translateText()`.
- Text > 20,000 chars is split and translated recursively.
- With a glossary configured, a `TranslateTextGlossaryConfig` is added (`ignore_case = !case_sensitive`).
- Return value has HTML entities decoded; on error the original text is returned.

## Security
Keep the private filesystem correctly protected — it holds the service-account credentials. No API key is exposed in the browser; auth is via the SDK using the uploaded JSON.
