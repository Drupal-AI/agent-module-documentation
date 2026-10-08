<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document OCR AI21 Studio (document_ocr_ai21) — agent index

**Runs AI21 Studio NLP (summarize / segmentation) over OCR-extracted document text.**

- **Version:** 1.0.x (1.0.0-beta3) · **Core:** ^9.5 || ^10 || ^11 · requires `document_ocr`
- **Service:** `document_ocr_ai21.client` → `src/AI21.php` (Guzzle + logger); methods `getSummary($sourceType,$value,$focus)`, `getSegmentedText($sourceType,$value)`.
- **Endpoint:** `https://api.ai21.com/studio/v1/{summarize|segmentation}` over HTTPS with Bearer auth.
- **Credentials:** JSON file `private://document-ocr/ai21-credentials.json` (`{"apikey":"..."}`), referenced per transformer plugin — not stored in config.
- Configured via Document OCR at `/admin/config/structure/document-ocr`.

**Security:** no routes/permissions of its own; TLS not disabled (default Guzzle verification on an HTTPS endpoint); api key kept in a private-filesystem JSON file, not plaintext config. Each call is billable — restrict who can configure/run OCR transformers.

See [api/ai21.md](api/ai21.md)