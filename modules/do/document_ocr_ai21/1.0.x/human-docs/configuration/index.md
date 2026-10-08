# Configuration

Document OCR AI21 Studio has no settings form of its own. Configuring it means two
things: making your **AI21 API key** available as a private-filesystem credentials
file, and then **adding AI21 transformer plugins** to a Document OCR mapping and
pointing them at that file. Everything happens under **Configuration → Structure →
Document OCR** (`/admin/config/structure/document-ocr`), which requires the
**Administer document OCR** permission.

## 1. Get an AI21 API key

Create an AI21 Studio account and get your API key from
`https://studio.ai21.com/account/api-key`. Treat this key as a secret.

## 2. Store the key as a private-filesystem credentials file

This module reads its key from a JSON file in Drupal's **private filesystem** — not
from configuration — which keeps the secret out of your exported config and version
control. Create a file at:

```
private://document-ocr/ai21-credentials.json
```

with this content:

```json
{ "apikey": "YOUR_AI21_API_KEY" }
```

In practice `private://` maps to the private files directory configured in your site
settings (outside the web root). Place the file there — for example
`private/document-ocr/ai21-credentials.json` under your files path — and make sure
that directory is genuinely private (not web-accessible) and not committed to
version control.

> **Confirm the private filesystem is configured.** If your site does not yet have a
> private file path set (via the `file_private_path` setting in `settings.php` /
> `settings.local.php`), configure it first — otherwise `private://` will not
> resolve and the credentials file cannot be read.

## 3. Point the transformer plugins at the credentials file

In Document OCR, edit (or create) a mapping and **add an AI21 transformer** —
either the **Summarize** or the **Segmentation** transformer. When adding the
plugin, point it at the credentials file you created
(`private://document-ocr/ai21-credentials.json`). For a summary transformer you may
also supply an optional **focus** hint to steer what the summary emphasizes.

The transformer then runs as part of the OCR pipeline: Document OCR extracts the
text, and AI21 summarizes or segments it before the result is saved.

## Data-egress, TLS, and cost

- **Extracted text is sent to AI21.** The transformer posts the OCR-extracted text
  to `https://api.ai21.com/studio/v1/{summarize|segmentation}` over HTTPS with your
  key as a Bearer token. Confirm sending that content to a third-party service is
  acceptable for your data. TLS verification is on by default (it is not disabled).
- **Every run is billable.** Each transform is a paid AI21 API call, so restrict the
  **Administer document OCR** permission to the people who should be able to
  configure and trigger transformers.
- **Errors are logged.** AI21 API errors are recorded to the `document_ocr_ai21`
  logger channel, which is the first place to look if a transform fails.
