<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TFA Headless provides a headless (API) implementation of two-factor authentication.

---

TFA Headless **adds two-factor auth to headless/API logins** — integrating the TFA (Two-Factor Authentication)
module with Simple OAuth so decoupled/API clients must complete TFA before an OAuth token is issued (it alters the
`/oauth/token` endpoint response). It depends on the TFA, REST, User, Simple OAuth and REST UI modules.

Use it to enforce 2FA for headless/API authentication. It is an **authentication** feature. Security essentials:
the value of TFA depends on it being **enforced, not bypassable** — verify that a client genuinely cannot obtain a
usable OAuth token without completing the second factor (test the flow, including edge cases like refresh tokens and
already-issued tokens), keep the Simple OAuth keys/secrets secured, and serve over HTTPS. It layers on TFA + Simple
OAuth. Configure the headless TFA flow.

---

- Add 2FA to headless/API logins.
- Integrate TFA with Simple OAuth.
- Require TFA before issuing an OAuth token.
- Depend on TFA + Simple OAuth + REST.
- Serve authentication.
- Alter the /oauth/token response.
- DEPEND on TFA being enforced, not bypassable.
- Verify a client can't get a usable token without the second factor (test refresh/edge cases).
- Keep the Simple OAuth keys/secrets secured + HTTPS.
- Layer on TFA + Simple OAuth.
- Configure the headless TFA flow.
- Handle headless TFA.
- Enforce 2FA.
- Configure the flow.
- Require 2FA.
- Handle the token endpoint.
- Verify factors.
- Gate tokens.
- Test the enforcement.
- Provide headless TFA.
