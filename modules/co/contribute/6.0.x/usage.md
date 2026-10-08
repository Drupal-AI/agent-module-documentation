<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Contribute adds a "Community Information" section to Drupal's status report (`/admin/reports/status`) that shows a site's Drupal.org account, Drupal Association membership, and contribution status, nudging owners to join and give back. Documented release: 6.0.0-beta1 (beta; version dir `6.0.x`).

---

The module ships one config object (`contribute.settings`) holding a `status` boolean plus an `account_type` (`user` or `organization`) and `account_id` (a Drupal.org username or exact organization name). A settings form at `/admin/reports/status/contribute/configure` (linked as a "Configure" tab from the Community Information section, opened as a modal) lets an admin with `administer site configuration` set, clear, or hide this information; the username field autocompletes against Drupal.org. The `contribute.manager` service queries Drupal.org's public api-d7 endpoints (user/organization JSON) and scrapes profile pages to derive three status blocks — account (name, join date, avatar, listed organizations), Drupal Association membership (member badge → "You Rock!"), and contribution activity (issue credits / contributions → "You are a Rockstar!") — each cached for one hour under the `contribute` cache tag. `hook_preprocess_status_report_page()` injects the rendered blocks into the status report's general info, `hook_page_attachments()` adds inline CSS setting the account/membership/contribution icons, and a "Community Information block" plugin exposes the same output as a placeable block. No local data is collected; all lookups are outbound calls to drupal.org for the single configured account. The module requires no non-core dependencies and defines no permissions of its own.

---

- Show your organization's Drupal.org profile, membership badge, and contribution status on the site's status report.
- Encourage a site owner to create a Drupal.org account when none is configured.
- Prompt individuals to purchase an individual Drupal Association membership.
- Prompt companies to become an organization member of the Drupal Association.
- Publicly acknowledge ("You Rock!") a configured Drupal Association member.
- Publicly acknowledge ("You are a Rockstar!") an account that has contributed back to Drupal.
- Link visitors/admins to ways to get involved in the Drupal community.
- Configure the tracked account via a modal form on the status report page.
- Autocomplete a Drupal.org username while configuring the module.
- Enter an organization's exact Drupal.org name (autocomplete unavailable for orgs).
- Validate the configured username/organization against Drupal.org on save.
- Clear the stored community information without disabling the feature.
- Hide the Community Information section entirely (disable display) while keeping the module enabled.
- Display the configured account's avatar / organization logo pulled from Drupal.org.
- Show how long the account has existed on Drupal.org ("On Drupal.org for X").
- List the organizations a configured user belongs to.
- Place a "Community Information block" in any theme region via Block layout.
- Surface the community reminder to any admin viewing the status report.
- Cache Drupal.org lookups for one hour to limit outbound requests.
- Invalidate cached community data on demand via the `contribute` cache tag.
- Fail gracefully (no matches / empty block) when Drupal.org is unreachable.
- Theme/override the section via the `contribute_status_report_community_info` template.
- Read the `contribute.manager` service from custom code to reuse account/membership/contribution status.
- Reset community info to defaults by re-running config import (`contribute.settings`).
- Drive DrupalCon/community-support messaging from the site's own admin dashboard.
