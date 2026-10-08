<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Creates an affiliate conversion when a new user self-registers while carrying an affiliate cookie.

---

Affiliate Registrations attributes new account signups to affiliates. It implements
`hook_user_insert()` and, when a truly anonymous self-registration is completed by a visitor who
carries a valid affiliate cookie, creates a `user_registration` affiliate conversion crediting the
referring affiliate, with the new user account as the conversion's parent entity. Accounts created by
an authenticated user (for example an administrator adding a user) are deliberately not tracked. The
module ships the `user_registration` conversion type; set its default commission and approval
behaviour on the affiliate conversion type form. Requires the `affiliated` base module.

---

- Reward affiliates for driving new user registrations to the site.
- Automatically credit the affiliate whose link cookied the visitor before they signed up.
- Attach the newly created user account to the conversion as its parent entity.
- Skip attribution for admin-created accounts (only genuine anonymous self-registration counts).
- Apply the conversion type's default commission to each registration conversion.
- Require manual approval of registration conversions before they count toward payouts.
- Auto-generate conversion labels from the registered user via the conversion type's label pattern.
- Run signup-referral programs alongside Commerce or Webform attribution from the same framework.
- Report referred registrations through the Affiliated conversions Views.
- Disqualify ineligible signups using the framework's pre-create conversion event.
- Track referrals even when click-entity storage is disabled (cookie-only tracking).
- Use it as a minimal example of building a custom conversion type on top of Affiliated.
