# Configuration

To connect Drupal to Landingi you need one thing: your **Landingi API key**. You
generate it in your Landingi account, then give it to Drupal. Because it's a secret
that grants access to your Landingi account, store it as an environment variable
rather than pasting it into configuration that gets exported and committed.

## Store the API key as a secret (recommended)

### 1. Save the key in DDEV's environment

```bash
ddev dotenv set .ddev/.env --landingi-api-key=YOUR_API_KEY_HERE
ddev restart
```

The flag `--landingi-api-key` becomes the environment variable `LANDINGI_API_KEY`
inside the web container. **Never commit `.ddev/.env`** — keep it out of version
control.

Confirm the variable is present without printing its value:

```bash
ddev exec 'test -n "$LANDINGI_API_KEY"' && echo "set"
```

### 2. Expose it through a Key entity

If the **Key** module isn't already enabled:

```bash
ddev composer require drupal/key
ddev drush en key -y
```

Then create a Key backed by the environment variable:

```bash
ddev drush key:save landingi_api_key \
  --label='Landingi API Key' \
  --key-type=authentication \
  --key-provider=env \
  --key-provider-settings='{"env_variable":"LANDINGI_API_KEY","base64_encoded":false,"strip_line_breaks":true}' \
  --key-input=none -y
```

## Enter the key in the module settings

Open the module's settings form and supply the Landingi API key. Where the form
supports selecting a **Key**, choose the `landingi_api_key` Key you created so the
secret is read from the environment. Save, then confirm Drupal can reach Landingi
by listing or importing your pages.

## Import your landing pages

With the key in place, use the module to pull pages you've built in Landingi into
your Drupal site, where they're served from your own domain. Rebuild or re‑import
when you update a page in Landingi.

## Security note — verify the TLS setting

As shipped in version 1.0.3, the module's API client was documented to disable TLS
certificate verification when calling the Landingi API. Sending your API key over a
connection whose certificate isn't verified exposes it to a network
man‑in‑the‑middle. Before using this on a production site, **check that certificate
verification is enabled** for the Landingi API calls (i.e. that TLS verification is
not turned off), and update the module or apply a fix if it is disabled. Keeping the
key in an environment variable, as above, limits the blast radius but does not by
itself fix an unverified connection.
