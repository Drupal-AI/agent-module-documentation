<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Secret Registration Code provides a secret code field on the user registration form.

---

Simple Secret Registration Code (ssrc) **gates registration behind a secret code** — adding a field to the
user registration form that requires the registrant to enter a correct secret/invite code, so only people who know
the code can create an account. It provides its own permissions.

Use it to restrict who can self-register (e.g. an invite-only community). It is an access/registration-hardening
feature, and its strength depends entirely on the **secret code**: it is a **shared secret**, so a weak, short or
leaked code lets anyone register (the barrier is only as good as the code's secrecy). Best practice: use a
**strong, non-guessable code**, rotate it periodically (and after suspected leaks), don't expose it publicly, and
pair it with core protections (email verification, admin approval, flood control, CAPTCHA) rather than relying on
it alone. It layers on core registration. Configure the secret code.

---

- Gate registration behind a secret code.
- Add a code field to the registration form.
- Allow only code-holders to register.
- Provide its own permissions.
- Serve access/registration hardening.
- Restrict self-registration.
- DEPEND on the secrecy of a SHARED secret code.
- OPEN registration to anyone if the code is weak/leaked.
- Use a strong, non-guessable code + rotate it + don't expose it.
- Pair it with email verification/approval/flood control/CAPTCHA (not rely on it alone).
- Configure the secret code.
- Handle registration gating.
- Gate registration.
- Configure the code.
- Check the code.
- Handle the form.
- Restrict signup.
- Verify the code.
- Rotate the code.
- Provide a secret registration code.
