<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Uber Affiliate is a configurable affiliate program: each affiliate gets a tracking link, clicks are recorded and credited, and admins manage payouts and reports.

---

Uber Affiliate tracks referral click-throughs. A dynamic route (built by `AffiliateRoute::routes()` from `affiliate_module_affiliate_menu_path`) of the form `{menu}/{aff_id}/{dest_path}/{tracker_id}` (permission `track affiliate clicks for this role`) validates a click, credits the affiliate in the `affiliate_clicks` table, and redirects to the destination path. Destinations are validated with `path.validator` and rejected if external. Users can opt in/out, view their own stats (`user/{uid}/affiliate`), and admins get an overview, top-users report, per-user pages, payout and payment forms under `admin/config/people/affiliate` (permission `administer affiliate settings`). Settings (payout amounts/symbols, ignored users/IPs, referrer checks, click throttling) live in `uber_affiliate.settings`.

---

- Give each affiliate a unique tracking link.
- Record referral click-throughs to a database table.
- Credit the correct affiliate for a click.
- Redirect visitors to the destination after tracking.
- Reject external redirect destinations.
- Let users opt in or out as affiliates.
- Show users their own affiliate stats and payouts.
- Provide an admin overview of all affiliates.
- Report top affiliates over a time window.
- Manage payouts owed and paid per affiliate.
- Throttle repeat clicks by IP within an interval.
- Ignore clicks from configured users or IPs.
- Require an HTTP referrer for valid clicks (optional).
- Restrict tracking to selected roles via permission.
- Configure payout symbol, amount and placement.
- Limit tracking to allowed node types or all paths.
