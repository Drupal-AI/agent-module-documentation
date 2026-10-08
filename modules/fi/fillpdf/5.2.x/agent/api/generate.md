# Generating a PDF (URL, access, services)

## The generate URL

Route `fillpdf.populate_pdf` → **`/fillpdf`**, handled by `HandlePdfController::populatePdf()`. Driven by
query parameters parsed by `FillPdfLinkManipulator`:

| Param | Meaning |
|---|---|
| `fid` | **Required.** The `fillpdf_form` id. Missing/unknown → `InvalidArgumentException` → forbidden. |
| `entity_id` | Single entity as `type:id` (e.g. `node:42`). Bare id → defaults to `entity_type` or `node`. |
| `entity_ids[]` | Multiple entities (`type:id` each). |
| `entity_type` | Default entity type for bare ids (default `node`). |
| `download` | Truthy → force a download response (`force_download`). |
| `flatten` | Default **TRUE**; `flatten=0` keeps form fields fillable. |
| `sample` | Truthy → render sample/blank PDF (admins only). |

If no entities and no sample are given, the form's `default_entity_type`/`default_entity_id` are used.
Build links in code with `FillPdfLinkManipulator::generateLink(['fid' => …, 'entity_ids' => …, …])`.

## Access control (`FillPdfAccessController::checkLink` → `FillPdfAccessHelper`)

`canGeneratePdfFromContext($context, $account)`:

1. `administer pdfs` **or** `publish all pdfs` → **allowed** (cached per user + permissions).
2. `sample` request → allowed only for admins.
3. `publish own pdfs` (non-sample) → loads every entity in the context and **denies if the user cannot
   `view` any of them**; otherwise allowed.
4. Otherwise → **forbidden**.

So a low-privileged user can only generate PDFs from content they are already allowed to view. On a
parse error the message is shown verbatim to admins, generic to others.

## Merge pipeline

`populatePdf()`:
1. `FillPdfLinkManipulator::parseRequest()` → context (`fid`, `entity_ids`, `flatten`, `sample`, …).
2. `hook_fillpdf_populate_pdf_context_alter($context)` (see hooks doc).
3. Load the `FillPdfForm` and the context entities (`FillPdfContextManager::loadEntities`).
4. `BackendProxy::merge($form, $entities, $context)` → resolves each `FillPdfFormField` to a
   Text/Image mapping (tokens replaced) and calls the active `PdfBackend::mergeFile()`.
5. Build the token-replaced filename (`buildFilename`).
6. `handlePopulatedPdf()` picks a **FillPdfActionPlugin** — `download` (no scheme, or scheme
   unavailable/not allowed), else `save` or `redirect` (if `destination_redirect`). `download=1` also
   returns the download response after side effects.

## Useful services

| Service id | Interface | Use |
|---|---|---|
| `fillpdf.link_manipulator` | `FillPdfLinkManipulatorInterface` | Parse/generate FillPDF links. |
| `fillpdf.access_helper` | `FillPdfAccessHelperInterface` | `canGeneratePdfFromUrlString/Link/Context()`. |
| `fillpdf.context_manager` | `FillPdfContextManagerInterface` | Turn a context into loaded entities. |
| `fillpdf.backend_proxy` | `BackendProxyInterface` | Run a merge through the configured backend. |
| `fillpdf.input_helper` | `InputHelperInterface` | `attachPdfToForm()` / `parseFields()`. |
| `fillpdf.output_handler` | `OutputHandlerInterface` | `savePdfToFile()`. |
| `fillpdf.token_resolver` | `TokenResolverInterface` | Replace tokens against entities. |
| `plugin.manager.fillpdf.pdf_backend` | `PdfBackendManager` | Instantiate a backend plugin. |
| `plugin.manager.fillpdf_action.processor` | `FillPdfActionPluginManager` | Instantiate an action plugin. |

Example — generate and get a link programmatically:

```php
$url = \Drupal::service('fillpdf.link_manipulator')->generateLink([
  'fid' => 3,
  'entity_ids' => ['node:42'],
  'force_download' => TRUE,
])->toString();
```
