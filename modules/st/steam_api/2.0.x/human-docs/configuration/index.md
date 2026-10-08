# Configuration

Steam API has a single, short settings form: your API key and the cache lifetime.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Steam API**
   (`/admin/config/services/steam_api`).

## Settings

- **Steam Web API key** (`steam_apikey`) — your key from Steam. The form includes a
  link to the Steam page where you can create or retrieve it. Every service getter
  returns an empty result until this is set. The key is stored in the module's
  configuration in plaintext (normal for a service credential — it is only readable
  by administrators) and is sent only to Steam, as the `key` query parameter. If a
  request errors, the key is redacted from the logged message.
- **Cache TTL** (`cache_ttl`, default **300** seconds) — how long Steam responses
  are cached. Caching helps you stay within Steam's rate limits. Set it to **0** to
  disable caching entirely (for example while developing).

Save the form.

## Using the services after configuration

Once the key is set, consume the services from your own code by dependency
injection. For example:

```php
public function __construct(
  protected \Drupal\steam_api\Service\SteamUserInterface $steamUser,
) {}

// ...
$players = $this->steamUser->getPlayerSummaries('76561198000000000');
```

The three services are `steam_api.news`, `steam_api.user`, and
`steam_api.userstats`; their methods take 64-bit SteamIDs (comma-separated for
batches) and, where relevant, a Steam application (game) id.
