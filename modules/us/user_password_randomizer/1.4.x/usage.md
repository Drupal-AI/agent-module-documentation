<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Password Randomizer prevents password-based logins by uid 1 by setting its password to a random value, a superuser-hardening measure.

---

User Password Randomizer is a security-hardening module that prevents password-based logins by
user 1 (the superuser) — it sets uid 1's password to a random value so the account cannot be logged into
with a known/guessed password. This addresses the risk of the all-powerful uid-1 account being a target
for brute force or a leaked/weak password: with a randomized password, uid-1 access must instead come
through other controlled means (a role with equivalent permissions, one-time-login links, or Drush).
It requires PHP 8.1 and is configured at `user_password_randomizer.settings`; it provides its own
permissions.

Use it as a defense-in-depth measure on sites following the best practice of not using uid 1 for daily
administration. This is a positive security control. When adopting, ensure you retain a legitimate way
to perform superuser tasks (a dedicated admin role, `drush uli`, or config access) before randomizing
uid 1's password, so you don't lock yourself out. Confirm the randomization behaviour matches your
recovery plan.

---

- Randomize uid 1's password.
- Block password login for the superuser.
- Harden the all-powerful uid-1 account.
- Prevent brute force of user 1.
- Require PHP 8.1.
- Configure at user_password_randomizer.settings.
- Provide its own permissions.
- Follow best practice of not using uid 1.
- Keep a way to do superuser tasks.
- Use drush uli for uid-1 access.
- Use a dedicated admin role instead.
- Avoid locking yourself out.
- Apply defense-in-depth.
- Neutralize a leaked uid-1 password.
- Confirm your recovery plan.
- Randomize the superuser password.
- Protect the superuser account.
- Reduce uid-1 attack surface.
- Enforce non-password uid-1 access.
- Add superuser hardening.
