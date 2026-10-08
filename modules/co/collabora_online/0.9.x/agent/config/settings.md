<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, Key setup, discovery & requirements

## Install / enable

`drush en collabora_online` (pulls in core `media` + contrib `key`; requires `firebase/php-jwt` and
`phpseclib/phpseclib` via Composer, normally satisfied by `composer require drupal/collabora_online`).
You also need a **running Collabora Online / CODE server** reachable from Drupal.

Setup order:
1. Create a signing key at `/admin/config/system/keys` → *Add key*, key type **JWT HMAC - Collabora
   Online** (`collabora_jwt_hs`). Generate a 64-byte value (`head -c 64 /dev/urandom | base64 -w 0`)
   or use the key type's own generator.
2. Configure the module at `/admin/config/cool/settings` (route `collabora-online.settings`, form
   `Form\ConfigForm`, permission `administer site configuration`).
3. Set a media type's display *Format* to a Collabora formatter (see
   [plugins/display.md](../plugins/display.md)) and grant the per-type permissions.

## Settings form (`ConfigForm`, config object `collabora_online.settings`)

All settings live under the `cool.` prefix. Schema in `config/schema/collabora_online.schema.yml`;
defaults in `config/install/collabora_online.settings.yml`.

| Config key | Form field | Type | Default | Purpose |
|-----------|-----------|------|---------|---------|
| `cool.server` | Collabora Online server URL | uri (required) | `https://localhost:9980/` | Base URL Drupal uses server-side to fetch `discovery.xml` (`{server}/hosting/discovery`). Must start `http://`/`https://`. |
| `cool.wopi_base` | WOPI host URL | uri (required) | `https://localhost/` | Base URL the Collabora server uses to reach Drupal's WOPI endpoints. Can differ from the public URL (internal network). |
| `cool.key_id` | JWT private key | key_select (required, filtered to `collabora_jwt_hs`) | `''` | Id of the Key entity holding the HS256 secret. |
| `cool.access_token_ttl` | Access Token Expiration | integer seconds (min 0) | `86400` | Lifetime of the minted JWT. 0 falls back to 24h in code. |
| `cool.discovery_cache_ttl` | Discovery cache TTL | integer seconds (min 0) | `3600` | How long `discovery.xml` is cached. 0 disables caching. Must be shorter than the proof-key rotation period. |
| `cool.new_file_interval` | Create new file on save after… | integer seconds (min 0) | `60` | Within this window a save overwrites the existing file; after it, a new file entity/revision is created. 0 = always overwrite. |
| `cool.disable_cert_check` | Disable TLS certificate check for COOL | boolean | `false` | Skips TLS verification on the server→Collabora discovery fetch. Labelled **INSECURE**; dev/self-signed only. |
| `cool.wopi_proof` | Verify proof header and timestamp | boolean | `true` | Enables the RSA WOPI-proof access check on incoming WOPI requests. |
| `cool.allowfullscreen` | Allow COOL fullscreen | boolean | `true` | Adds `allowfullscreen` to the editor iframe. |

## The JWT key type (`collabora_jwt_hs`)

`Plugin/KeyType/CollaboraJwtHs` (label "JWT HMAC - Collabora Online", group `encryption`,
`key_value` plugin `text_field`). Defining its own key type avoids a dependency on the `jwt` module.

- `generateKeyValue()` returns `random_bytes(64)` (twice the HS256 minimum).
- `validateKeyValue()` rejects any value shorter than **32 bytes** (256/8) with a translated error,
  so a too-weak secret cannot be saved.
- Config schema `key.type.collabora_jwt_hs` is an empty `sequence` (no configurable settings).

The secret itself is stored/managed by the **Key** module (env, file, config provider, etc.), not in
this module's config — `collabora_online.settings` only stores the key *id*.

## Discovery (`DiscoveryFetcher` / `Discovery`)

Service `Drupal\collabora_online\Discovery\DiscoveryFetcherInterface` →
`DiscoveryFetcher`:
- `getDiscoveryUrl()` trims `cool.server`, strips a trailing slash, requires an `http(s)://` scheme,
  and appends `/hosting/discovery`.
- `loadDiscoveryXml()` fetches it with Guzzle, honouring `cool.disable_cert_check`
  (`RequestOptions::VERIFY`). Failures throw `CollaboraNotAvailableException` and are logged to the
  `cool` channel.
- The raw XML is cached in `cache.default` under CID `collabora_online.discovery` for
  `cool.discovery_cache_ttl` seconds (tagged with the config's cache tags).
- `Discovery` wraps the parsed `SimpleXMLElement` and exposes `getWopiClientURL()`, the MIME→action
  map, and `getProofKey()` / `getProofKeyOld()` used by the WOPI proof check.

## Runtime requirements (`hook_requirements`, runtime phase)

`collabora_online.install` raises `REQUIREMENT_ERROR` when:
- the JWT key id is unset or the referenced Key entity does not exist;
- the Collabora server's `discovery.xml` cannot be fetched (`CollaboraNotAvailableException`);
- `cool.wopi_proof` is enabled but the discovery contains no proof keys (current or old).
