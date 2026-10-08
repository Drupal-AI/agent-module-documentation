<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BurnAfter provides a `burnafter` entity type for one-time / ephemeral content ("burn after reading"): each entity holds a body that is exposed at a hard-to-guess UUID URL and is meant to self-destruct after a configured number of views or after a time. Content can optionally be encrypted at rest using the Encrypt module and a configured encryption profile.

Use it for sharing a password, token, or note that should disappear once viewed or expired.
---
Enable with `drush en burnafter`. It relies on the contrib `encrypt` module (its service wires `@encrypt.encryption_profile.manager`) — install Encrypt and configure an encryption profile if you enable encryption at `/admin/config/system/burnafter` (route `burnafter.settings`, permission `administer burnafter settings`).

Create entities at `/burnafter/add` (permission `create burnafter entity`). They are viewed at `/burnafter/{uuid}` where `{uuid}` must match a UUID regex; the route uses a custom param converter and `no_cache: TRUE`. Viewing requires the `view burnafter entity` permission and is enforced by an entity access handler. On view the controller decrypts (if enabled), increments `view_count`, and re-saves; expired/over-viewed entities are removed by `BurnAfterService::deleteExpired()` (run on cron). Content is rendered with `#plain_text`, avoiding XSS.
---
- Share a one-time secret via an unguessable UUID link.
- Send a password that self-destructs after one view.
- Expire a note after a set number of reads.
- Auto-delete sensitive content after a time window.
- Encrypt shared content at rest via the Encrypt module.
- Gate secret creation behind a dedicated permission.
- Gate secret viewing behind a dedicated permission.
- Serve secrets uncached (`no_cache: TRUE`).
- Render content as plain text to avoid XSS.
- Clean up expired entities automatically on cron.
- Track how many times a secret has been viewed.
- Provide throwaway links for support handoffs.
- Distribute API tokens that vanish after use.
- Limit exposure window of a leaked credential.
- Configure the encryption profile centrally.
- Restrict admin settings to trusted operators.
- Replace emailing plaintext secrets with burn links.