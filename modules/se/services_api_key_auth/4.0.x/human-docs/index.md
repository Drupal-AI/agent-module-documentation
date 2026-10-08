# Request API Key Authentication — manual setup guide

**Request API Key Authentication** (`services_api_key_auth`) lets a machine caller
authenticate to your Drupal REST or JSON:API endpoints with an API key sent in a
request header, instead of a browser session cookie or HTTP basic auth. Decoupled
front ends, mobile backends, scheduled import jobs and server-to-server
integrations all need a way to identify themselves that is not a user password on
every request — that is exactly the gap this module fills.

The module adds an `api_key` entity type. Each key you create is bound to a Drupal
user, and an authentication provider resolves an incoming key to that user, so the
request runs with that account's permissions. That makes keys easy to reason
about: give a partner system its own key, revoke it without touching a password,
and rotate it without redeploying the consumer. Key generation is solid — 128 bits
from a cryptographically secure random source. It needs no other modules and works
on Drupal 10.3 and 11.

It does **not** work purely on-enable: you configure keys and attach the
authentication provider to your endpoints before anything authenticates. By default
the key is read from a request header named `api_key`; the POST-parameter and
query-parameter options are left empty on purpose, so the query-string path (which
would leak keys into access logs and browser history) is opt-in rather than on.

**One important storage caveat to plan around before you adopt it.** The `api_key`
entity is a *configuration* entity whose exported properties include the key value
in cleartext. That means `drush cex` will write live credentials into your exported
config — and therefore into version control, every clone, and CI artefacts. Because
each key also carries the user it acts as, a leaked key means impersonation, not
just endpoint access. The practical mitigation is to exclude
`services_api_key_auth.api_key.*` from config export (with `config_ignore` or
`config_split`) and treat any key that has already been exported as compromised.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create API keys, bind them to users,
   and attach the authentication provider to your endpoints.

## Where it lives in the admin menu

Once enabled, you manage keys at **Configuration → Web services → API Key
Authentication** (`/admin/config/services/api-key-auth`). Managing keys requires the
`administer services_api_key_auth` permission.
