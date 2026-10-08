<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Supertext AI translator is a TMGMT provider plugin that sends TMGMT job items to the Supertext AI translation service and writes the returned translations back into the job.

---

The plugin (`@TranslatorPlugin("supertext_ai")`) is configured like any TMGMT translator: an **API key**, an **API server** (Live / Development / Testing / Other), and an optional custom server URL. `requestTranslation()` flattens each job item's translatable data, chunks it under a 10 000-character limit (`SupertextAiData`), and POSTs each chunk to the `text` endpoint with an `Authorization: Supertext-Auth-Key <key>` header over HTTPS via Guzzle (default TLS verification; a 60-second timeout). Responses are decoded with `JSON_THROW_ON_ERROR` and unflattened back onto the job item; any exception rejects the job with the error message. The config form's validate step sends a dummy `text/quote` request to verify credentials before saving.

Operational notes: the API key is stored in the TMGMT translator config entity (`tmgmt.translator.settings.supertext_ai`) as a plain string — standard TMGMT behaviour, so treat exported config as sensitive. The endpoint URL is derived from the server setting (`https://api.supertext.com/v1/translate/ai/` for Live, `https://api.<env>.supertext.com/...` otherwise, or a free-form URL when "Other" is chosen). Typical setup: install TMGMT, add a translator of type "Supertext AI translator", paste the key, pick a server, save (which validates), then use standard TMGMT job workflows.

---

- Add a TMGMT translator using the Supertext AI plugin
- Paste a Supertext API key and validate it on save
- Choose the Live, Development, or Testing Supertext API server
- Point at a custom Supertext endpoint via the "Other" URL option
- Translate node content through the standard TMGMT job UI
- Machine-translate any TMGMT-enabled entity via Supertext
- Submit a translation job and have it auto-marked submitted
- Batch-translate large fields split into <10k-character chunks
- Preserve HTML tag structure during translation (tag_handling=html)
- Map Drupal source/target langcodes to Supertext language pairs
- Inspect Supertext request payloads via the debug log channel
- Check translator availability based on presence of an API key
- Reject a job automatically when the API returns an error
- Verify credentials with a dummy quote request before saving config
- Integrate Supertext into a multilingual content workflow
- Use TMGMT continuous jobs backed by Supertext
- Translate multiple job items in one request loop
- Store the API key in exportable TMGMT translator config
- Set a per-request politeness/glossary via SupertextAiData (API)
