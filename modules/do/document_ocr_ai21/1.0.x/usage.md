<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Document OCR AI21 Studio is a submodule/transformer for the Document OCR module that runs AI21 Studio's NLP API over OCR-extracted document text — currently text summarization and text segmentation.

---

The module provides an `AI21` service (`document_ocr_ai21.client`) built with Guzzle and the logger factory. Credentials are not stored in module config: an administrator uploads a JSON file (`{"apikey":"..."}`) to the private filesystem at `private://document-ocr/ai21-credentials.json`, and each AI21 transformer plugin is pointed at that credentials file. The service reads the api key from the injected credentials and calls the AI21 REST endpoint (`https://api.ai21.com/studio/v1/{summarize|segmentation}`) over HTTPS with a Bearer token, sending a `sourceType`/`source` payload (plus optional `focus` for summaries). Responses are JSON-decoded and returned; API-side errors (`detail`) are thrown and logged to the `document_ocr_ai21` channel. It is configured alongside Document OCR at `/admin/config/structure/document-ocr`.

Operationally there are no routes, forms, or permissions of its own — the surface is the transformer plugin pipeline provided by Document OCR. TLS is not disabled (default Guzzle verification over the HTTPS endpoint), and the api key lives in a private-filesystem JSON file rather than plaintext config. Each transform is a billable AI21 API call, so control who can configure/run the OCR transformers.

---

- Summarize OCR-extracted document text via AI21 Studio.
- Segment OCR-extracted text into structured sections via AI21.
- Add AI21 transformer plugins to a Document OCR pipeline.
- Store the AI21 api key in a private-filesystem JSON credentials file.
- Point each transformer plugin at the AI21 credentials file.
- Provide an optional `focus` hint to steer a summary.
- Configure the integration under `/admin/config/structure/document-ocr`.
- Call the AI21 `summarize` endpoint over HTTPS with Bearer auth.
- Call the AI21 `segmentation` endpoint over HTTPS with Bearer auth.
- Log AI21 API errors to the `document_ocr_ai21` channel.
- Keep the api key out of exported configuration.
- Inject the `document_ocr_ai21.client` service in custom code.
- Post-process scanned documents into readable summaries.
- Bound AI21 API cost by restricting who configures OCR transformers.
- Send `sourceType`/`source` payloads to the AI21 studio API.
- Rely on default Guzzle TLS verification for the AI21 endpoint.