# Islandora Text Extraction: Actions, route, formatter, reindexer

## Actions (`src/Plugin/Action/`)

Both extend the Islandora Core abstract derivative actions (see the core
[plugins/context.md](../../../../../2.18.x/agent/plugins/context.md)); wire them into a Context Derivative
reaction on OCR-able objects.

| id | Class / base | Notable defaults |
|---|---|---|
| `generate_ocr_derivative` | extends `AbstractGenerateDerivative` | `queue=islandora-connector-ocr`, `mimetype=text/plain`, `source_term_uri=http://pcdm.org/use#OriginalFile`, `derivative_term_uri=http://pcdm.org/use#ExtractedText`, `destination_media_type=extracted_text`, `scheme=fedora`, `path=[date:custom:Y]-[date:custom:m]/[node:nid]-[term:name].txt` |
| `generate_extracted_text_file` | extends `AbstractGenerateDerivativeMediaFile` | attaches the extracted-text file to an existing media |

The emitted event is consumed by the **Hypercube** microservice, which OCRs/extracts and PUTs the result
back.

## OCR writeback route (`islandora_text_extraction.routing.yml`)

```
PUT|GET /media/add_ocr/{media}/{destination_field}/{destination_text_field}
  controller: Drupal\islandora_text_extraction\Controller\MediaSourceController::attachToMedia
  access:     \Drupal\islandora\Controller\MediaSourceController::attachToMediaAccess  (media 'update')
  auth:       [basic_auth, cookie, jwt_auth]   no_cache: TRUE
```

Unlike the core `attach_file_to_media` route, this one takes an extra `{destination_text_field}` so the
microservice can write both the text **file** and a text **field** on the media in one call. Access is the
same as core (the caller must have `update` on the media; microservices authenticate with a JWT).

## Field formatter

`ocr_formatter` (`OcrTextFormatter`, `@FieldFormatter(id="ocr_formatter")`, `field_types = {file}`) renders
an OCR/hOCR file field as readable text output on the media/entity display.

## Search reindexing

`islandora_text_extraction.search_reindexer` → `SearchReindexer` (args `@islandora.utils`, logger). When OCR
text is added/updated, it triggers Search API reindexing of the affected node so the extracted text becomes
full-text searchable.

## Getting a working setup fast

Enable `islandora_text_extraction_defaults` (a sibling submodule) to import a ready-made `extracted_text`
media type, the text/file fields, and a Context wiring `generate_ocr_derivative` to OCR-able models, instead
of building it by hand.
