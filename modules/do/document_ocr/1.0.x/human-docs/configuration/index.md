# Configuration

Document OCR is configured entirely under **Configuration → Structure → Document
OCR** (`/admin/config/structure/document-ocr`). You need the **Administer document
OCR** permission (grant it at **People → Permissions** to trusted roles only). The
setup has three moving parts — a **processor** (which talks to an OCR engine), a
**mapping** (which decides where the results go in Drupal), and, for most engines,
**credentials**. Because the exact fields vary by engine, the module's `README.md`
carries the engine-specific details (Google Document AI, OpenAI, Azure, Tesseract,
and so on); the outline below is the shape of the workflow.

## 1. Add a document processor

On the **document processor** listing, add a processor and choose the engine it
should use (for example Google Document AI, PDF Parser, Tesseract, PDFtoText,
docconv, or OpenAI). This is the component that actually reads the uploaded file and
returns text — and, for form-aware engines, individual extracted fields. You can add
more than one processor if you handle different document kinds.

## 2. Store the engine credentials securely

Most external engines need credentials, and these are **secrets** — keep them out of
committed configuration.

- For **API-key style engines** (OpenAI, Azure), prefer an environment variable. With
  DDEV:

  ```bash
  ddev dotenv set .ddev/.env --openai-api-key=YOUR_KEY
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.) Reference the variable from
  settings, or store it in a Key entity where the integration supports one.
- For **Google Cloud / Document AI**, supply the service-account credentials as the
  engine's setup requires (see the `README.md`), and store the credentials file
  outside the web root — ideally in the private filesystem — never in a
  publicly reachable or version-controlled location.

The companion provider modules follow their own credential pattern — see
[Document OCR AI21 Studio](../../../../document_ocr_ai21/1.0.x/human-docs/configuration/index.md)
and
[Document OCR Mindee](../../../../document_ocr_mindee/1.0.x/human-docs/configuration/index.md),
both of which read a JSON credentials file from the private filesystem.

## 3. Create a mapping

On the **mappings** listing (the page you land on), add a mapping that ties a
processor to a **Drupal entity type/bundle** and maps document properties (the fields
the OCR service returns) onto Drupal fields, using the built-in property-mapping tool.
This is what causes extracted values to be written into a node, media item, or other
entity when a document is processed.

## 4. Add transformers (optional)

Transformers preprocess or reshape the extracted data before it is saved. The module
ships **Basic**, **Pipeline**, and **OpenAI** transformer plugins; the **Pipeline**
transformer lets you stack multiple transformers and set their execution order (for
example: extract text, translate it, then summarize it). Add transformers to a
mapping where you want that extra processing.

## 5. Choose how processing runs

Document OCR can process **in real time** or via the **queue** (better for large
files or bulk runs), and it offers a **one-time import** tool that uses the same
mapping interface for a single ad-hoc import. You can also opt to **store the raw API
response as JSON** for debugging or reprocessing.

## Data-egress and cost reminder

Running a processor **sends the document content to the external service** and, for
paid APIs, **incurs cost per call**. Confirm that sending your documents off-site is
acceptable for their sensitivity, always use HTTPS endpoints, and restrict the
**Administer document OCR** permission to the people who should be able to configure
and trigger processing.
