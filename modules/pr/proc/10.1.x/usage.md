<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Proc provides client-side encryption with OpenPGP.js.

---

Proc provides **client-side (in-browser) encryption using OpenPGP.js** — encrypting file/field content in
the user's browser with OpenPGP before it reaches the server, so the server stores ciphertext it cannot read,
with `proc_janitor`, `proc_metadata_transitioner` and `proc_reporting` submodules. It depends on core File,
Options, User and Views, provides its own permissions.

Use it for end-to-end/client-side encryption of sensitive content. It is a security/privacy feature. Security
model to understand: encryption happens **client-side**, so security hinges on **key management** — the private
key/passphrase must be protected on the client and never sent to the server (verify how keys are stored/entered),
and the server genuinely cannot decrypt (which also means lost keys = lost data). Confirm the key-handling flow
fits your threat model, and note that client-side JS crypto depends on delivering the code over trusted HTTPS.
It provides encryption, not access-control gating. Configure the encryption and keys.

---

- Encrypt content client-side (OpenPGP.js).
- Store ciphertext the server can't read.
- Provide janitor/metadata/reporting submodules.
- Depend on core File/Options/User/Views.
- Provide its own permissions.
- Serve end-to-end encryption.
- HINGE security on client key management.
- Protect the private key/passphrase on the client.
- Never send the private key to the server.
- Know lost keys = lost data + rely on trusted HTTPS delivery.
- Provide encryption, not access gating.
- Configure the encryption and keys.
- Handle client-side PGP.
- Encrypt content.
- Configure the keys.
- Store ciphertext.
- Handle the encryption.
- Protect data.
- Manage keys carefully.
- Provide client-side encryption.
