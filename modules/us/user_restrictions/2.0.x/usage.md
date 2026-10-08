<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Restrictions defines admin-managed rules that refuse (or explicitly allow) account registration, login, and profile edits based on the entered username, the entered email address, or the client IP address.

---

The module restores the Drupal 7 "access rules" feature that core dropped in Drupal 8. Each rule is a `user_restrictions` configuration entity managed at `/admin/config/people/user-restrictions`, carrying: a **restriction type plugin** (`name`/Username, `user_restrictions_email`/Email, `user_restrictions_client_ip`/Client IP — third parties can add more), a **pattern**, an allow-or-reject flag (`pattern_type`, where `1` = allow / `0` = reject), the set of **forms** it applies to (`user_register_form`, `user_login_form`, `user_form`), and an **expiration** (a timestamp, or "never"). Enforcement is entirely form-based: `hook_form_alter` (running last) attaches validation handlers to the three user forms, and on submit `UserRestrictionsManager::matchesRestrictions()` loads all enabled, non-expired rules ordered by weight and tests each with `preg_match('/' . $pattern . '/i', $data)` against the submitted username, email, or the request's client IP. The **pattern is a raw, case-insensitive, un-anchored PCRE regular expression** — despite the older README's `%`/`.` wildcard wording, in 2.1.x you write regex directly (the form shows the `/…/i` delimiters and warns about ReDoS); regex metacharacters must be escaped to match literally. The first matching rule wins: an *allow* match permits the value and stops evaluation, a *reject* match logs a notice and sets a form error. Accounts (or the actor creating them) holding **`bypass user restrictions`** skip all checks. Client IP comes from Symfony's `Request::getClientIp()`, which honors Drupal's configured trusted reverse proxies rather than trusting a raw `X-Forwarded-For` header — so behind a CDN/load balancer the reverse-proxy settings in `settings.php` must be correct or rules match the proxy. Because enforcement lives only in form validation, account creation that does not go through those forms (programmatic `User::create()`, Drush, REST/JSON:API user provisioning) is **not** filtered. Cron deletes expired rules. Two module-defined permissions exist, both `restrict access: true`: `administer user restrictions` and `bypass user restrictions`.

---

- Block registrations whose email is at a disposable-mail or competitor domain (reject, Email, e.g. `@hotmail\.com$`).
- Allow only corporate email registrations (allow rule for `@example\.com$` plus a reject-all rule at higher weight).
- Reserve or ban specific usernames (reject, Username, e.g. `^admin`).
- Refuse usernames containing a banned word (reject, Username, un-anchored regex).
- Block a persistent abuser's client IP from registering or logging in (reject, Client IP).
- Restrict logins to accounts coming from an allowed IP range (allow, Client IP).
- Restore Drupal 7 "access rules" behaviour on a Drupal 10/11 site.
- Reduce spam-account signups on a community site.
- Prevent impersonation-style usernames (e.g. names mimicking staff).
- Temporarily block an email/username/IP with an expiration date, auto-removed by cron.
- Apply a rule to registration only, login only, profile edit only, or any combination.
- Exempt trusted staff from all rules via the `bypass user restrictions` permission.
- Enforce a username naming policy at registration time.
- Layer allow and reject rules by weight to build allow-list semantics.
- Block a whole email pattern site-wide across register, login, and edit forms.
- Add a custom restriction type (e.g. by a profile field) via the `UserRestrictionType` plugin API.
- Audit active restrictions and their patterns on the admin overview list.
- Enable/disable a rule without deleting it (CSRF-protected toggle).
- Match case-insensitively (the `/i` flag is always applied).
- Deny profile edits that would change an email/username into a banned value.
