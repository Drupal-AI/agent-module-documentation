<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Password Protection Handler provides a Webform handler that supports password protection.

---

Webform Password Protection Handler adds a **webform handler that gates a form behind a shared password** —
users must enter the configured password before they can access/submit the webform. It depends on the Webform
module, in the Webform package.

Use it to add a simple shared-password gate to a webform. Understand what it is and its limits. **Security
caveats:** (1) the submitted password is compared to the configured one with **`===` (non-constant-time)** —
a theoretical timing side-channel; it should use `hash_equals()`. (2) The password is stored **in plaintext in
the handler configuration**, which is **config-exportable** (it can end up in version control / config sync) —
so treat it as a **low-value shared secret, not a strong credential**: don't reuse an important password, and
be aware anyone who can read the site config can read it. It is a lightweight access gate for a form, not
account authentication and not a substitute for real access control on sensitive data. Configure the form
password.

---

- Gate a webform behind a password.
- Require a shared password to access.
- Add a simple form gate.
- Depend on the Webform module.
- KNOW the compare is === (non-constant-time).
- Prefer hash_equals().
- KNOW the password is stored plaintext in config.
- Know the config is exportable (git/config sync).
- Treat it as a low-value shared secret.
- Not reuse an important password.
- Not treat it as account auth or real access control.
- Configure the form password.
- Handle form password protection.
- Gate the form.
- Configure the handler.
- Protect the webform.
- Handle the gate.
- Password-protect forms.
- Set the password.
- Provide form password protection.
