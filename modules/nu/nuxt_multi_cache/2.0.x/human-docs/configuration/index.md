# Configuration

Nuxt Multi Cache needs two things to work: **where** to send purge requests (the
Nuxt cache endpoint) and **how to authenticate** them (a shared token/secret).
Both are set once, after which content changes in Drupal drive cache invalidation
on the Nuxt front end automatically.

## The Nuxt cache endpoint

Point Drupal at the URL of your Nuxt front end's `nuxt-multi-cache` endpoint — the
address Drupal calls to purge cache entries. This is an admin‑set outbound URL, so
it should be one you control and it should be reachable from the Drupal server.
Prefer **HTTPS**, since the purge request carries the authentication token.

## The purge token / credentials

The Nuxt cache endpoint should be **authenticated** so that only Drupal can trigger
purges — otherwise anyone who can reach the endpoint could flush your front‑end
cache at will. The `nuxt-multi-cache` module authenticates purge requests with a
shared token/secret; Drupal must send the matching value.

**Treat this token as a secret.** Do not paste it into plain configuration that
gets exported and committed. Store it in an environment variable and reference it
through a Key entity:

1. **Save the value into DDEV's environment** (never commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --nuxt-purge-token=<value>
   ddev restart
   ```

   The flag `--nuxt-purge-token` becomes the variable `NUXT_PURGE_TOKEN`.

2. **Confirm it is present in the container without printing it:**

   ```bash
   ddev exec 'test -n "$NUXT_PURGE_TOKEN"'   # exit status 0 means it is set
   ```

3. **Create a Key** backed by that environment variable (install the Key module
   first if needed — `ddev composer require drupal/key` and `ddev drush en key -y`):

   ```bash
   ddev drush key:save nuxt_purge_token \
     --label='Nuxt purge token' \
     --key-type=authentication \
     --key-provider=env \
     --key-provider-settings='{"env_variable":"NUXT_PURGE_TOKEN","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

4. In the module's settings, select that Key (or otherwise reference the
   environment variable) as the purge credential, rather than typing the raw token
   into the form.

## Egress

Because Drupal makes outbound HTTP requests to the Nuxt endpoint, make sure the
Drupal environment is allowed to reach it. In locked‑down hosting where outbound
traffic is filtered, allow egress to the Nuxt cache endpoint's host, or purges
will silently fail to arrive.

## Save and verify

Save the configuration, then edit and save a piece of content in Drupal. Confirm
the matching Nuxt cache entry is purged (the front‑end page shows the change). If
nothing happens, check that the endpoint URL is correct and reachable, that the
token matches the one the Nuxt endpoint expects, and that outbound requests are not
being blocked.
