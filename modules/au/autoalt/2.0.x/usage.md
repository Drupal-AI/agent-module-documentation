<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AutoAlt.ai generates AI-powered alt text for image files by sending them to the AutoAlt.ai API, for both single images and bulk runs.

---

Configure the AutoAlt.ai **API key** at `/admin/config/content/autoalt` (permission `administer site configuration`). The main workflow is a controller (`AutoaltController`) exposing several JSON endpoints under `/api/autoalt/*`: `generate` produces alt text for a file, `save-alt` writes it back to image/media fields, and various counters (`list-fids`, `availcredit`, `totalImagesCount`, `shortAltTextCount`, `processedByAutoaltCount`) drive the bulk UI at `/admin/config/media/autoalt/bulk-alt`. Most admin/bulk endpoints require `administer site configuration` or `administer media`; a history page/API is exposed under `access content`.

The `generate` endpoint reads a POSTed `fid`, loads that file, base64-encodes its bytes and posts them (with the site's stored `api_key`) to the AutoAlt.ai service; the returned alt text is applied to the image. Outbound calls use HTTPS with default TLS verification.

---
- Enter the AutoAlt.ai API key at `/admin/config/content/autoalt`
- Generate alt text for a single uploaded image
- Bulk-generate alt text at `/admin/config/media/autoalt/bulk-alt`
- Save generated alt text back to image fields
- Save generated alt text back to media entities
- Filter bulk runs by language
- Skip images already processed by AutoAlt
- Target only images with short/missing alt text
- View remaining AutoAlt credits
- Count total images / short alt-text images on the site
- Review the processing history page (`/admin/content/autoalt/history`)
- Query the history API for processed files
- Provide SEO keywords / negative keywords to guide generation
- Choose a default language for generated alt text
- Restrict the admin/bulk endpoints to trusted administrators
