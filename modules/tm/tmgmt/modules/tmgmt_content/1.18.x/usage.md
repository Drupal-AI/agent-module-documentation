Content Entity Source (tmgmt_content) is the TMGMT source plugin that exposes translatable **content entities** — nodes, taxonomy terms, media, custom blocks, and any content-translation-enabled entity — so they can be sent to a translation provider.

---

tmgmt_content registers a `content` source plugin (`Plugin\tmgmt\Source\ContentEntitySource`) with TMGMT and builds on Drupal core's `content_translation`. It reads the translatable fields of a content entity, flattens them into TMGMT data items (respecting each field's translatability and text format), and, when a translation is accepted, writes the translated values back as a new entity translation. It adds the **Translate** tab / overview to content entities so editors can select target languages and request a job directly, and it powers the source overview where many entities are batched into one job. A settings object (`tmgmt_content.settings`) records `embedded_fields` — entity-reference fields (e.g. paragraphs) whose referenced entities should be pulled into the same job so nested content translates together. Field-level handling is pluggable through a `FieldProcessorInterface` (with default, link, path, and metatag processors) so special field types serialize correctly. A route subscriber wires the translate tab onto entity routes, and a preview route renders a job item in a given view mode. It depends on `tmgmt` and core `content_translation` + `block`.

---

- Translate nodes into one or more languages from the node's Translate tab.
- Translate taxonomy terms, media items, and custom block content.
- Batch many content entities into a single translation job via the sources overview.
- Send content to any configured provider (machine, file, or human) for translation.
- Write accepted translations back as proper core entity translations.
- Pull referenced paragraphs/entities into the same job via `embedded_fields` so nested content translates together.
- Respect each field's translatability so non-translatable fields are skipped.
- Preserve text formats on translatable long-text fields.
- Translate metatag fields correctly via the metatag field processor.
- Handle link and path fields with their dedicated processors.
- Preview a job item rendered in a chosen view mode before accepting.
- Track which content is translated into which language on the overview.
- Provide the `content` source used by tmgmt_demo and most real installs.
- Restrict which entity types/bundles are offered for translation via item-type settings.
- Add a custom `FieldProcessorInterface` implementation for a bespoke field type.
- Combine with tmgmt_local to route content to in-house human translators.
- Combine with tmgmt_file to export content to XLIFF for an external agency.
- Re-translate updated content by requesting a new job on the changed entity.
- Support continuous jobs that automatically collect new/changed content.
- Serve as the reference implementation when building your own TMGMT source plugin.
