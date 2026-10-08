<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apsis_mail

APSIS email-marketing REST integration with a subscribe block + queue.

- Service `apsis` (`src/Apsis.php`) over Guzzle; API key from `state` (`apsis_mail.api_key`), sent as Basic auth header (not in URL).
- Admin form `/admin/config/services/apsis_mail` (`administer apsis mail`). Perms: `administer apsis mail`, `view apsis mail block`.
- Block `ApsisMailSubscribeBlock` + `SubscribeForm`; queue worker `AddSubscriber`.
- TLS is opt-in via config `api_ssl`; when off the base URL is `http://` (plaintext). No hardcoded verify=>false.

See [../usage.md](../usage.md).
