Username Enumeration Prevention hardens a Drupal site against attackers who probe the login, password-reset, and user-profile surfaces to discover which usernames and email addresses exist. It closes two enumeration vectors with no configuration: it makes the forgot-password form give a generic response for unknown accounts, and it turns "access denied" (403) responses on user routes into "not found" (404).

---

Out of the box Drupal leaks account existence in two ways: the forgot-password form (`/user/password`) shows a distinct error when a name or email is not registered, and a canonical user page like `/user/123` returns 403 (Access denied) when the account exists but the visitor lacks permission — versus 404 for a non-existent id — so an attacker can tell valid accounts apart. This module fixes both. A `hook_form_user_pass_alter()` adds a validation handler (`username_enumeration_prevention_pass_validate`) that clears the sensitive "no account" error on the `name` field, so submitting a valid or invalid identifier yields the same neutral outcome, and it logs a "Blocked user attempting to reset password" notice for auditing. A kernel `EXCEPTION` event subscriber (`UserRouteEventSubscriber`) inspects every `AccessDeniedHttpException` thrown on a user entity route (routes discovered from the user entity's link templates, plus `user.cancel_confirm` and `shortcut.set_switch`) and replaces it with a `NotFoundHttpException`, so unauthorized user pages return a uniform 404 instead of a revealing 403. There is no admin UI, no settings, and no permissions of its own — enable it and it works. Its only tuning point is Drupal's core `access user profiles` permission: any role granted that permission (especially anonymous) can view user pages directly, which re-exposes usernames, so the module's `hook_requirements()` adds a status-report warning when anonymous users hold that permission. It depends only on core `user` and supports Drupal 9.5, 10, and 11.

---

- Stop attackers from discovering valid usernames or emails through the forgot-password form.
- Return a generic, identical response whether or not a submitted account exists on `/user/password`.
- Turn 403 "Access denied" on `/user/123` into a 404 so account existence is not revealed.
- Harden a login-enabled site before a security audit or penetration test.
- Reduce the value of credential-stuffing and phishing target lists built from enumerated accounts.
- Prevent the "recover password" flow from confirming that an email address has an account.
- Uniformly hide restricted user profile, edit, and cancel pages behind 404s.
- Comply with a security policy that forbids user-existence oracles.
- Keep the same protection across the whole user route set (view, edit, cancel-confirm, shortcut switch) automatically.
- Log password-reset attempts against blocked or unknown accounts for monitoring.
- Deploy a "set it and forget it" security module with zero configuration.
- Add defense-in-depth on a site that also uses rate limiting or CAPTCHA on login.
- Surface a status-report warning when anonymous users can access user profiles.
- Audit whether any role's `access user profiles` permission undermines the protection.
- Protect member directories and community sites where usernames are sensitive.
- Avoid leaking author accounts on a content site through direct `/user/N` probes.
- Meet OWASP guidance on not disclosing account existence via authentication error messages.
- Harden a multisite or distribution build by enabling one small dependency-light module.
- Keep the mitigation working after upgrades since it derives routes from the live user entity definition.
- Cache the computed set of user route IDs so the exception handling stays cheap.
- Enable protection on Drupal 9.5, 10, or 11 with only core `user` as a dependency.
- Prevent enumeration without customizing or overriding core forms yourself.
- Pair with a strong password policy so leaked-account guessing is doubly hard.
- Confirm anonymous users lack `access user profiles` so `/user/N` stays a 404 for them.
