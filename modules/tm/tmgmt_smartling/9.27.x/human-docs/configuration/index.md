# Configuration

Smartling is configured **per TMGMT provider**, not on a single module settings page.
Each provider is a `tmgmt.translator.<id>` config entity that holds one Smartling
project's credentials and options.

## Create a Smartling provider

1. Log in as a user with the **Administer Translation Management** permission.
2. Go to **Translation → Providers** (`/admin/tmgmt/translators`) and add a provider.
3. Choose **Smartling** as the translator plugin. The Smartling settings form appears.
4. Fill in the sections below, then save.

## Credentials & connection

- **Project Id**, **User Id**, **Token Secret** — your Smartling API credentials,
  used by the Smartling PHP SDK to authenticate. Store the **Token Secret** via a Key
  entity or a `settings.php` override if you would rather not keep it in exported
  configuration (see the installation guide).
- **The desired format for download** (default **XML**) — the export/import format
  (XML or XLIFF, provided by TMGMT File). An XLIFF-processing toggle controls XLIFF
  handling.
- **Scheme** (default `public`) and **Retrieval type** (default `published`) — where
  translation files are stored and which revision is retrieved.

## Callbacks — how finished translations come back

- **Use Smartling callback** (default off) — when on, the module registers a callback
  URL (`[host]/tmgmt-smartling-callback/[job_id]`) with Smartling, so a completed
  translation triggers a download automatically.
- **Override host value** — the base host used when building that callback URL, useful
  when your public host differs from Drupal's computed base URL.

The callback routes check that the job exists and that the expected request
parameters are present, then schedule a download. If you do not need push-style
delivery, leave the callback off and rely on cron/on-demand downloads instead.

## Context — visual screenshots for translators

Context uploads a rendered version of the page so translators see strings in place.

- **Username for context retrieval** — the account used to render the page for
  capture. Note that sending context "involves automatically switching user during
  upload", so treat the *Send context smartling* permission as trusted.
- **Context URL host** and **Skip host verification** (default off) — control the
  host used and whether it is verified.
- **Enable basic auth for context** (default off) plus **Login** / **Password** — use
  these when the site sits behind HTTP basic auth so the context renderer can fetch
  pages.
- **Exclude entity types from context** — opt specific entity types or bundles out of
  context capture.

## Content handling

- **Automatically authorize content** (default on) — authorize uploaded content for
  translation in Smartling without a manual step.
- **Custom placeholder (regexp)** (default `(@|%|!)[\w-]+`) — protects tokens such as
  `@name` or `%count` from being translated.
- **Translatable HTML attributes** (default `title, alt`) and **Exclude attributes** —
  which HTML attributes are sent for translation and which are skipped.
- **Segment strings by HTML tags** — force segmentation at specific tags.
- **Identical file names** (default off) — reuse identical file names across uploads.

## Delivery & operations

- **Asynchronous mode** (default off) — run uploads/downloads asynchronously through
  queues.
- **Download and apply translations per job item** (default off) — bring translations
  back one job item at a time rather than per whole job.
- **Enable Smartling remote logging** (default on) and **real-time notifications**
  (default on) — send logs/notifications to Smartling.
- The form also surfaces **cron & queue** status and actions. Uploads and downloads
  run through the TMGMT Extension Suite's scheduler and queue workers, so **cron must
  be running** for translation to progress.

## Save

Save the provider. You can then create TMGMT jobs and pick this Smartling provider as
their translator. There are no Drush commands specific to this module; if you script
provider changes, drive the `tmgmt.translator.<id>` config entity with
`drush config:set` / `drush config:import`.
