# Smartling Translator — provider (translator plugin) settings

Configuration is per **TMGMT provider**, not a module settings page. Create a provider at
*Administration → Translation → Providers* (`/admin/tmgmt/translators`), pick **Smartling** as the
plugin, and fill the settings form (`SmartlingTranslatorUi::buildConfigurationForm`). Values are stored
on the `tmgmt.translator.<id>` config entity; schema lives in `config/schema/tmgmt_smartling.schema.yml`.

## Credentials & connection
- **Project Id** (`project_id`), **User Id** (`user_id`), **Token Secret** (`token_secret`) — Smartling
  API credentials used by `smartling/api-sdk-php` (`SmartlingApiFactory::create` →
  `AuthTokenProvider::create`, wrapped by `SmartlingApiWrapper`). Stored as plain settings on the
  translator config entity; override them per environment via `settings.php` if you prefer not to keep
  them in exported config.
- **The desired format for download** (`export_format`, default `xml`) — export/import format
  (XML/XLIFF via `tmgmt_file`); `xliff_processing` (default TRUE) toggles XLIFF handling.
- **`scheme`** (default `public`) and **`retrieval_type`** (default `published`).

## Callbacks (translation download triggers)
- **Use Smartling callback** (`callback_url_use`, default FALSE) — when enabled, the module registers
  `[host]/tmgmt-smartling-callback/[job_id]` with Smartling so that a completed translation triggers a
  download. Built by `SmartlingTranslator::getCallbackUrl()`.
- **Override host value** (`callback_url_host`) — base host used when building the callback URL
  (useful when the public host differs from Drupal's computed base URL).

## Context (in-context screenshots for translators)
- **Username for context retrieval** (`contextUsername`) — the account used to render the page for
  context capture (`ContextCurrentUserAuth`/`ContextUserAuth`; note the `send context smartling`
  permission warns it "involves automatic switching user during upload").
- **Context URL host** (`context_url_host`) and **Skip host verification**
  (`context_skip_host_verifying`, default FALSE; its own form help states it is for non-production
  development/testing only).
- **Enable basic auth for context** (`enable_basic_auth`, default FALSE) + **Basic auth** Login/Password
  (`basic_auth.login`, `basic_auth.password`) — used when the site is behind HTTP basic auth so context
  rendering can fetch pages.
- **Exclude entity types from context** (`exclude_context_options`) — per entity type / bundle opt-out.

## Content handling
- **Automatically authorize content** (`auto_authorize_locales`, default TRUE).
- **Custom placeholder (regexp)** (`custom_regexp_placeholder`, default `(@|%|!)[\w-]+`) — protect
  tokens from translation.
- **Translatable HTML attributes** (`translatable_attributes`, default `title, alt`) /
  **Exclude attributes** (`exclude_translatable_attributes`).
- **Segment strings by HTML tags** (`force_block_for_tags`).
- **Identical file names** (`identical_file_name`, default FALSE).

## Delivery / operations
- **Asynchronous mode** (`async_mode`, default FALSE).
- **Download and apply translations per job item** (`download_by_job_items`, default FALSE).
- **Enable Smartling remote logging** (`enable_smartling_logging`, default TRUE) and **real-time
  notifications** (`enable_notifications`, default TRUE).
- The form also surfaces **Cron & queues** status/actions (uploads/downloads run via
  `tmgmt_extension_suit` `FlowScheduler` + queue workers, and `tmgmt_smartling_cron`; ensure cron runs).

## Related admin routes
- `/admin/tmgmt/send-context-action` — bulk send context (perm `send context smartling`).
- `/admin/tmgmt/approve-action-download-by-job-items` — approve download-by-job-items (perm
  `administer tmgmt`).

## Programmatic notes
Defaults are in `SmartlingTranslator::defaultSettings()`. Requesting translation calls
`FlowScheduler::scheduleUpload($job->id(), …)`. There are no Drush commands; drive provider config with
`drush config:set`/`config:import` on the `tmgmt.translator.<id>` entity.
