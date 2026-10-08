<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Registration restricts who can register on the site by matching the email address domain against an allowlist or blocklist of domains (with wildcard support).

---

The module adds a validation handler to the user registration form
(`hook_form_user_register_form_alter` → `domain_registration_user_register_validate`). On
submit it takes the domain part of the entered email (everything after `@`) and matches it
against a configured list of domain patterns. An admin form at
`/admin/config/system/domain_register` (route `domain_registration.admin_form`, permission
`administer domain registration`) configures three settings: **method** — `Allow only
domains listed` (0, default) or `Prevent domains listed from registering` (1); **pattern**
— a textarea of domains, one per line, supporting `*` (any sequence) and `?` (single char)
wildcards, compiled to a case-insensitive anchored regex by
`domain_registration_wildcard_match()`; and **message** — the error shown when validation
fails. The `DomainRegistrationPattern` service (`domain_registration.pattern`) reads the
pattern list from config. If no patterns are configured, no restriction is applied (open
registration). Settings are stored in `domain_registration.settings` (config schema +
config translation). There are no Drush commands. Note: validation only runs on the standard
user registration form — administrative/programmatic user creation is not affected — and the
pattern list is split on `\r\n`, which is fragile for config set with Unix newlines.

---

- Allow only employees with a `@company.com` email to self-register.
- Restrict registration to a set of partner/customer domains.
- Block registrations from known throwaway/spam email domains.
- Permit any subdomain of a corporate domain with `*.company.com`.
- Allow several approved domains, one per line, in allow mode.
- Blocklist competitors' or abusive domains while leaving registration otherwise open.
- Reduce spam sign-ups by limiting to a trusted domain allowlist.
- Gate a member/intranet site so only the organization's email domain can register.
- Show a custom, branded error message when a disallowed email tries to register.
- Use `?` wildcards to match single-character domain variations.
- Restrict a university site to `*.edu` domains.
- Combine several patterns to cover multiple business units.
- Leave the pattern list empty to temporarily allow all registrations without uninstalling.
- Translate the rejection message per language (config translation supported).
- Delegate management of allowed domains to a specific role via the dedicated permission.
- Prevent free-email domains (e.g. block `gmail.com`, `yahoo.com`) in deny mode.
- Enforce a single-tenant SaaS sign-up policy by email domain.
- Quickly switch between allow and deny strategies from one radio setting.
