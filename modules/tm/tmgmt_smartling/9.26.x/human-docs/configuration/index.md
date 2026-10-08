# Configuration

Smartling is configured as a **TMGMT provider**. Go to
**Administration → Translation → Providers** (`/admin/tmgmt/translators`), add a
provider, and choose **Smartling** as the plugin. The settings below are stored on
that provider (a `tmgmt.translator.<id>` config entity). You need the **Administer
tmgmt** permission.

## Credentials and connection

- **Project Id**, **User Id**, **Token Secret** — your Smartling API credentials.
  Store the token secret via an environment variable or `settings.php` override
  rather than in exported config (see [Installation](../installation/index.md)).
- **Desired download format** *(default `xml`)* — export/import format, XML or
  XLIFF (handled through TMGMT File). A related toggle controls XLIFF processing.
- **File storage scheme** *(default `public`)* and **Retrieval type** *(default
  `published`)*.

## Callbacks — how finished translations come back

- **Use Smartling callback** *(default off)* — registers a callback URL
  (`[host]/tmgmt-smartling-callback/[job_id]`) with Smartling so a finished
  translation triggers an automatic download.
- **Override host value** — a base host to use when building the callback URL,
  useful when your public host differs from Drupal's computed base URL.

These callback routes only schedule a download for an existing job.

Even without callbacks, translations are pulled back on cron, so make sure Drupal
cron runs regularly.

## Visual context for translators

Context uploads a rendered copy of the page so translators see strings in place:

- **Username for context retrieval** — the account used to render pages for
  context capture. Note this involves the module switching to that user during
  upload.
- **Context URL host** and **Skip host verification** *(default off)* — control
  which host is used and whether it is verified.
- **Enable basic auth for context** *(default off)* plus **Login** / **Password** —
  set these when your site sits behind HTTP basic auth so context rendering can
  fetch pages.
- **Exclude entity types from context** — opt specific entity types or bundles out
  of context capture.

## Content handling

- **Automatically authorize content** *(default on)* — authorise uploaded content
  for translation in Smartling automatically.
- **Custom placeholder (regexp)** *(default `(@|%|!)[\w-]+`)* — protects tokens
  from being translated.
- **Translatable HTML attributes** *(default `title, alt`)* and **Exclude
  attributes** — which HTML attributes are sent for translation.
- **Segment strings by HTML tags** — break translatable text at the given tags.
- **Identical file names** *(default off)*.

## Delivery and operations

- **Asynchronous mode** *(default off)* — run uploads and downloads through
  queues.
- **Download and apply translations per job item** *(default off)* — pull back
  individual job items rather than the whole job at once.
- **Enable Smartling remote logging** *(default on)* and **real-time
  notifications** *(default on)*.
- The form also surfaces a **Cron & queues** status area — uploads and downloads
  run through the TMGMT extension suite's scheduler and queue workers, so cron must
  be running.

## Related admin actions

- **Send context** — `/admin/tmgmt/send-context-action`, gated by the **Send
  context smartling** permission (a trusted permission, because sending context
  switches the acting user during upload).
- **Approve download by job items** — `/admin/tmgmt/approve-action-download-by-job-items`,
  gated by **Administer tmgmt**.
- **See Smartling messages** — a permission that lets a user view Smartling
  health-check messages and the progress tracker.

## Driving config from Drush

There are no dedicated Drush commands. Manage provider settings with core config
commands (`drush config:set` / `config:import`) on the `tmgmt.translator.<id>`
entity.
