<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OwnID provides a seamless web-based authentication.

---

OwnID provides **passwordless / biometric web authentication** via the OwnID service — letting users log in
with device biometrics/passkeys instead of passwords, through OwnID's SDK/flow. It is in the Authentication
package.

Use it to offer passwordless login. It is an authentication feature and it is **security-critical**: it ties
login to OwnID's verification, so review how the trust is established in your setup — the OwnID **API
credentials/keys** must be stored as **secrets** (env/Key) over HTTPS, the assertion OwnID returns must be
**validated server-side** before establishing a Drupal session (never trust a client claim of "authenticated"),
and account mapping should be unambiguous. Verify the token/verification flow before relying on it for login. It
layers on core authentication. Configure the OwnID credentials.

---

- Provide passwordless/biometric login.
- Use OwnID's SDK/flow.
- Log in with passkeys/biometrics.
- Serve authentication.
- Replace passwords.
- Tie login to OwnID verification.
- BE security-critical.
- Store the OwnID credentials as secrets (HTTPS).
- VALIDATE OwnID's assertion server-side before a session.
- Ensure unambiguous account mapping.
- Verify the token/verification flow before relying.
- Layer on core authentication.
- Handle OwnID login.
- Authenticate users.
- Configure the credentials.
- Log users in.
- Handle the integration.
- Enable passwordless.
- Verify the flow.
- Provide passwordless auth.
