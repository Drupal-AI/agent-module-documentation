Mailchimp Transactional Reports adds an admin reporting dashboard (volume charts and an account summary) sourced from the Mailchimp Transactional API.

---

This submodule of Mailchimp Transactional provides two admin report pages under *Reports*: a **dashboard** at `admin/reports/mailchimp_transactional` (`ReportsController::dashboard`) that charts sent/bounced/rejected volume over time from the API's `getTagsAllTimeSeries()`, and an **account summary** at `admin/reports/mailchimp_transactional/summary` (`ReportsController::summary`) with account/user stats from `getUser()`. Data is fetched via a `ReportsService` that wraps the base module's API client and caches through the `cache.mailchimp_transactional` bin; charts use a small JS library (`reports-stats`) plus Google's chart jsapi. It has no config entities or settings of its own — its only local surface is the `view mailchimp transactional reports` permission it defines and its two routes. Note: the routing requirements reference `view mailchimp_transactional reports` (with an underscore) while the permission actually defined is `view mailchimp transactional reports` (with a space) — a mismatch that means, by default, only user 1 can reach the pages until that is reconciled.

---

- Give admins a Mailchimp Transactional sending dashboard inside Drupal.
- Chart email volume (sent / bounced / rejected) over recent hours/days.
- View an account/user summary (reputation, quota, stats) from the Transactional API.
- Monitor deliverability trends without logging into the Mailchimp dashboard.
- Spot a spike in bounces or rejects quickly from the volume chart.
- Provide a read-only reporting view for support or marketing staff (via the permission).
- Cache API report data to avoid repeated API calls (uses the mailchimp_transactional cache bin).
- Add a Reports menu entry linking to the transactional dashboard.
- Keep an eye on sending reputation as part of routine admin checks.
- Surface account quota/usage inside the Drupal admin.
- Combine with the base module to confirm your configured sending is actually flowing.
- Track the effect of a deliverability change over time via the volume series.
- Give ops a single Drupal page for at-a-glance transactional email health.
- Review recent activity when investigating a delivery complaint.
- Present sending stats to stakeholders without granting Mailchimp logins.
- Restrict report access to trusted roles with a dedicated permission.
- Use the account summary to verify the API key is connected and returning data.
- Watch reject rates to catch a compromised or misconfigured sender early.
- Complement the Activity submodule's per-entity view with an account-wide overview.
