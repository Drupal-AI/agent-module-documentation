# Configuration

## Supply your Bitly access token

Bitly Shortener has a settings form where you enter your Bitly **access token**.
Without it, the module cannot authenticate to the Bitly API.

The access token is a **secret**. The safest way to handle it is to keep the raw
value out of committed configuration:

1. Store the value in an environment variable. With DDEV:
   ```bash
   ddev dotenv set .ddev/.env --bitly-access-token=<value>
   ddev restart
   ```
   (Never commit `.ddev/.env`.)
2. Reference it from Drupal — for example through a **Key** entity using the
   environment provider, or by reading `getenv('BITLY_ACCESS_TOKEN')` in
   `settings.php` and assigning it into the module's configuration override — so
   the token is never written into exported/committed config.

## Use the Twig function

Once the token is set, you can render a short link directly in a template:

```twig
{{ bitly_shortener('https://example.com/a/very/long/url') }}
```

You can also call the module's shortening **service** from your own PHP code.

## Performance and rate limits

The Twig function calls the Bitly API **at render time** — each render sends the
URL to Bitly and uses part of your API rate limit. On a busy page this adds a
network round-trip to every render, so:

- Prefer shortening a stable, known URL rather than one that changes per request.
- Cache the rendered result where you can, so you are not re-shortening the same
  URL on every page load.
