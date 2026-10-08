# Smartling Translator — alter hooks (`tmgmt_smartling.api.php`)

Implement these in your module to customise how content is sent to / read from Smartling.

| Hook | Signature | Purpose |
|---|---|---|
| `hook_tmgmt_smartling_context_url_alter` | `(&$url, JobItemInterface $job_item)` | Alter the URL used for visual context; set `$url = NULL` to skip context for that job item's content. |
| `hook_tmgmt_smartling_filename_alter` | `(&$name, JobInterface $job)` | Alter the uploaded translation file name. |
| `hook_tmgmt_smartling_attachment_filename_alter` | `(&$name, JobInterface $job, FileInterface $file)` | Alter an attachment file name. |
| `hook_tmgmt_smartling_bucket_job_name_alter` | `(&$name)` | Alter the daily "bucket job" name. |
| `hook_tmgmt_smartling_directives_alter` | `(array &$directives, JobInterface $job)` | Set Smartling upload directives, e.g. `smartling.force_inline_for_tags`, or `smartling.namespace` (share a namespace/hashcode across uploads instead of the default fileUri-based namespacing). |
| `hook_tmgmt_smartling_locked_fields_base_form_id_list_alter` | `(array &$forms_to_enable_locked_fields)` | Add base form ids that participate in the lock-fields mechanism. |
| `hook_tmgmt_smartling_xml_file_export_data_alter` | `(array &$data)` | Alter data before it is exported into the XML file for upload. |
| `hook_tmgmt_smartling_xml_file_import_data_alter` | `(array &$data)` | Alter data being imported from a downloaded XML file. |

Notes:
- These are classic `hook_*` implementations (put them in `yourmodule.module`).
- The module itself implements `hook_tmgmt_smartling_context_url_alter` (see
  `tmgmt_smartling_tmgmt_smartling_context_url_alter` in `tmgmt_smartling.module`) as a reference.
- Also relevant for programmatic integration: events under `src/Event/`
  (`RequestTranslationEvent`, `AfterFileDownloadEvent`) dispatched around request/download.
