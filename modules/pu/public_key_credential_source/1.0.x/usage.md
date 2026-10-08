<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Public Key Credential Source stores WebAuthn public key credentials.

---

Public Key Credential Source **stores WebAuthn public-key credential sources** — the registered passkey/
security-key records (credential id, public key, sign counter, user handle) needed to authenticate users with
WebAuthn. It depends on JSON Field, Universal Device Detection and the WebAuthn Framework, provides its own
permissions.

Use it as the credential store for passkey/WebAuthn auth (e.g. under Decoupled Passkeys). It is an authentication-
data feature and it is **security-relevant**: it holds **authentication material** — note that WebAuthn stores
only the **public** key (not a secret), so the store itself is not a password vault, but the records still gate a
user's second/primary factor, so protect access to these entities (its permission), and rely on the WebAuthn
Framework to verify signatures and enforce the **sign counter** (clone detection). It has no broad access-control
role beyond its permission. It is used by passkey modules.

---

- Store WebAuthn credential sources.
- Hold registered passkey/key records.
- Keep credential id/public key/counter.
- Depend on JSON Field/WebAuthn Framework.
- Provide its own permissions.
- Back passkey authentication.
- Hold authentication material (public key, not a secret).
- Protect access to the credential entities.
- Rely on the framework to verify + enforce sign counter.
- Support clone detection.
- Have no broad access role beyond permission.
- Be used by passkey modules.
- Handle credential storage.
- Store credentials.
- Configure the store.
- Keep passkeys.
- Handle the entities.
- Store WebAuthn data.
- Protect the records.
- Provide WebAuthn credential storage.
