# Configuration

All of TMGMT's screens live under **Translation** (`/admin/tmgmt`). You need the
**Administer Translation Management** permission (or the more granular job
permissions) to reach them. The flow is always the same: set up a provider once,
then request → review → accept translations as often as you like.

## Step 1 — Create a translation provider

A provider is where translations come from. Go to **Translation → Providers**
(`/admin/tmgmt/translators`) and add one, or configure the default that your
translator submodule created for you.

Each provider is built on a **translator plugin** — for example the **File**
translator (export XLIFF/HTML and import it back), the **Local** translator
(in-Drupal humans), or a machine-translation plugin supplied by a contrib provider
module. Give the provider a label, choose its plugin, and fill in any
plugin-specific settings (an API key, for instance).

A couple of settings apply to every provider:

- **Auto accept finished translations** — skip the manual review step for a
  provider you trust completely; translations are saved as soon as they come back.
- **Remote language mappings** — map the provider's own language codes to your
  Drupal language codes when they differ.

## Step 2 — Request a translation (creating jobs)

You can request a translation two ways:

- From a content item's **Translate** tab, or
- From the **Sources** overview (**Translation → Sources**,
  `/admin/tmgmt/sources`), where you can select many items at once.

Pick your target languages and request the translation. TMGMT creates **one job per
target language**, each containing one **job item** per source thing. If you want to
gather items over time before sending them, add them to the **Cart**
(`/admin/tmgmt/cart`) and check out the whole batch together.

**Continuous jobs** are also available: set one up and TMGMT will automatically pick
up new or changed content on cron and send it for translation without you lifting a
finger.

## Step 3 — Review and accept

When a provider returns a translation, review it before it goes live:

- Open the **job** (`/admin/tmgmt/jobs`) to see its items.
- Open a **job item** to see the source text and the translation side by side, one
  segment at a time.

On the job-item screen you can edit the translated text, **accept** an item (which
saves the translation onto the target content), request a revision, or **abort** an
item you no longer want. Every action — plus any messages from the provider — is
recorded in the job's message log.

## Global settings

**Translation → Settings** (`/admin/tmgmt/settings`) controls site-wide behaviour.
The most useful options:

| Setting | Default | What it does |
|---------|---------|--------------|
| **Quick checkout** | On | Skip the checkout form when a job needs no extra settings. |
| **Anonymous access** | On | Allow a keyed preview link so a source can be previewed in context while a job is active. |
| **Purge finished jobs** | Never | When (if ever) to automatically delete finished jobs. |
| **Purge continuous / aborted / stale items** | Never / Off / On | Housekeeping for continuous-job items so their tables don't grow unbounded. |
| **Exclude tags from word count** | On | Don't count HTML tags when estimating word volume. |
| **Source list limit** | 20 | How many items appear per page on the sources overview. |
| **Respect text format** | On | Preserve text-format restrictions when importing translations. |
| **Field length overflow policy** | Needs review | What to do when an imported translation is longer than the field allows. |
| **Submit job items on cron** | Off | Submit pending job items during cron runs. |
| **Job items per cron run** | 50 | Cap on how many items cron processes at once. |

Word counting (turned on here) lets you estimate translation cost up front, which is
handy when a provider charges per word.

## Deploying your setup

Providers are stored as configuration and the global settings live in a config
object, so both export and import cleanly with `drush config:export` /
`drush config:import` — you can build your translation setup on one environment and
deploy it to another.

## Permissions

TMGMT defines permissions that gate who can create, submit, accept, and delete
translation jobs. Grant them under **People → Permissions** so that, for example,
editors can request translations while only a translation manager can accept or
delete jobs. Because these permissions unlock the review UI — which shows the full
source text of the content in a job — grant them only to trusted translation staff.
