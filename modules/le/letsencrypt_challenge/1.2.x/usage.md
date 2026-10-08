<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Let's Encrypt Challenge serves the ACME HTTP-01 validation response from Drupal, so a TLS certificate can be issued or renewed on a host where you cannot drop a challenge file into the docroot yourself.

---

The HTTP-01 challenge works by the ACME server (Let's Encrypt) fetching `/.well-known/acme-challenge/<token>` and checking that the body is the expected key authorization. Normally the ACME client writes that file into the web root, which needs filesystem access there — not available on a platform-as-a-service host, a read-only container image, or a site whose docroot is rebuilt by the deployment pipeline. This module serves the response from Drupal instead: an administrator pastes the key-authorization value into the form at `/admin/config/letsencrypt_challenge/challenge` (route `letsencrypt_challenge.challenge_form`, permission `administer letsencrypt challenge`), and two routes at `/.well-known/acme-challenge` and `/.well-known/acme-challenge/{key}` return it. The value is kept in the key/value **state** store under `letsencrypt_challenge.challenge`, so it is not part of a config export and is deleted on uninstall. `ChallengeController::content()` returns the same stored value for either route — the `{key}` segment is ignored — so it fits the single-challenge manual flow rather than several concurrent challenges. Both serving routes set `_disable_route_normalizer: 'TRUE'` so the path is matched exactly. This is for the manual ACME mode; an automated client that can write files into the docroot needs none of this. The newest release on the 1.2.x branch is 1.2.0-beta1.

---

- Renew a certificate on a host without docroot write access.
- Serve an ACME HTTP-01 challenge from Drupal itself.
- Complete HTTP-01 domain validation manually.
- Issue a certificate on a read-only container image.
- Renew TLS on a platform-as-a-service host.
- Paste a key authorization from a manual certbot / lego / acme.sh run.
- Avoid writing files into a rebuilt docroot.
- Handle validation where the web root is ephemeral.
- Renew a certificate without shell access to the web root.
- Support a manual certificate issuance workflow.
- Restrict challenge configuration to administrators via `administer letsencrypt challenge`.
- Serve the challenge at the exact `/.well-known/acme-challenge/{token}` path.
- Keep the challenge value out of config exports (stored in state).
- Set the challenge value from Drush with `drush state:set letsencrypt_challenge.challenge`.
- Complete validation during a maintenance window.
- Support a site behind a CI/CD deployment pipeline.
- Re-issue a certificate after an expiry incident.
- Validate a domain newly pointed at the site.
- Bridge HTTP-01 validation on Apache after allowing the path in `.htaccess`.
- Drive certificate renewal from an external orchestration script that sets state then triggers the ACME server.
