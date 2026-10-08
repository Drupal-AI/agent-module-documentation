<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Hash generates user hashes.

---

User Hash **generates per-user hashes** — a random hash assigned to a user that can be used as a
token-style credential, and it ships an **authentication provider** that validates a username + hash to
authenticate a request (a bearer-token-like mechanism, e.g. for API access). It depends on core User, provides
its own permissions, in the Custom package.

Use it to give users hash-based API tokens. It is an authentication feature and its hash generation is sound:
the hash is `hash($algorithm, random_bytes($n))` — seeded from PHP's **`random_bytes()` CSPRNG** (default
sha256 over 32 random bytes), so hashes are unpredictable. Treat the hash as a **bearer credential**: it grants
access as the user, so transmit it only over **HTTPS** (never in a URL/query where it lands in logs), store it
securely, and provide a way to rotate/revoke it. It grants access via the auth provider. Configure the hash
length/algorithm and issue hashes to users.

---

- Generate per-user hashes.
- Use hash($algo, random_bytes($n)) (CSPRNG).
- Provide a hash auth provider.
- Validate username + hash to authenticate.
- Depend on core User.
- Serve API/token access.
- TREAT the hash as a bearer credential.
- Transmit it only over HTTPS.
- Never put it in a URL/query (logs).
- Store it securely + allow rotate/revoke.
- Provide its own permissions.
- Configure the hash length/algorithm.
- Handle user hashes.
- Issue hashes.
- Configure the auth.
- Authenticate via hash.
- Handle the tokens.
- Generate tokens.
- Secure the hash.
- Provide hash auth.
