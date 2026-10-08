<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pwned Passwords checks a password against Have I Been Pwned's breach corpus and warns or blocks when it appears there.

---

Password rules that demand a symbol and a digit select for `Password1!`, which is in every breach list; checking against the corpus of actually-leaked passwords is the measure that current guidance — NIST 800-63B among others — recommends instead, and it is far more effective because it targets the passwords attackers actually try. The privacy design is the first question anyone should ask and this one answers it correctly: the underlying `esolitos/pwnedpasswords` library uses the **k-anonymity range API**, sending only the **first five hex characters** of the password's uppercase SHA-1 and comparing the full hash locally against the returned candidates — the plaintext never leaves the server and neither does the complete hash. Version **8.x-1.4** on core `^10.6 || ^11`, configured at `/admin/config/people/pwnedpassword`. Three things to know before deploying it. **The shipped defaults only warn** — `threshold_error: 0` and `error_blocks_submit: false`; set a threshold and enable blocking to enforce a policy. **Use the per-form options** rather than the global `validate_all_passwords` option. And **the check is a synchronous outbound request** with a two-second timeout built on a bare Guzzle client that ignores Drupal's proxy configuration, which matters most if it is enabled on the login form.

---

- Reject passwords found in breach corpora.
- Warn a user their password is compromised.
- Meet a NIST 800-63B recommendation.
- Replace complexity rules with breach checking.
- Check passwords at registration.
- Warn on login about a leaked password.
- Improve account security cheaply.
- Block a known-compromised password.
- Check passwords without sending them anywhere.
- Meet a security audit requirement.
- Reduce credential-stuffing exposure.
- Set a breach-count threshold.
- Warn without blocking submission.
- Protect administrator accounts.
- Improve a membership site's password hygiene.
- Add breach checking to a user form.
- Support a password policy programme.
- Give users a reason to change a password.
