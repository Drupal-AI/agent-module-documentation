<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Secure Password Reset makes the password reset form more secure by not disclosing valid usernames.

---

Secure Password Reset **hardens the password-reset form so it doesn't disclose whether a username/email
exists** — replacing core's behaviour (which reveals "no account with that name") with a neutral message, to
prevent **user/account enumeration** via the reset form. It works across core 8–11.

Use it to close the reset-form enumeration vector. This is a **security-positive** hardening module: user
enumeration lets attackers build target lists (for credential-stuffing/phishing), and the reset form is a common
leak; this returns the same neutral response whether or not the account exists. It has no access-control role.
Enable it to harden the reset form.

---

- Hide whether a username/email exists.
- Give a neutral reset-form response.
- Prevent user enumeration.
- Replace core's revealing behaviour.
- BE security-positive.
- Serve authentication hardening.
- Close the reset-form enumeration vector.
- Deny attackers a target list.
- Return the same response regardless of existence.
- Have no access-control role.
- Enable it to harden the form.
- Handle reset hardening.
- Harden the form.
- Configure nothing (behavior).
- Neutralize the message.
- Handle the reset.
- Prevent enumeration.
- Secure the form.
- Enable it.
- Provide reset-form hardening.
