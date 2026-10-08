# Configuration

Configuring Google Analytics Counter has three parts: connect to the Google
Analytics API, choose which content types get a counter field, and let cron sync
the figures. All the screens are gated by the **Administer Google Analytics
Counter** permission — grant it only to administrators under **People →
Permissions**.

## The main settings form

Go to **Configuration → System → Google Analytics Counter**
(`/admin/config/system/google-analytics-counter`). Here you enter the **Google
Analytics API credentials** and the **sync options** that control how the module
talks to Google and how much data it fetches per run. The goal is for the page-view
figures stored in Drupal to match the pageviews reported in your Google Analytics
(GA4) property.

### Keep the API credentials out of version control

The credentials the module uses to reach the Google Analytics API are sensitive.
Do not commit them in exported configuration. Prefer sourcing them from an
environment variable — for example, with DDEV you can store a value out of Git:

```bash
ddev dotenv set .ddev/.env --gac-api-secret=<value>
ddev restart
```

(The flag `--gac-api-secret` becomes the variable `GAC_API_SECRET`; keep
`.ddev/.env` out of version control.) Also remember the module makes **outbound
HTTPS** calls to the Google API, so your host must allow that egress.

## Choose which content types get a counter field

A second form (the *configure types* screen) lets you pick which **content types**
should carry a Google Analytics Counter field. Enabling it for a type adds a field
that, once cron has populated it, behaves like any other field — you can place it on
the node display or use it in Views. Using the field is generally the most flexible
way to surface counts.

## Run the sync

The module does its work on **cron**: each cron run fetches a batch of figures from
Google and updates the stored counts. So after configuring credentials, either wait
for cron or trigger it manually:

```bash
drush cron
```

You can inspect the current settings and confirm the sync is progressing:

```bash
drush cget google_analytics_counter.settings
```

## Monitor progress on the dashboard

The **dashboard** form (`…/google-analytics-counter/dashboard`) reports what has
been fetched so far and how much of the queue remains. Check it after enabling the
module to confirm data is flowing in; on a large site the initial backfill takes
several cron runs.

## Using the results

Once counts are populated they are available to:

- **Views** — build "most popular" blocks and listings (the module ships Views
  integration).
- The **counter field** — display view counts on nodes.
- A **block** and a **token** the module provides.

Because the figures are a cron snapshot, expect them to lag live traffic by roughly
your cron interval.
