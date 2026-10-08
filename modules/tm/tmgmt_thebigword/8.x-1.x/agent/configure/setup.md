<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# thebigword Connector — setup

## Prerequisites
TMGMT with `tmgmt_file` and `tmgmt_language_combination`. A thebigword account with API access.

## Add the provider
1. Go to **Translation → Providers** (`entity.tmgmt_translator.collection`, `/admin/tmgmt/translators`).
2. Add a translator, choose **thebigword** as the service plugin.
3. Enter the API endpoint/credentials on the provider form (`ThebigwordTranslatorUi`).
4. Map Drupal languages to thebigword **language skills** (permission `configure tmgmt thebigword language skills`).

## Round-trip routes
| Route | Path | Access | Purpose |
|-------|------|--------|---------|
| tmgmt_thebigword.callback | /tmgmt_thebigword_callback | `_access: TRUE` | thebigword posts file-state changes; controller re-reads `file/cmsstate/<id>` and matches before importing |
| tmgmt_thebigword.pull_all_remote_translations | /pull_all_remote_translations | `administer tmgmt`+`accept translation jobs` | batch-pull finished translations |
| tmgmt_thebigword.review_redirect | /admin/tmgmt/job/{tmgmt_job_item}/thebigword/review | custom access | redirect to thebigword Review Tool |
| tmgmt_thebigword.no_preview | /no_preview | `_access: TRUE` | placeholder no-preview response |

## Review permissions (sensitive)
`access tmgmt thebigword primary review` and `... secondary review` let a holder open a Review Tool task **bypassing logon** — grant only to trusted roles.

## Debugging
Enable `debug` in `tmgmt_thebigword.settings` to log incoming callback requests to the `tmgmt_thebigword` channel.

## Operating a job
Create a TMGMT job, select the thebigword provider, submit — items are exported as files and sent. thebigword notifies the callback as states change; import happens after state re-validation. Use the "Pull all thebigword translations" action (on the job-items view) to force a pull; import errors are reported back to thebigword and the job item is flagged.
