Badgr Badge bridges Drupal with the badgr.com (Badgr / Open Badges) API so a site can import a Badgr account's issuers and badge classes and let logged-in users add earned badges to their Badgr Backpack.

---

The module connects to a single badgr.com account using the account's email and password (exchanged once for OAuth access/refresh tokens), then imports every issuer and badge class from that account into three Drupal content types (`badgr_account`, `badgr_issuer`, `badgr_badges`). Imported badges are listed by a bundled view at `/badgr-badges` in teaser view mode. Each teaser gets an AJAX "Add to Backpack" link (added by `badgr_badge_node_view()`) that, for the current logged-in user, calls the Badgr Assertions API to award the badge to that user's Drupal email — checking first whether they already hold it to avoid duplicates. Access tokens are auto-refreshed with the stored refresh token when they expire. The integration is one-directional and admin-driven: an administrator with the "administer badgr badge" permission configures the connection and imports, while badge awarding is exposed to authenticated site visitors through the backpack link. All Badgr API endpoints are fixed to `https://api.badgr.io` and TLS verification is enabled on every request.

---

- Connect a Drupal site to a single badgr.com account via email/password at `/admin/config/system/badgr-badge`.
- Obtain and store OAuth access + refresh tokens automatically after entering valid Badgr credentials.
- Import all issuers from the connected Badgr account into `badgr_issuer` nodes (logo, description, contact email, website URL, entity ID).
- Import all badge classes from the connected account into `badgr_badges` nodes (image, description, earning criteria, criteria URL, entity ID).
- Re-run the import to update existing issuer/badge nodes and add newly created ones (matched by Badgr entity ID).
- Present imported badges to visitors on a ready-made Views page at `/badgr-badges` using the badge teaser view mode.
- Let a logged-in user click "Add to Backpack" on a badge teaser to award themselves that badge on badgr.com.
- Award a badge to the current user's Badgr Backpack keyed on their Drupal account email (Assertions API).
- Prevent duplicate awards by first querying existing assertions for the user's email before issuing.
- Automatically refresh an expired access token using the stored refresh token and persist the new tokens.
- Attach badge and issuer images pulled from the Badgr API to the corresponding Drupal image fields.
- Publish digital credentials that recipients can share to LinkedIn, personal sites, and social media from their Badgr Backpack.
- Run an e-learning / training site where course completion is recognized with a shareable Open Badge.
- Give a community or membership site "achievement" badges that members collect in a portable backpack.
- Show a certifications gallery block by embedding or reusing the `badgr_badges` view.
- Let staff or event attendees self-claim participation/attendance badges from a badge listing page.
- Centralize badge definitions in badgr.com while surfacing and awarding them through the Drupal front end.
- Uninstall cleanly, removing all created content types, fields, view, and Badgr nodes via `hook_uninstall()`.
- Restrict configuration and import to trusted administrators through the "administer badgr badge" permission.
- Allow content editors to manually create additional badge nodes with the "create badgr badge" permission.
