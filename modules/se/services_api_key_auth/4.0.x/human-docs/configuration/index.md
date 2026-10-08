# Configuration

Setting the module up has two parts: create one or more API keys (each bound to a
user), then tell your endpoints to accept API-key authentication.

## Open the API key listing

1. Log in as a user with the **`administer services_api_key_auth`** permission (an
   administrator by default).
2. Go to **Configuration → Web services → API Key Authentication**, or navigate
   directly to `/admin/config/services/api-key-auth`.

You'll land on the API key collection page, where existing keys are listed and you
can add a new one.

## Create an API key

When you add a key, you give it:

- **A key value** — the module can generate a strong one for you (128 bits from a
  secure random source). This is the secret the caller will send.
- **A bound user** — the Drupal account the key acts as. Any request carrying this
  valid key runs with that user's permissions. Bind each key to an account whose
  role has *exactly* the access the integration needs, and no more — the key is as
  powerful as the user behind it.

Give each consumer its own key. That way you can revoke or rotate one integration's
access without disturbing the others and without changing anyone's password.

## How a request presents the key

By default the module reads the key from a request **header** named `api_key`.
A request without the header, or with an invalid value, is blocked. For example:

```
GET /jsonapi/node/article
api_key: <your-key-value>
```

The module also has settings for reading the key from a POST parameter or a
query-string parameter, but both are **empty by default** — leave them that way
unless you have a strong reason. Putting a key in the query string leaks it into
server access logs, `Referer` headers, browser history and proxy logs. The header
is the safe default.

## Attach the provider to your endpoints

API-key authentication only takes effect on endpoints configured to accept it. For
a JSON:API or REST resource, enable the API-key authentication provider for that
resource (the same place you would enable cookie or basic auth). Once attached,
callers presenting a valid key are authenticated as the bound user.

## A note on storage and safety

Keys are stored as configuration entities with the key value in cleartext, so they
are included in `drush cex` exports. Keep `services_api_key_auth.api_key.*` out of
version control (see [Installation](../installation/index.md)), and always send keys
over HTTPS so they are not exposed in transit.
