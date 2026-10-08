<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, install, routes & cron

## Install / enable

```bash
composer require drupal/easy_google_analytics_counter   # pulls google/analytics-data:^0.11.1
drush en easy_google_analytics_counter -y
```

Enabling runs `hook_entity_base_field_info` which adds the **`page_views`** integer base field to the
`node` entity (column `page_views` on `node_field_data`). If installed without Composer, add the
library from the **project** root: `composer require "google/analytics-data":"^0.11.1"`.

## Config object: `easy_google_analytics_counter.admin`

Written by `Form\AdminForm` (`ConfigFormBase`, `getEditableConfigNames()` → this object). Schema in
`config/schema/easy_google_analytics_counter.schema.yml`. `config/install/…admin.yml` ships empty.
Keys (from `AdminForm::buildForm()` / `submitForm()`):

| Key | Form element | Meaning |
| --- | --- | --- |
| `service_account_credentials_json_path` | textfield | Filesystem **path** to the Google service-account JSON key file. Preferred if set. |
| `service_account_credentials_json` | managed_file (`.json`, ≤256000 bytes, `#upload_location: public://`) | Uploaded service-account key file; stored as a file-id array, marked permanent on save. Used only if the path is empty. |
| `application_name` | textfield | Google service application name (stored; not used by `ConnectionService`). |
| `view_id` | textfield | GA4 **property id** (numeric). Used as `properties/{view_id}` in the report. |
| `sort_dimension` | textfield (default `ga:pageviews`) | Extra GA dimension name; a second `Dimension` is added unless it equals `screenpageviews`. |
| `sort_mode` | select ASCENDING/DESCENDING (default DESCENDING) | Stored; the report itself orders by `screenPageViews` desc in code. |
| `start_date` | select (1 day … 2 years, or launch date) | Number of days → `"{n}daysAgo"` start of the GA `DateRange`. |
| `number_items` | number (10–100000) | GA report `Limit`. |
| `use_next_page_token` | checkbox | Stored; when unset, deletes state `easy_google_analytics_counter.next_page_token`. |
| `independent_cron` | checkbox | If **checked**, `hook_cron` does **not** fetch — you trigger fetches externally. |
| `debug` | checkbox | If on, `setData()` writes a CSV of GA path→alias mapping to `public://ga_alias_file.csv`. |

Note: schema declares `service_account_credentials_json` and `view_id` as `int` though they hold an
array / string respectively, and `debug` / `use_next_page_token` are written by the form but **not**
declared in the schema — harmless config-schema drift.

## Route & permission

- `easy_google_analytics_counter.admin_form` — path `/admin/config/easy_google_analytics_counter/admin`,
  `_form: AdminForm`, `_permission: 'administer site configuration'`, `_admin_route: TRUE`.
- Menu link `easy_google_analytics_counter.admin_form` under `system.admin_config_system` (weight 99).

There are no other routes: no controllers, no "refresh now" endpoint, no callbacks.

## Cron / refresh

- Standard: leave `independent_cron` off. `easy_google_analytics_counter_cron()` calls
  `_easy_google_analytics_counter_independent_cron()` → `->request()` on each Drupal cron run.
- External: check `independent_cron`, then call `_easy_google_analytics_counter_independent_cron()`
  from your own scheduler (it accepts an optional `$page_path` to fetch a single page).

## Google-side setup (from README)

Create a Google service account and download its JSON key (see Google's authentication guide), grant
it access to the GA4 property, then either point `service_account_credentials_json_path` at the key
file on disk or upload it in the form, and enter the numeric property id in **View ID**.

## Optional shipped view

`config/optional/views.view.popular_articles.yml` (`popular_articles`, page at `/popular-articles`,
menu link on `main`): a table of **published `article`** nodes with `page_views > 0`, sorted by
`page_views` desc, access `access content`. Filters to published articles only.
