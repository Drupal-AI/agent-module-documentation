# Configuration

Configuration centres on authenticating to Google with a service account. The
settings form walks you through the setup, and because it uses Drupal **state**,
you'll do this once per environment (it is not exported with your configuration).

## Before you start: confirm the use case

Google's Indexing API is documented for **job postings and livestream content**. If
your pages aren't those, this module is the wrong tool — use an XML sitemap for
general content instead. Confirm your site qualifies before going further.

## 1. Create a Google service account

1. In the [Google Cloud console](https://console.cloud.google.com/), create (or
   reuse) a project and enable the **Indexing API**.
2. Create a **service account**, generate a **key**, and download the **JSON**
   credentials file.
3. In **Google Search Console**, verify ownership of your domain property and add the
   service account as an owner, so it is allowed to submit URLs for your site.

## 2. Configure the module

1. Go to **Configuration → Web services → Google Index API**
   (`/admin/config/services/google-index-api`).
2. Follow the on‑screen instructions to provide the **service‑account credentials**
   and complete the setup. Remember this is stored in state, so repeat it on each
   environment (production, staging, local).

## 3. Submit URLs

- **Automatically:** call `\Drupal::service('google_index_api.client')->updateUrl($url)`
  (or `->deleteUrl($url)`) from an entity update/delete hook, as shown on the
  [overview page](../index.md#how-to-use-it).
- **In bulk:** use the form at
  `/admin/config/services/google-index-api/bulk-update` to submit a batch of URLs —
  ideal after a migration or a sweeping content change.

> **Rate limit.** Google allows roughly **200 calls per day**. Prefer the batch form
> for backlogs, and don't wire updates so aggressively that you exhaust the quota.

## Storing the service‑account key securely

The JSON key is a genuine secret — anyone with it can submit URLs as your site.

- Keep the file **outside the docroot** and **out of version control**; never place
  it in exported configuration.
- Follow this repo's convention of referencing the key **by path from an environment
  variable**. With DDEV you can store such a value out of the repository using its
  dotenv support and reference it at runtime.
- If the key is ever exposed, **rotate it** in the Google Cloud console.
