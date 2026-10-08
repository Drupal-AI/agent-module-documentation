<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Attempts displays the remaining login attempts for a user.

---

Login Attempts shows a user **how many failed login attempts remain** before their account is temporarily
blocked — it reads Drupal core's flood configuration (`user.flood`) and the core `flood` table to count
non-expired failed attempts, and warns "you have N failed attempts and can try M more times before your
account will be blocked temporarily." It requires PHP 8.3 and depends on core User, in the User interface
package.

Use it to give clearer feedback around login lockout. This is a **security-adjacent UX layer that builds on
core flood control** — it does **not** replace or weaken core's flood-based lockout (core still does the actual
blocking); it only surfaces the remaining-attempts count. Minor trade-off to be aware of: showing the exact
remaining count gives a brute-forcer feedback on how close they are to lockout, but since core already blocks
at the threshold this is a small, common trade for better usability. It has no access-control role. Configure
core's flood limits as usual.

---

- Show remaining login attempts.
- Read core's user.flood config.
- Count non-expired failed attempts.
- Warn before temporary blocking.
- Require PHP 8.3.
- Depend on core User.
- BUILD on core flood control (not replace it).
- Not weaken core's lockout.
- Note it reveals the remaining count.
- Have no access-control role.
- Configure core flood limits.
- Handle login feedback.
- Show attempt counts.
- Configure flood.
- Warn users.
- Handle the warning.
- Show lockout warning.
- Display attempts.
- Rely on core blocking.
- Provide login-attempt feedback.
