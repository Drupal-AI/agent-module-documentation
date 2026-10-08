<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Affiliate tracks referrals via a cookie and records the referrer on new user accounts.

---

Simple Affiliate provides a lightweight referral system. A block outputs a per-user affiliate URL pointing at `/simple_affiliate/set-tracking-cookie/{uid}`; visiting it sets a `simple_affiliate` cookie (6-month expiry) with that uid and redirects to the registration form. On `hook_user_insert`, the cookie value is stored into the `field_simple_affiliate_referrals` user entity-reference field, and a 'Simple Affiliate Dashboard' View lists referrals. The tracking route uses the `access content` permission. Ships field, field-storage and View config.

---

- Give each user a personal affiliate link.
- Set a referral tracking cookie on click.
- Persist the referral for six months.
- Redirect visitors to registration after tracking.
- Record the referrer on new user accounts.
- Store the referrer in a user reference field.
- List referrals in a dashboard View.
- Show an affiliate-link block to logged-in users.
- Attribute new signups to an affiliate.
- Run a simple referral marketing program.
- Provide a page and block for referral data.
- Work on Drupal 8, 9 and 10.
- Add an entity-reference field to users.
- Avoid a full commerce/affiliate suite.
- Track without third-party services.
- Configure referrals through Views.
