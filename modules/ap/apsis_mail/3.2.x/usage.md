<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: connects Drupal to APSIS's REST API for newsletter/mailing-list subscription, with a block and a queue worker.
- When: you use APSIS as your email-marketing platform and want site visitors to subscribe to its mailing lists.

---

- Enable the module (depends on core `block` and `user`); default endpoint `se.api.anpdm.com:8443` ships in config.
- Configure at `/admin/config/services/apsis_mail` (route `apsis_mail.admin`, `administer apsis mail`); store the API key (kept in `state`, not config).

---

- Permissions: `administer apsis mail` and `view apsis mail block` (both `restrict access: FALSE`).
- Service `apsis` (`Apsis`) wraps a Guzzle client and maps API errors to typed exceptions.
- The API key is sent as an HTTP `Basic` Authorization header, not in the URL.
- TLS is controlled by the `api_ssl` config flag: on → `https://`, off → `http://` (plaintext; enable SSL in production — see note).
- A separate `apsis.prequeue` client uses a 5s timeout so requests defer to the queue before timing out.
- Queue worker `AddSubscriber` processes the `apsis_mail_add_subscriber` queue asynchronously.
- Block `ApsisMailSubscribeBlock` renders the `SubscribeForm` for visitors with `view apsis mail block`.
- Responses can be cached via `cachableRequest` with a configurable `cache_lifetime` (default 30s).
- Place the subscribe block in a region to collect email opt-ins.
- Map site user roles to mailing lists using the `user_roles` config.
- Configure `api_url`, `api_port`, and `api_ssl` to point at your APSIS environment.
- Errors surface as `ApsisException` subclasses (Unauthorized, BadRequest, OptOut, etc.).
- Keep the API key in `state` (as designed) so it is not exported with config.
- Test subscription end-to-end after configuring the key and endpoint.
- Set `api_ssl` on so the API key is not transmitted over plaintext HTTP.
- Version 3.2.x targets Drupal 9/10.
