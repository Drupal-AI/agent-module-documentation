# Configuration

Configuring OpenAI Core means giving it your OpenAI **API key** (and, if your
account needs one, an organization ID). Everything else is provided by the
submodules you enable.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → OpenAI → Settings**, or navigate directly to
   `/admin/config/openai/settings`.

The settings are stored in the `openai.settings` configuration object.

## The fields

- **API key** (`api_key`) — **required**. Your OpenAI secret API key. This is what
  authenticates every request the module makes. The client is built from this key
  (and the organization ID) as `\OpenAI::client($api_key, $api_org)`.
- **Organization ID** (`api_org`) — optional. Your OpenAI organization ID, needed by
  some endpoints/accounts. Leave it blank if you do not use one.

Save the form. If the key is empty, administrators keep seeing a warning on admin
pages pointing back here, so features do not fail silently.

## Keep the key out of configuration (recommended)

OpenAI Core stores the API key as **ordinary Drupal configuration** and does **not**
integrate the Key module. Saving a live secret into exported config is risky, so for
any real environment you should keep the key out of config and inject it from an
environment variable instead.

The standard approach is a config override in `settings.php`:

```php
$config['openai.settings']['api_key'] = getenv('OPENAI_API_KEY');
```

With this in place you can leave the key blank in exported config; the value comes
from the `OPENAI_API_KEY` environment variable at runtime, and differs safely per
environment.

> **Using DDEV?** Store the secret with DDEV's dotenv command rather than committing
> it: `ddev dotenv set .ddev/.env --openai-api-key=<value>` (this sets the
> `OPENAI_API_KEY` variable), keep `.ddev/.env` out of version control, then
> `ddev restart` so the container picks it up. The `getenv('OPENAI_API_KEY')`
> override above then reads it.

## Other admin pages

Under **Configuration → OpenAI** you also get:

- **Models** (`/admin/config/openai/settings/models`) — lists the models available
  to your account, fetched live through the API. A quick way to confirm your key
  works.
- **Docs** (`/admin/config/openai/settings/docs`) — redirects to OpenAI's platform
  documentation.

All of these require the **Administer site configuration** permission.

## Turning on features

The base module only stores the key and provides the `openai.api` service — it adds
no editor‑facing features by itself. Enable the submodule(s) you need (OpenAI
Content, OpenAI CKEditor, OpenAI DALL·E, and so on — see
[Installation](../installation/index.md)); each brings its own settings, routes, and
permissions built on top of the shared service and API key you configured here.
