# Configuration

Everything Salesforce lives under **Configuration → Salesforce**
(`/admin/config/salesforce`) and requires the **Administer Salesforce**
permission. Configuration comes in two parts: setting up an *authorization* so
Drupal can log in to your Salesforce org, and tuning the suite‑wide settings.

## Set up an authorization

Each connection to Salesforce is stored as a **Salesforce Auth** config entity.
It records:

- an **id** and **label** for the connection,
- the **provider** — the auth‑provider plugin it uses (`oauth` from
  `salesforce_oauth`, or `jwt` / `jwt_govcloud` from `salesforce_jwt`), and
- the **provider settings** — plugin‑specific values such as the consumer key,
  login URL, and (for JWT) the Key entity that holds the signing key.

You create and authorize a connection through the auth submodule's own UI (the
`salesforce.auth_config` route in the Salesforce admin section), not by editing
config by hand. This is because completing an OAuth or JWT handshake requires
Drupal to actually talk to Salesforce and store a token. In your Salesforce org
you will first need a Connected App that provides the consumer key/secret (for
OAuth) or the certificate (for JWT).

- **OAuth** walks you through the user‑agent flow: you enter the consumer key and
  secret from your Connected App, then authorize against Salesforce.
- **JWT** signs requests with a key stored as a Drupal **Key** entity, so no
  interactive login is needed after setup — useful for server‑to‑server sync.

The two relevant permissions are **Administer Salesforce** (manage settings,
authorizations, and mappings) and **Authorize Salesforce** (access the consumer
key/secret and identity information).

## Choose the default auth provider

The suite uses one authorization as the site default for API calls. After you
create an authorization, set it as the default — from the settings form, or with
Drush:

```bash
drush salesforce:list-providers            # list configured authorizations
drush cset salesforce.settings salesforce_auth_provider my_auth -y
```

## Suite‑wide settings

The rest of the settings live in the `salesforce.settings` config object and
control queue limits, caching, and API behavior:

- **Global push limit** (`global_push_limit`, default `100000`) — the maximum
  number of records processed per push queue run. Set to `0` for no limit.
- **Pull max queue size** (`pull_max_queue_size`, default `100000`) — the
  maximum number of items enqueued for a pull at once. `0` means no limit.
- **Standalone** (`standalone`, default off) — when on, queue processing uses a
  standalone endpoint instead of running during cron. Both Push and Pull honor
  this.
- **Show all objects** (`show_all_objects`, default off) — when on, the mapping
  UI lists every Salesforce object, including system and read‑only tables, not
  just the commonly mapped ones.
- **Use latest API version** (`use_latest`, default on) — always use the newest
  Salesforce REST API version. Turn it off to pin a specific version (see below).
- **REST API version** (`rest_api_version`) — the pinned version used when *Use
  latest* is off.
- **Limit mapped object revisions** (`limit_mapped_object_revisions`, default
  `10`) — how many revisions to keep per mapped object. `0` keeps them all.
- **Short‑term cache lifetime** (`short_term_cache_lifetime`, default `3600`
  seconds) — how long object lists, descriptions, and record types are cached.
- **Long‑term cache lifetime** (`long_term_cache_lifetime`, default `604800`
  seconds) — how long API version information is cached.

You can also read and set these from the command line:

```bash
drush cget salesforce.settings
drush cset salesforce.settings global_push_limit 5000 -y
drush cset salesforce.settings standalone 1 -y
```

These settings are all local config — changing them needs no live Salesforce
connection, but actual API calls (queries, push, pull) do.

## Next steps

With an authorization in place and a default provider chosen, enable the mapping
submodules and define your maps under the Salesforce admin section, then turn on
Push and/or Pull for the sync direction you need. See the sibling
[`agent/`](../agent/start.md) docs for the REST client service, Drush commands,
and the auth‑provider plugin API.
