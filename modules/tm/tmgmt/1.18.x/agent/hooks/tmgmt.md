# Hooks — `tmgmt.api.php`

Implement in `my_module.module`. Two info-alter hooks are also documented under
[plugins/tmgmt.md](../plugins/tmgmt.md).

## Source hooks

- `hook_tmgmt_source_plugin_info_alter(&$info)` — alter registered source plugins.
- `hook_tmgmt_source_suggestions(array $items, JobInterface $job)` — return related content
  suggested for translation alongside the given job items (e.g. referenced entities). Each
  suggestion is `['job_item' => …, 'reason' => …, 'from_item' => …]`.

## Translator hooks

- `hook_tmgmt_translator_plugin_info_alter(&$info)` — alter registered provider plugins.

## Checkout & request-translation flow

- `hook_tmgmt_job_checkout_before_alter(&$remaining_jobs, &$jobs)` — reorder/skip jobs before
  the checkout form loop.
- `hook_tmgmt_job_checkout_after_alter(&$redirects, &$jobs)` — alter redirects after checkout.
- `hook_tmgmt_job_before_request_translation(JobInterface $job)` — act just before a job is
  handed to its provider.
- `hook_tmgmt_job_after_request_translation(JobInterface $job)` — act right after.

## Data-item text hooks

- `hook_tmgmt_data_item_text_output_alter(&$source_text, &$translation_text, array $context)` —
  alter text as it is shown/exported for translation.
- `hook_tmgmt_data_item_text_input_alter(&$translation_text, array $context)` — alter incoming
  translated text before it is stored.

## State definitions

- `hook_tmgmt_job_item_state_definitions_alter(&$definitions)` — add/alter job-item review
  states.

Because jobs, job items and messages are content entities, the standard `hook_entity_*` and
`hook_tmgmt_job[_item]_presave/insert/update/load/delete` hooks also fire.
