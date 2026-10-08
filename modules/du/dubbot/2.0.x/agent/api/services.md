# Services + domains hook

## Services (`dubbot.services.yml`)

| Service | Class / interface | Purpose |
|---|---|---|
| `dubbot.client` | `Drupal\dubbot\Client` (`ClientInterface`) | HTTP client to DubBot. `isEnabled()` (cached, tag `dubbot:client`), `isValidEmbedKey($key)`, and methods returning per-URL / per-page iframe report URLs and report data. Marked `@internal`. |
| `dubbot.link_generator` | `Drupal\dubbot\LinkGenerator` (`LinkGeneratorInterface`) | Builds the report link/iframe render for the current request (used by the report block and toolbar). Cache tag `LinkGeneratorInterface::LINK_CACHE_TAG`. |
| `dubbot.domain_negotiator` | `Drupal\dubbot\DomainNegotiator` (`DomainNegotiatorInterface`) | `domains()` returns the list of site domains to request reports for. Starts with the current scheme+host, then runs the `dubbot_domains` alter. |

Key `ClientInterface` constants: `API_BASE_URL` (`https://api.dubbot.com`), `APP_BASE_URL`
(`https://app.dubbot.com`), `EMBED_ENDPOINT_PATH` (`/embeds/:embed_key`), `PAGES_ENDPOINT_PATH`
(`/embeds/:embed_key/pages`), cache tag `dubbot:client`.

Example — check whether the integration is live:

```php
$client = \Drupal::service('dubbot.client');
if ($client->isEnabled()) {
  // A valid embed key is configured and validated.
}
```

## `hook_dubbot_domains_alter(array &$domains)`

The only hook the module invites. Add/remove the domains DubBot reports are fetched for.

```php
function mymodule_dubbot_domains_alter(array &$domains) {
  $domains[] = 'https://www.example.com';
  if (($k = array_search('https://old.example.com', $domains)) !== FALSE) {
    unset($domains[$k]);
  }
}
```

The module implements this hook itself: when the core `language` module uses **domain-based**
URL language negotiation, `dubbot_dubbot_domains_alter()` appends each configured language
domain, so a domain-per-language site reports on every language domain automatically.
