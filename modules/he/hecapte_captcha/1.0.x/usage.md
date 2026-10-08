<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HeCAPTe CAPTCHA provides a HeCAPTe proof-of-work challenge for the CAPTCHA module.

---

HeCAPTe CAPTCHA **provides a proof-of-work CAPTCHA challenge** for the CAPTCHA module — the browser solves a
computational challenge served by an external HeCAPTe server, deterring automated form submissions. It depends on
the CAPTCHA module.

Use it as a privacy-friendly, no-puzzle CAPTCHA. It is a spam-control feature, and it is implemented correctly on
the crucial point: the challenge solution is **verified server-side** — Drupal's `validate()` calls the HeCAPTe
server's `/verify` endpoint from the server and only accepts the submission when the response `status` is `ok`
(the client can't self-assert success). Security notes: it depends on the **external HeCAPTe server** (egress to
`/challenge` in the browser and `/verify` from Drupal), so ensure the verify step **fails closed** if the server
is unreachable/errors (don't let a verify failure pass the form), configure a sensible verify timeout, and use a
trusted HeCAPTe server over HTTPS. It has no access-control role. Configure the HeCAPTe server URL.

---

- Provide a proof-of-work CAPTCHA.
- Serve a challenge from a HeCAPTe server.
- Deter automated submissions.
- Depend on the CAPTCHA module.
- Serve spam control.
- Be a no-puzzle CAPTCHA.
- VERIFY the solution server-side (Drupal calls /verify, requires status 'ok').
- Not let the client self-assert success.
- Depend on the external HeCAPTe server (egress to /challenge and /verify).
- FAIL CLOSED on verify errors/unreachable server + sensible timeout + HTTPS.
- Have no access-control role.
- Configure the HeCAPTe server URL.
- Handle CAPTCHA.
- Challenge users.
- Configure the server.
- Verify solutions.
- Handle the challenge.
- Block bots.
- Fail closed.
- Provide a proof-of-work CAPTCHA.
