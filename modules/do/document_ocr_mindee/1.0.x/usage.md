<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Mindee's cloud document-parsing API as an OCR provider for the Document OCR framework, extracting structured fields from receipts, invoices, IDs and similar documents.

---

Document OCR Mindee is a thin provider plugin that plugs the Mindee SaaS parsing API into the Document OCR (`document_ocr`) framework. It registers one processor plugin (`mindee`) that takes an uploaded PDF or image, base64-encodes it, and POSTs it to the appropriate Mindee product endpoint (for example expense receipts, invoices, financial documents, passports, proof of address, bank checks or license plates). Mindee returns JSON predictions; the plugin flattens each prediction into a named option/value pair on the Document OCR mapping and also assembles a combined "Extracted Text" value. Which Mindee product API and version to call is chosen per processor in the Document OCR admin UI, populated from a bundled `repository/apis.json` catalog. The Mindee API key is supplied through a JSON credentials file whose path is set on the processor. The module ships no routes, permissions, entities, config objects or Drush commands of its own — it relies entirely on `document_ocr` for the OCR task workflow, storage and admin screens.

---

- Extract structured data from uploaded documents using Mindee's cloud OCR instead of a local/self-hosted engine.
- Add a "Mindee" processor option in the Document OCR framework's processor configuration.
- Parse expense receipts and bills into fields via Mindee's `expense_receipts` product (v3/v4/v5).
- Parse invoices into structured fields via the `invoices` product (v2/v3/v4).
- Parse mixed receipts-and-invoices via the `financial_document` product (v1).
- Extract data from international passports (`passport`) and Indian passports (`indian_passport`).
- Extract data from French ID cards (`idcard_fr`) and Carte Vitale (`carte_vitale`).
- Parse delivery notes for customer/supplier/delivery information (`delivery_notes`).
- Extract recipient/issuer data from proof-of-address documents such as utility bills and bank statements (`proof_of_address`).
- Extract key fields from paper and digital bank checks (`bank_check`).
- Read vehicle registration numbers from license-plate images (`license_plates`).
- Process common document formats: PDF, HEIC, TIFF/TIF, JPG/JPEG, PNG and WEBP.
- Store the raw Mindee prediction JSON alongside a document (the plugin supports `store_json`).
- Populate a combined "Extracted Text" field from all non-empty predictions for indexing or display via the framework.
- Map individual Mindee prediction fields (e.g. total amount, date, supplier) to Document OCR options for downstream mapping.
- Pin a specific Mindee product API version per processor for stable, reproducible extraction.
- Keep the Mindee API key out of Drupal configuration by storing it in a JSON credentials file (e.g. under `private://`).
- Run several Mindee processors side by side, each targeting a different document type/product API.
- Automate document data entry (receipts, invoices, IDs) as part of a Document OCR task pipeline.
- Prototype AI-assisted document intake without deploying an on-premise OCR stack.
