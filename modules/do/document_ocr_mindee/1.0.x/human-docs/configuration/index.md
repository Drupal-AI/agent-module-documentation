# Configuration

Document OCR Mindee has no settings form of its own. Configuring it means two things:
making your **Mindee API key** available as a private-filesystem credentials file,
and then **adding a Mindee processor** in Document OCR and pointing it at that file.
Everything happens under **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`), which requires the **Administer document
OCR** permission.

## 1. Get a Mindee API key

Create a Mindee account and generate an API key from your Mindee dashboard at
[mindee.com](https://www.mindee.com/). Treat this key as a secret.

## 2. Store the key as a private-filesystem credentials file

This module reads its key from a JSON file in Drupal's **private filesystem** — not
from configuration — which keeps the secret out of your exported config and version
control. Create a file at:

```
private://document-ocr/mindee-credentials.json
```

with this content:

```json
{ "apikey": "YOUR_MINDEE_API_KEY" }
```

In practice `private://` maps to the private files directory configured in your site
settings (outside the web root). Place the file there — for example
`private/document-ocr/mindee-credentials.json` under your files path — and make sure
that directory is genuinely private (not web-accessible) and not committed to version
control.

> **Confirm the private filesystem is configured.** If your site does not yet have a
> private file path set (via the `file_private_path` setting in `settings.php` /
> `settings.local.php`), configure it first — otherwise `private://` will not
> resolve and the credentials file cannot be read.

## 3. Add the Mindee processor

In Document OCR, add a **document processor** and choose **Mindee**. When adding the
processor, point it at the credentials file you created
(`private://document-ocr/mindee-credentials.json`). Then use the processor in a
mapping so that extracted fields are written into your chosen Drupal entity.

## Data-egress and cost

- **Documents are sent to Mindee.** Processing uploads the document to Mindee's API
  over HTTPS for parsing. Confirm that sending the content to a third-party service
  is acceptable for your data.
- **Restrict who can run it.** Mindee is a paid API, so limit the **Administer
  document OCR** permission to the people who should be able to configure and trigger
  processing.
