# Configuration

The LibreTranslate provider is configured on its settings form (route
`auto_node_translate_libre.settings`).

## Open the settings form

1. Log in as a user with permission to administer the module's configuration (an
   administrator by default).
2. Open the Auto Node Translate Libre settings form.

## Settings

- **LibreTranslate endpoint** — the URL of the LibreTranslate server that will
  do the translating. This can be a server you host yourself or a hosted
  instance.
- **API key** *(if your endpoint requires one)* — the key LibreTranslate expects
  for authenticated requests. Self-hosted instances often need no key; many
  hosted ones do.

## Handling the API key as a secret

If your endpoint needs an API key, treat it as a secret rather than a value you
commit to your repository. On this DDEV-based project the recommended approach
is:

1. Store the value in an environment variable with DDEV's dotenv helper (never
   commit `.ddev/.env`):

   ```bash
   ddev dotenv set .ddev/.env --libretranslate-api-key=<value>
   ddev restart
   ```

   The flag `--libretranslate-api-key` becomes the variable
   `LIBRETRANSLATE_API_KEY` inside the web container.

2. Reference that variable rather than pasting the key into committed
   configuration — for example via a Key entity (with the Key module's env
   provider) where supported, or from `settings.php` using
   `getenv('LIBRETRANSLATE_API_KEY')`, keeping the real value out of exported
   config.

The goal is that the key lives in the environment, not in version control.

## Choose the provider

In Auto Node Translate's own settings, select **LibreTranslate** as the active
translation provider so translations run through this module.

## A note on where content goes

Remember that translating a node sends its field text to the endpoint you
configure here. A self-hosted LibreTranslate keeps that content on your own
infrastructure; a hosted endpoint sends it to that third party. Pick the
endpoint accordingly.
