<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config object & batch UI

## Route, permission, menu

- Route `fast_revision_purge.settings` (`fast_revision_purge.routing.yml`): path
  `/admin/config/development/fast-revision-purge`, `_form: \Drupal\fast_revision_purge\Form\SettingsForm`,
  `_title: 'Fast Revision Purge'`, requirement `_permission: 'administer site configuration'`.
- Menu link `fast_revision_purge.settings` (`.links.menu.yml`) under `system.admin_config_development`,
  weight 100.
- `configure` in `.info.yml` points to this route.

## Config object `fast_revision_purge.settings`

Schema `config/schema/fast_revision_purge.schema.yml` (`type: config_object`), keys:

| Key | Type | Meaning | Form default |
|---|---|---|---|
| `keep_last` | integer | Keep latest N non-default node revisions | 5 (min 0, required) |
| `since` | string | Keep revisions since `YYYY-MM-DD` (empty = disabled) | null |
| `protect_published` | boolean | Protect latest published node revision | TRUE |
| `per_language` | boolean | Partition keep-last by `(nid, langcode)` | FALSE |
| `keep_paragraph_last` | integer | Keep last M paragraph revisions per paragraph entity | 1 (min 0, required) |
| `chunk_size` | integer | Rows deleted per chunk | 5000 (min 100) |
| `sleep_ms` | integer | Sleep (ms) between chunks | 0 (min 0) |

`SettingsForm` is a `ConfigFormBase`; `getEditableConfigNames()` returns `['fast_revision_purge.settings']`.
`saveConfigFromValues()` casts each value (`(int)` / `(bool)` / `?: NULL`) before `->save()`. There is no
per-bundle or "keep N days" config — retention is exactly the keys above.

## Form structure (`SettingsForm::buildForm`)

- **Database overview** (`TableStats`): current DB size, top 3 biggest tables, Last Dry Run / Last Purged as
  relative time, and potential reclaimable space (read from `fastrev_stats`).
- **Retention policy**: `keep_last`, `per_language`, `since` (date), `protect_published`, `keep_paragraph_last`.
- **Execution settings**: `chunk_size`, `sleep_ms`, and an `ensure_indexes` checkbox (not stored; runs
  `IndexManager::ensureHelpfulIndexes()` on submit when checked).
- **Sanity checks**: `show_sanity_queries` renders copy/paste Drush + SQL built by `buildSanityQueries()`
  (pre-filled with detected paragraph table/timestamp-column names) so an operator can independently verify the
  delete set.
- **Danger zone**: `confirm_purge` checkbox (must be checked to purge).
- **Extra purges**: `purge_paragraph_revisions` (disabled unless `paragraphs` enabled) and
  `purge_layout_builder_revisions` (disabled unless `layout_builder` enabled).
- **Actions**: Save configuration (`submitForm`), Plan (Dry run) (`submitDryRun`), Run purge now
  (`submitPurgeBatch`, styled `button--danger`).
- **Dry run report** / **Post-purge maintenance**: shown after a plan/purge; the maintenance section emits
  copy/paste `ANALYZE TABLE` / `OPTIMIZE TABLE` SQL from `buildPostPurgeSql()`.

`validateForm()` rejects a `since` value that is not `^\d{4}-\d{2}-\d{2}$`.

## Batch operations

Both actions run through Drupal's Batch API (`batch_set`), so they execute as authenticated POST submissions of
this admin form.

- **Plan (Dry run)** — `submitDryRun()` saves config, optionally ensures indexes, then queues
  `Batch\PlanBatch::phase($opts, $context)` which calls `Planner::plan(keep_last, since, protect_published,
  per_language, keep_par_last)`. `setRebuild()` re-renders the report.
- **Run purge now** — `submitPurgeBatch()` first requires `confirm_purge` (else an error and return), saves
  config, optionally ensures indexes, then builds operations:
  - optional `SettingsForm::opParagraphPurge` (calls `ParagraphRevisionTruncator::execute($chunk)`) when
    "Purge Paragraph Revisions" is checked and Paragraphs is enabled;
  - optional `SettingsForm::opLayoutBuilderPurge` (calls `LayoutBuilderRevisionTruncator::execute($chunk, 0)`)
    when "Purge Layout Builder Revisions" is checked and Layout Builder is enabled;
  - always `Batch\PurgeBatch::process()` which calls `Purger::purge($chunk, $sleep)` and iterates until nothing
    remains. `PurgeBatch::finished()` prints a status message.

Chunk/sleep come from `chunk_size` / `sleep_ms` config, cast to int. The truncator batch ops clamp chunk to a
minimum of 1000.
