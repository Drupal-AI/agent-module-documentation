<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Email extended validation adds opt-in, admin-selectable validation constraints to the user account email field to block disposable, synonym, and unwanted-domain addresses at registration and profile update.

---

Email extended validation (`email_validate`) attaches extra Symfony/Drupal validation constraints to the core `user` entity's `mail` field via `hook_entity_base_field_info_alter()`. It ships five independent constraints — Google-synonym blocking, Yandex-synonym blocking, an internal email-domain block list, a domain MX-record (DNS) check, and a remote disposable-email lookup against block-temporary-email.com — each of which the site administrator enables or disables individually on a settings form. Because the checks run on the `mail` base field, they fire wherever that field is validated: the anonymous user registration form, admin user-add/edit forms, and any programmatic `$account->get('mail')->validate()` call. A companion bulk form re-runs the enabled constraints across all existing user accounts and reports which stored addresses now fail. The module is anti-abuse tooling for reducing junk and disposable signups; it validates format and domain rules but does not itself verify that a user controls an address (pair it with core email verification).

---

- Block signups from disposable / temporary email addresses during user registration.
- Reject Gmail/Googlemail dot-and-plus synonyms of an already-registered address (e.g. `u.ser@gmail.com`, `user+tag@gmail.com`).
- Reject Yandex address synonyms across the many Yandex domains and dot/dash variants of an existing account.
- Maintain an internal block list of email domains you never want to accept (e.g. known spam or throwaway domains).
- Require that an email domain has a valid DNS MX record before accepting the address.
- Query a third-party disposable-email API (block-temporary-email.com) to flag temporary addresses.
- Turn each of the five checks on or off independently from one admin settings page.
- Enforce the same rules on admin-created accounts and profile-edit email changes, not just self-registration.
- Reduce fake-account spam and bot registrations that rely on throwaway inboxes.
- Prevent one person from creating multiple accounts using Gmail/Yandex alias tricks.
- Audit an existing user base by bulk-running the enabled constraints and listing accounts with now-invalid emails.
- Keep newsletter / mailing lists cleaner by rejecting undeliverable domains at capture time.
- Enforce email policy on custom forms that call `$account->get('mail')->validate()` programmatically.
- Add stricter email rules without writing a custom constraint plugin.
- Combine domain block list + MX check to reject both blacklisted and non-mail-serving domains.
- Localize the third-party disposable-email lookup by pointing the API URL/token at your own endpoint.
- Stop churn from users cycling disposable inboxes to re-trigger promotions or trials.
- Complement CAPTCHA/anti-spam modules with an email-quality layer.
- Provide a Security-package building block for a spam-resistant registration flow.
- Fail open on the remote API (registration is not blocked if the external service is unreachable) so uptime is preserved.
- Migrate off older single-purpose DEA modules onto one modern constraint-API-based module.
- Selectively enable only the low-cost local checks (block list, synonyms) where external calls or DNS lookups are undesirable.
