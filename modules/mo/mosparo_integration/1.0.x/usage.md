<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
mosparo Integration integrates the mosparo spam-protection system with Drupal forms.

---

mosparo Integration integrates **mosparo** — a privacy-friendly, self-hostable spam-protection system — with
Drupal forms, via `mosparo_captcha` (CAPTCHA integration), `mosparo_contact` (contact forms) and
`mosparo_webform` (Webform) submodules. It provides its own permissions, in the Spam control package.

Use it to protect forms from spam with mosparo. This is a **security/anti-abuse-positive** feature, implemented
the right way (reviewed): each submission is **re-validated server-side against the mosparo API**
(`verifySubmission()`), requiring `isSubmittable()` **and** a matching required-field set (defends against field
tampering), and is **fail-closed** (API errors block the submission) — it does not merely trust a client token.
**TLS verification is on by default** (`verifySsl` defaults TRUE; the Guzzle client uses `'verify' =>
shouldVerifySsl()`). Two caveats: an admin toggle *can* disable TLS verification (off by default — don't enable
it against a public mosparo), and the mosparo **private key is stored in plaintext config** (config-exportable
— prefer storing it via the Key module). Configure the mosparo connection.

---

- Protect forms with mosparo.
- Integrate CAPTCHA/contact/webform.
- Re-validate submissions server-side.
- Require isSubmittable() + matching field set.
- Defend against field tampering.
- Fail closed on API errors.
- NOT merely trust a client token.
- Keep TLS verification on (default).
- Not disable TLS against a public mosparo.
- Prefer the Key module for the private key.
- Provide its own permissions.
- Configure the mosparo connection.
- Handle spam protection.
- Verify submissions.
- Configure mosparo.
- Block spam.
- Handle the integration.
- Protect forms.
- Secure the connection.
- Provide mosparo protection.
