<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transformer plugins (`document_ocr_transformer`)

Ship in `src/Plugin/document_ocr/transformer/`. A transformer post-processes a single extracted
property value before it is written to a destination field. Wired through a
`document_ocr_transformer` **config entity** (label, plugin id, `credentials`, `configuration`);
the mapping tool assigns a transformer entity id per mapped field. All extend `TransformerBase`;
the contract is `transform($value)`. The module installs one transformer config entity by default:
`default` (label "Default", plugin `basic`).

| id | Name | group | Purpose |
|----|------|-------|---------|
| `basic` | Basic | General | Trim and/or string manipulation of the value before storage (default transformer). |
| `pipeline` | Pipeline | General | Stack multiple transformer config entities and run them in a configured order. |
| `truncate` | Truncate | General | Safely truncate a UTF-8 string to a maximum number of characters. |
| `encoding_converter` | Encoding Coverter | General | Convert text from one character encoding to another. |
| `google_translate` | Google Translate | Google Cloud | Translate the value via Google Cloud Translate (service `document_ocr.google_translate`). |
| `microsoft_translate` | Microsoft Translate | Microsoft Azure | Translate via Azure Translator (service `document_ocr.microsoft_translate`). |
| `google_text2speech` | Google Text to Speech | Google Cloud | Generate an MP3 from the text and attach it to a file field (service `document_ocr.google_text2speech`; writes to `public://document-ocr-text-to-speech`). |
| `openai_chat` | OpenAI Chat | OpenAI | Send the value as a prompt to OpenAI/Azure OpenAI and store the completion (summaries, rewrites, etc.; service `document_ocr.openai`). |

## Notes

- `field_types` on the annotation limits which destination field types a transformer is offered
  for (e.g. Google Text to Speech targets file fields).
- Translation/AI transformers read credentials/config from their config entity; the underlying
  services build the API request. The value returned by `transform()` replaces the field value.
- The Pipeline transformer uses `TransformerBase::getTransformers()` to enumerate other configured
  transformer entities and applies them in sequence, letting you chain e.g. trim → translate →
  truncate.

See [plugin-types.md](plugin-types.md) for the base-class contract and how to add a transformer.
