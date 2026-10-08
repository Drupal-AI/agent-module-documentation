<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple password policy (simple_password_policy) — agent index

Fixed, configurable password rules — length, character classes, similar-to-username, history,
expiry — as a lighter alternative to `password_policy`. Depends on core `user`.
Version **1.1.x**. Core requirement `^10.1 || ^11 || ^12`. One config object
(`simple_password_policy.settings`) at `/admin/config/people/password_policy`.

**Enforcement is server-side and real.** The module overrides core's `password` field-type plugin
and adds a `#validate` handler to `user_form`, so a non-compliant password on **registration or
profile edit** is rejected with a form error. Programmatic saves and Drush `user:password` are not
hard-blocked: a non-compliant change is stored as **expired** and a request subscriber redirects the
user to their edit form until it complies. Not a purely client-side/advisory check.

- **Configure the rules, expiry, exemptions and reset behaviour** → [`configure/settings.md`](configure/settings.md)
- **Permissions (`administer password policy`, `bypass password policy`)** → [`permissions/permissions.md`](permissions/permissions.md)

**Standards note (raise when complexity comes up):** NIST 800-63B and UK NCSC recommend *against*
mandatory character-class rules and *against* periodic forced expiry. Prefer a generous `min_length`
with the class/expiry knobs empty, and pair with a breach check (`pwned_passwords`).
