<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Import & delete services + Drush commands

Both operations are **CLI-only** (Drush) and run inside a Drupal Batch that is driven by
`drush_backend_batch_process()`. Nothing in the module triggers a fetch or delete from a web route.

## Import — `ct-import-studies`

`clinical-trial:importStudies` (alias `ct-import-studies`, `Commands/ImportCommands`) →
`ClinicalImportService` (`clinicaltrials.import_service`; args `@database @http_client @logger.factory
@config.factory @entity_type.manager @state`).

Flow:
1. **Config gate** — `ImportCommands::importCtStudies()` aborts unless all of `base_url`,
   `studies_api_url`, `lead`, `overallstatus`, `fields`, `page_size`, `markup_format` are non-empty.
2. **Count** — `getCtCount()` builds the request URL from `base_url . studies_api_url` via
   `Url::fromUri()` with the base query params + `pageSize=1`, calls `triggerCtApiCalls()`, reads
   `totalCount`.
3. **Batch** — `getCtData($count)` computes `ceil(count / page_size)` operations, each running
   `processCtBatchInit()`, then `batch_set()` + `drush_backend_batch_process()`.
4. **Per page** — `processCtBatchInit()` carries `nextPageToken` forward as `pageToken` across
   operations (stored in `$context['results']['next_token']`), fetches, and calls `createCtNode()`
   for each `$study`.
5. **Per study** — `createCtNode()` reads `protocolSection.identificationModule.nctId`, looks up an
   existing `clinicaltrials` node by `type` + `title == nctId`. If none, it **creates** a node
   (`uid: 1`, published); if one exists it **updates** its fields and republishes. `field_data` =
   `serialize($protocolSection)`. Every processed nctId is collected in
   `$context['results']['created_nct_id']`.
6. **Finish** — `processCtBatchFinished()` records the run's nctId list into State (see below) and
   messages created/updated counts.

### API call — `triggerCtApiCalls($method, $url, $arg)`

`$this->httpClient->request('get', $url, $arg)`. `$url` already carries the full query string;
`$arg` is the raw params array passed as Guzzle request options (unknown option keys are ignored by
Guzzle). On HTTP **403 it retries once**; on **200** it `Json::decode()`s the body. `GuzzleException`
is caught and logged to channel `Clinical Trials`. **TLS verification is left at Guzzle's default
(enabled)** — the module sets no `verify` option. The target URL is admin-configured only.

## Delete — `ct-delete-studies`

`clinical-trial:deleteStudies` (alias `ct-delete-studies`, `Commands/DeleteCommands`) →
`ClinicalDeleteService::deleteCtData()`. It diffs the previous import's nctId set against the current
one and deletes nodes whose nctId dropped out (i.e. trials no longer returned by the API), via a
batch of `processCtDeleteBatchInit()` (loads node by type+title, deletes it). Runs only when **both**
state keys are set; otherwise it clears `clinical_trials_previous_nct_id` and reports "No Content to
delete".

## State-based tracking (State API, not config)

Two keys track import runs for later cleanup:
- `clinical_trials_current_nct_id` — comma-joined nctIds of the most recent import.
- `clinical_trials_previous_nct_id` — the prior run's list, set on the second import so the delete
  command can compute `array_diff(previous, current)`.

`processCtBatchFinished()` promotes current→previous on subsequent runs;
`processCtDeleteFinished()` / `deleteCtStates()` clear `previous` after a delete;
`hook_uninstall` deletes both.

## Tests

`tests/src/Unit/ClinicalUninstallValidatorTest.php` — unit coverage of the uninstall validator only
(no functional/import coverage).
