<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SourceLink service & source classes

`src/SourceLink.php` — `SourceLink implements ContainerInjectionInterface`. It is **not** a
`*.services.yml` service; obtain it with
`\Drupal::classResolver(SourceLink::class)` or `$container->get('class_resolver')
->getInstanceFromDefinition(SourceLink::class)`, then call `->setLink($url)` (which runs
`detectSource()`). It injects `config.factory`, `cache.data`, `database`, `entity_type.manager`,
`drupalorg.project_service`, `drupalorg.user_service`, `logger.factory`, `datetime.time`.

## Source detection & the per-source classes

`detectSource()` chooses a `SourceLinkInterface` implementation from `src/SourceLink/` by domain
substring:
- **`DrupalOrgIssue`** (`DOMAIN = www.drupal.org`) — fetches `https://www.drupal.org/api-d7{path}.json
  ?drupalorg_extra_credit=1&related_mrs=1` via `\Drupal::httpClient()` (default TLS verification);
  only `project_issue` and `sa` node types are accepted; parses credits, comments,
  attribution (volunteer / organizations / customers), related MRs, SA flag.
- **`GitDrupalCodeBase`** → `GitDrupalCodeIssue` / `GitDrupalCodeMergeRequest`
  (`DOMAIN = git.drupalcode.org`) — use the `drupalorg` `GitLabClientTrait` + php-gitlab-api to
  read issue/MR data, participants, notes (comments) and award-emoji reactions.
- **`DevDrupalOrgIssue` / `DevGitDrupalCodeIssue` / `DevGitDrupalCodeMergeRequest`** — accepted
  only when `contribution_records.settings.allow_dev_sources` is TRUE.

`isValid()` enforces `scheme == https`, exact host match, no query/fragment, and a canonical path
(`/node/N` for Drupal.org; `/{project|issue}/name/-/issues|merge_requests/N` for GitLab).
`isValid(TRUE)` additionally fetches the remote to confirm the node exists/is published; results
are cached in `cache.data` for ~1 minute.

## Record creation / sync API

- **`createContribRecord()`** — builds+saves a `contribution_record` node from the fetched source
  (title, project machine name, draft/closed, SA flag, timestamps, `field_last_status_change`);
  contributors are added by `hook_node_presave` → `_contribution_records_sync_from_source()`.
- **`createContribRecordFromRawData(array $data)`** — trusted bulk-import path (from the import
  endpoint / queue). Validates link **format only** (`isValid(FALSE)`), sets
  `revision_log = SourceLink::IMPORT_MESSAGE` ("AUTOMATED-IMPORT") to skip the presave fetch, and
  creates `contributor` paragraphs directly from the supplied `credits` array (username,
  volunteer, credit, organizations/customers resolved by title). Users are resolved through
  `drupalorg.user_service`.
- **`syncContribRecord()` / `syncContributors()` / `syncContributor()`** — refresh an existing
  record's fields and contributor paragraphs from the source; `reset_contributors`/`hard-reset`
  removes contributors no longer present in the source. `removeContributor()` deletes the orphan
  paragraph.
- **`sortContributors($node, $ids)`** — re-orders `field_contributors` to a maintainer-supplied
  order (backfilling hidden bot users so counts match).
- **`isDuplicated()` / `getLinkedEntity()`** — look up an existing record by `field_source_link`
  (`accessCheck(FALSE)` on an internal type/URL match — record lookup, not user data exposure).
- **`isMaintainer(User)`** — delegates to `drupalorg.project_service::isProjectMaintainer()`.

## Contributor attribution helpers (`.module`)

`_contribution_records_load_values_in_paragraph()` merges/sets a contributor paragraph's
`field_contributor_volunteer`, `field_contributor_attribute_orgs`, `field_contributor_organisation`,
`field_contributor_customer` and credit flag. `_contribution_records_save_user_contribution_defaults()`
persists a user's chosen defaults through the `user.data` service
(`contribution_records` / `user_contribution_defaults`), reused on future contributions.
