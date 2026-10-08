# Configuration

Setting up Easy Google Analytics Counter has a Google side and a Drupal side: create
API access in Google, enter the details in Drupal, let cron pull the numbers, then
use the resulting `page_views` data in Views.

## 1. Set up access in Google

Following Google's own Analytics reporting API documentation, create the API
project / credentials that will let Drupal read your Analytics data (this is the
setup step Google describes for its reporting API). Keep the resulting
credential values handy — and treat them as secrets, as covered in
[Installation](../installation/index.md).

## 2. Enter the details in Drupal

1. Log in as an administrator.
2. Go to `/admin/config/easy_google_analytics_counter/admin`.
3. Enter the connection details for your Google Analytics property (the credentials
   and the property/view the counts should come from).
4. Save.

## 3. Schedule cron

The module refreshes its figures on **cron**. Make sure cron runs regularly on the
server — either Drupal's built‑in cron or, better for reliability, a real scheduled
task (for example a system cron job calling `drush cron`). Each run re‑fetches the
aggregated page‑view data from Google Analytics and updates the stored counts.

## 4. Use the counts in Views

Once cron has populated the data, the **`page_views`** column on `node_field_data` is
available in Views. Build or update a View to:

- **show** the page‑view count as a field on a listing,
- **sort** content by it (for a "most viewed" block or page), and/or
- **filter** on it (for example, only content above a view threshold).

That's the payoff — popularity data driven straight from Google Analytics, with no
local counter to maintain.

## Privacy and credential scope

The module reads analytics data *from* Google (Drupal → Google Analytics); it is not
itself the visitor‑tracking snippet. Even so, keep the Google credential **scoped to
just the reporting access it needs**, store it as a secret, and confirm that pulling
this data into Drupal fits your organisation's data‑handling policy.
