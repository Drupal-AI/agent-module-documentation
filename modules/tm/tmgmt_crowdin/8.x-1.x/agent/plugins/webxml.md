<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `webxml` tmgmt_file format plugin

`WebXML` — `src/Plugin/tmgmt_file/Format/WebXML.php`. Annotation
`@FormatPlugin(id = "webxml", label = "WEBXML")`. Extends PHP's `\XMLWriter`, implements
`FormatInterface` and `ContainerFactoryPluginInterface`. Injects `tmgmt.data` (the TMGMT data
service). This is the file format the Crowdin translator uploads and imports; it is a plain XML
container (not standard XLIFF), tailored to how the Crowdin API round-trips content.

## Export (Drupal → XML)

`export(JobInterface $job, $conditions = []): string` writes an in-memory XML document:

- Root `<content>` with attributes `source-language`, `target-language`, `tool-id="tmgmt"`, and
  `job-id` (used later to re-match on import).
- One `<JobItem id="...">` per job item; inside, one element per translatable data key.
- `addTranslationUnit()` derives the element name from the field's `#parent_label`/key, stripped to
  `[a-zA-Z0-9_-]` via `preg_replace` and `ucwords`. Empty or invalid-start names (e.g. non-Latin
  labels reduced to empty, or names starting with a digit/hyphen) are prefixed `unit`. The real key
  is preserved in the element's `id` and `resname` attributes (`<item id>` + TMGMT array delimiter +
  key).
- `writeData()` writes the source text as **CDATA** when the job's `xliff_cdata` setting is TRUE
  (default), otherwise as escaped text.

## Import (XML → Drupal)

- `import($imported_file, $is_file = TRUE): ?array` → `getImportedXml()` then
  `dataService->unflatten(getImportedTargets())`. `getImportedTargets()` reads each
  `<JobItem>` child's `id` attribute and text into `['#text' => ...]`.
- `getImportedXml()` loads the XML with `simplexml_load_string()`. When `$is_file` is TRUE it first
  reads the path with `file_get_contents()` — in the Crowdin flow the "path" is the **authenticated
  Crowdin build-file URL** returned by the API, not user input.
- `validateImport($imported_file, $is_file = TRUE): ?Job` is the gate `importTranslation()` calls
  before import. It requires the root `<content>` attributes to be present and to match the target
  job: a loadable `job-id`, and `source-language` / `target-language` equal to the job's remote
  languages; it also rejects an empty target set. Any mismatch adds an error message and returns
  NULL (import aborted).

## Notes

- The format is symmetric with `CrowdinTranslator`: files are created in Crowdin as `type => 'webxml'`
  so Crowdin parses the same structure back out.
- Content flows into Drupal through TMGMT's normal `addTranslatedData()` pipeline and is rendered
  through standard (auto-escaped) field rendering — the plugin does not itself emit remote content
  into markup.
