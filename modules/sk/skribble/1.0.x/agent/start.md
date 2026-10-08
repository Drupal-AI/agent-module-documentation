<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Skribble Integration (skribble) — agent index
**Digital-signature integration with skribble.com: build a signing request from a file, redirect the signer, and store the signed PDF.**

- **Version:** 1.0.x (1.0.2)
- **Core:** ^10 || ^11
- **Configure:** `/admin/config/services/skribble` (`administer site configuration`)
- **Entity:** `skribble_signing_request` (admin at `admin/structure/skribble-signing-request`; perms administer/view/create/edit/delete).
- **Key routes:** `skribble.start_signing_request` `/skribble/start/{file}` (logged-in); `skribble.finish_signing_request` `/skribble/finish/{signing_request}` (logged-in); `skribble.download_file` `/skribble/download/{file}/{expire}/{hmac}` (`_access: TRUE`, HMAC-guarded); `skribble.success_callback` `/skribble/callback/success/{uuid}` (`_access: TRUE`).
- **Services:** `skribble.api_client`, `skribble.security_key` (HMAC over private_key+hash_salt), `skribble.protected_link_generator`.
- **Hooks:** see `skribble.api.php`.

**Security:** credentials in config, not hardcoded; API calls use Guzzle default TLS verification (no `verify=>false`); protected download route is HMAC + expiry gated. The unauthenticated success callback is sound — it loads by unguessable UUID and re-fetches authoritative status from Skribble (authenticated) before marking SIGNED, so a forged callback cannot falsely complete a signature.

See [configure/settings.md](configure/settings.md)
