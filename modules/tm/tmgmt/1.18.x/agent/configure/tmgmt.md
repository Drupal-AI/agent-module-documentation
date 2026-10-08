# Configure — providers, jobs & the review UI

All admin lives under **Admin → Translation** (`/admin/tmgmt`). Requires
`administer tmgmt` (or the more granular job permissions — see hooks/permissions).

## 1. Create a translation provider (`tmgmt_translator` config entity)

- List/config: `entity.tmgmt_translator.collection` → `/admin/tmgmt/translators`
- Add: `entity.tmgmt_translator.add_form` → `/admin/tmgmt/translators/add`

A provider is a `tmgmt_translator` **config entity** whose `plugin` key points at a
`Plugin\tmgmt\Translator` plugin (e.g. `file`, `local`, or a machine-translation plugin from a
contrib provider module). Exported config keys: `name`, `label`, `description`, `auto_accept`,
`weight`, `plugin`, `settings`, `remote_languages_mappings`. Set **Auto accept finished
translations** (`auto_accept`) to skip manual review for a trusted provider. Enabling a
translator submodule usually auto-creates a default provider. Config schema: `tmgmt.translator.*`.

## 2. Request a translation → creates jobs

From a source's **Translate** tab or the sources overview
(`tmgmt.source_overview` / `/admin/tmgmt/sources`), pick target languages and request a
translation. TMGMT creates one **`tmgmt_job`** per target language, each containing
**`tmgmt_job_item`** entities (one per source thing). A **cart** (`tmgmt.cart`,
`/admin/tmgmt/cart`) lets you batch many items before checkout. Continuous jobs
(`entity.tmgmt_job.continuous_add_form`) auto-collect new/changed content on cron.

Job states (`JobInterface`): `UNPROCESSED(0)`, `ACTIVE(1)`, `REJECTED(2)`, `ABORTED(4)`,
`FINISHED(5)`, `CONTINUOUS(6)`, `CONTINUOUS_INACTIVE(7)`.
Job-item states (`JobItemInterface`): `INACTIVE(0)`, `ACTIVE(1)`, `REVIEW(2)`, `ACCEPTED(3)`,
`ABORTED(4)`.

## 3. The review UI

- Job: `entity.tmgmt_job.canonical` → `/admin/tmgmt/jobs/{tmgmt_job}` (edit form).
- Job item: `entity.tmgmt_job_item.canonical` → `/admin/tmgmt/items/{tmgmt_job_item}`.

The job-item form shows source vs. translation per data segment. Editors edit text,
**accept** an item (moves `REVIEW → ACCEPTED`, which saves the translation to the target
entity), request a revision, or **abort**
(`entity.tmgmt_job_item.abort_form`). `tmgmt_message` content entities log every event and
provider message on the job.

## 4. Global settings — `tmgmt.settings`

`/admin/tmgmt/settings` (`tmgmt.settings` route), or `drush cset tmgmt.settings <key>`.
Defaults from `config/install/tmgmt.settings.yml`:

| Key | Default | Meaning |
|---|---|---|
| `quick_checkout` | `true` | Skip the checkout form when a job needs no extra settings |
| `anonymous_access` | `true` | Allow anonymous access to certain job flows |
| `purge_finished` | `_never` | When to purge finished jobs |
| `word_count_exclude_tags` | `true` | Exclude HTML tags from the word count |
| `source_list_limit` | `20` | Items per page on source overviews |
| `respect_text_format` | `true` | Preserve text-format restrictions on import |
| `submit_job_item_on_cron` | `false` | Submit job items during cron |
| `job_items_cron_limit` | `50` | Max job items processed per cron run |
| `allowed_formats` / `file_mimetypes` | `{}` | Format/mime restrictions |

Schema: `config/schema/tmgmt.schema.yml` (`tmgmt.settings`, `tmgmt.translator.*`). Settings and
providers are config, so they export with `drush config:export`.
