# Configure — settings & mechanism

No admin UI (`configure` is `null`), no permissions, no install-time form. Behaviour is
automatic once the module is enabled; the only knob is one config value.

## Setting

Config object `private_file_token.settings`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `expiration_time` | integer | `10800` | Seconds a minted token stays valid (default 3 hours). |

Change it with Drush:

```
ddev drush config:set private_file_token.settings expiration_time 300 -y
```

(or override in `settings.php`: `$config['private_file_token.settings']['expiration_time'] = 300;`).
Lower it for shorter-lived links, raise it for longer-lived ones. Schema:
`config/schema/private_file_token.settings.schema.yml`.

## How URLs get a token (`private_file_token.module`)

`private_file_token_file_url_alter(&$uri)` fires for every URL Drupal generates:

1. Skips anything whose stream scheme isn't `private`.
2. Resolves the private wrapper's external URL and strips the base path
   (`file_url_generator::transformRelative($uri, FALSE)`) so the path matches
   `$request->getPathInfo()` at validation time.
3. Computes `token = private_file_token_generator->get($path, $timestamp)` with
   `$timestamp = \Drupal::time()->getRequestTime()`.
4. Appends `?token=<hmac>&timestamp=<int>` (or `&…` if the URL already has a query).

So a rendered `<img>`/link to a `private://` file carries a ready-to-use signed URL.

## How access is granted

`private_file_token_file_access(EntityInterface $entity, $operation, $account)`:

- Returns `AccessResult::neutral()` unless `$operation === 'download'` **and** the current route
  is one of `system.private_file_download`, `system.files`, `image.style_private`.
- Returns `neutral()` if `token` or `timestamp` query args are missing.
- Otherwise returns `AccessResult::allowedIf($generator->validate($token, $request->getPathInfo(), $timestamp))`.

`PrivateFileTokenGenerator::validate()` fails if `now - timestamp > expiration_time`, else
compares the recomputed HMAC with `hash_equals()`. A valid token ⇒ download is allowed for
**any** requester (including anonymous); an invalid/absent token is neutral, so core's normal
private-file access (`hook_file_download`) still applies. There is no per-file opt-in — enabling
the module affects every private file on the site.
