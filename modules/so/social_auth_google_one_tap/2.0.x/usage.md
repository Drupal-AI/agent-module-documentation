<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Social Auth Google One Tap integrates Google One Tap login with the Social Auth framework.

---

Social Auth Google One Tap adds **Google One Tap login** to the Social Auth framework — the frictionless
Google sign-in prompt that returns an ID token (JWT) which the site exchanges for a login. It depends on the
Social Auth Google module, in the Social package.

Use it to offer Google One Tap sign-in. It touches authentication and — crucially — it does it **correctly**
(reviewed): the `OneTapController` **verifies the Google ID token server-side** using the official Google API
client (`$client = new GoogleClient(['client_id' => $clientId]); $payload = $client->verifyIdToken($idToken);`),
which validates the JWT's **signature against Google's public keys, the audience (your client_id), issuer and
expiry**, and it only logs the user in when a **valid** payload is returned (mapping the verified `sub` claim to
the account). So a forged/unsigned token is rejected — this avoids the classic One-Tap pitfall of trusting a
client-supplied token. Store the Google **client secret/ID** appropriately and use HTTPS. It grants access only
via the verified token. Configure the Google client ID.

---

- Add Google One Tap login.
- Return a Google ID token (JWT).
- Verify the ID token server-side.
- Use the official Google client verifyIdToken().
- Validate signature/audience/issuer/expiry.
- Log in only on a valid payload.
- Map the verified sub claim to the account.
- Reject forged/unsigned tokens.
- Avoid trusting a client-supplied token.
- Depend on Social Auth Google.
- Store the Google client ID appropriately.
- Configure the Google client ID.
- Handle One Tap login.
- Verify tokens.
- Configure OAuth.
- Log in via Google.
- Handle the integration.
- Provide One Tap.
- Secure the token flow.
- Provide Google One Tap.
