# Configuration

MemoQ translator has no page of its own. You configure it as a **TMGMT
translator** (a "Provider"), and its settings are stored on that translator's
config entity.

## Add the MemoQ provider

1. Go to **Translation → Providers** (`admin/tmgmt/translators`, also at
   `admin/config/regional/tmgmt/translators`).
2. Add a new provider and choose the **MemoQ** plugin.
3. Fill in the settings below and save.

## Settings, field by field

| Field | Setting key | What it does |
|-------|-------------|--------------|
| **CMS API URL** | `api_url` | Base URL of your memoQ CMS API gateway. Every request is sent to `<api_url>/<path>`. |
| **CMS API key** | `api_key` | Your memoQ API key. Sent on every request as the header `Authorization: CMSGATEWAY-API <api_key>`. |
| **Prefix for the MemoQ order name** | `job_name_prefix` | A fixed string prepended to each memoQ order's name, to make orders easy to spot. |
| **Language mapping** | `memoq_languages` | Maps each Drupal language to its memoQ language code. The options are fetched live from memoQ, so valid credentials must already be entered for the selects to populate. |
| **Extended XLIFF processing** | `xliff_processing` | When on (the default), HTML tags are masked/processed rather than merely escaped in the XLIFF. |
| **XLIFF CDATA** | `xliff_cdata` | When on (off by default), CDATA is used for XLIFF import/export. Toggle to suit your memoQ workflow. |

The provider only reports itself **available** once both the API URL and API key
are set (and zlib is present). The language‑mapping selects become required at
that point, and because their options come straight from memoQ's `languages`
endpoint, your credentials must be valid for the list to appear.

## Test the connection

The settings form has a **Connect** button, and saving the form validates the
connection (a `GET` to the memoQ `client` endpoint). If memoQ can't be reached or
the credentials are wrong, the form blocks the save and shows the error — so a
successful save means the connection worked.

## Keep the API key out of exported config (recommended)

The `api_key` is stored on the translator config entity like any TMGMT provider
secret, which means it would travel in exported configuration. To keep it out of
config and vary it per environment, override it from `settings.php`:

```php
$config['tmgmt.translator.<your_translator_id>']['settings']['api_key'] = getenv('MEMOQ_API_KEY');
```

Then supply `MEMOQ_API_KEY` through your environment rather than committing it.

> **Working in DDEV?** Store the secret as an environment variable instead of
> hard‑coding it: `ddev dotenv set .ddev/.env --memoq-api-key=<value>` (keep
> `.ddev/.env` out of version control), then `ddev restart` so the container picks
> it up. The `--memoq-api-key` flag becomes the `MEMOQ_API_KEY` variable that the
> `getenv()` call above reads.

## Per‑job deadline

When you check out a translation job, the provider adds a **Deadline** field. If
you set it, the value is passed to the memoQ order as its deadline (ISO‑8601).

## Submitting jobs and getting translations back

Once configured, select the MemoQ provider when checking out a TMGMT job.
Submitting it creates a memoQ order, uploads each job item as gzipped XLIFF, and
commits the order. Completed translations return either automatically, via the
memoQ **callback** webhook, or on demand when you **fetch** ready jobs from the
job's page.

## Extending the payloads (for developers)

Two alter hooks let other modules tweak what's sent to memoQ before submission:
`hook_tmgmt_memoq_order_info_alter()` (adjust the order — e.g. append the word
count to the name) and `hook_tmgmt_memoq_job_info_alter()` (adjust each job — e.g.
prepend the owner's name). Details are in the [`agent/`](../agent/start.md) docs.
