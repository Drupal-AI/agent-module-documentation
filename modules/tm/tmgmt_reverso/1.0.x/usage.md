<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reverso Translator adds a Reverso machine-translation backend to the Translation Management Tool (TMGMT), so Drupal content can be sent to Reverso directly from the TMGMT workflow.
---
The module registers a `reverso` TMGMT translator plugin (`ReversoTranslator`, continuous-translation capable). When a TMGMT job runs, each translatable string is POSTed to the configured Reverso endpoint — plain text to `/v1/TranslateText/direction={src}-{tgt}` and HTML to `/v1/TranslateStream/.../inputExtension=html` (the streamed response is base64-decoded). Requests are authenticated with a per-request HMAC-SHA1 signature computed as `hmac_sha1(username + RFC-date, password)` and sent in `Username`/`Created`/`Signature` headers, so the password itself is used only as the signing key and is not transmitted. A default Drupal→Reverso language-code map (ISO 639-1 → 639-2/B) is provided and can be overridden per translator via TMGMT's Remote languages mappings.

Setup: at `/admin/tmgmt/translators` add a translator using the Reverso plugin, enter the Username, Password and endpoint URL (HTTPS strongly recommended since the signed request travels over the wire), and adjust language mappings if needed. The plugin then appears as a translator choice on any TMGMT job. Outbound calls use Drupal's default Guzzle client with TLS verification enabled; there are no inbound callbacks or public routes.
---
- Machine-translate Drupal content via Reverso through TMGMT.
- Add a Reverso translator at `/admin/tmgmt/translators`.
- Enter Reverso username, password and endpoint URL.
- Translate nodes, taxonomy terms, config and custom entities.
- Send plain-text strings to Reverso's TranslateText API.
- Send HTML payloads to Reverso's TranslateStream API.
- Run continuous TMGMT jobs that stay open for more items.
- Map Drupal language codes to Reverso codes.
- Override the default language mapping per translator.
- Authenticate with an HMAC-SHA1 signed request.
- Choose target languages on a TMGMT job and submit to Reverso.
- Store translated results back on the source entity.
- Support Drupal 10 and 11 with PHP 8.1+.
- Use HTTPS endpoints to protect the signed request.
- Translate from/to languages outside the default map via mappings.
- Integrate Reverso into an existing TMGMT translation pipeline.
- Reject a job gracefully when Reverso returns an error.
- Batch-translate many strings within one job item.
- Decode base64 HTML translation responses automatically.
- Swap translation providers by choosing a different TMGMT translator.
