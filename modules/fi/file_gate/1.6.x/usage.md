<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate gates access to private files with pluggable methods and delivers them to any decoupled front end.

---

File Gate **gates access to private files with pluggable methods** — for `private://` files it supports
delivery via **short-lived signed URLs**, authenticated access and other pluggable grant methods, so a decoupled
front end can obtain a time-limited link to a protected file. It depends on core File, provides its own
permissions, in the Security package.

Use it to serve private files to decoupled/headless front ends securely. This is a **security-positive** file-access
module built the right way: it implements `hook_file_download()` and **denies by default** (returns `-1`) unless a
valid grant is present; grants are **HMAC-signed** (a `GrantSigner` computes a signature over the resource id +
claims + a secret from a secret registry, with a short TTL), so a link can't be forged or reused past its
expiry. Security essentials: keep files on the **`private://` scheme** (public files bypass all gating), **store
the signing secret securely** (env/Key/secret registry — a leaked secret lets anyone mint valid links), use short
TTLs, and serve over HTTPS. It provides this specific access mechanism. Configure the grant method and signing
secret.

---

- Gate access to private files.
- Support short-lived HMAC-signed URLs.
- Deliver files to decoupled front ends.
- Depend on core File + provide permissions.
- Serve security.
- Offer pluggable grant methods.
- DENY by default via hook_file_download (returns -1) unless a valid grant.
- Sign grants with HMAC over resource id + claims + a secret (short TTL).
- Keep files on private:// (public files bypass gating).
- Store the signing secret securely (env/Key — a leak lets anyone mint links).
- Use short TTLs + serve over HTTPS.
- Configure the grant method and signing secret.
- Handle private file access.
- Gate files.
- Configure the grants.
- Sign URLs.
- Handle the download hook.
- Serve files.
- Secure the secret.
- Provide private-file gating.
