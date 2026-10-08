# Configuration

Configuring Domain means three things: creating the domain records themselves,
tuning the global settings, and granting the permissions that let editors work
with domains. Domain also comes with a full set of Drush commands, which are often
the quickest way to manage records.

## Create and manage domain records

1. Log in as a user with the **Administer domains** permission.
2. Go to **Configuration → Domain** (`/admin/config/domain`). This lists your
   domain records; use **Add domain** (`/admin/config/domain/add`) to create one.

Each domain record has these fields:

- **Hostname** — the host the site should answer to, e.g. `example.com`.
- **Name** — a human-readable label shown in the admin list and switchers.
- **Scheme** — force **https**, force **http**, or **variable** (inherit the
  request's scheme).
- **Status** — active, or inactive (offline).
- **Weight** — orders the domain in the admin list and switcher blocks.
- **Default domain** — marks this as the canonical fallback domain.
- **Path prefix** — an optional URL path prefix so a domain can be served under a
  `/subsite`-style path (only used when path prefixes are enabled in the global
  settings).

> The **first** domain you create is automatically marked as the default.

### Managing records with Drush

The `drush domain:*` commands are the recommended way to script domain management:

```bash
drush domain:add example.com "Example" --scheme=https
drush domain:add example.org "Example Org" --scheme=https --weight=2 --path-prefix=org
drush domain:default example.org      # make this the canonical default
drush domain:disable example.net      # take a domain offline
drush domain:enable  example.net
drush domain:name    example.net "New Name"
drush domain:scheme  example.net https
```

Other useful commands include `domain:list`, `domain:info`, `domain:delete`,
`domain:test` (debug negotiation), `domain:replace` (bulk-rename a hostname across
the site, e.g. `staging.example.com` → `example.com`), and `domain:generate` (make
a batch of test domains for a dev environment).

## Global settings

Go to **Configuration → Domain → Settings** (`/admin/config/domain/settings`),
also gated by **Administer domains**. The options are:

- **www prefix handling** — treat `www.host` and `host` as the same domain when
  negotiating (off by default).
- **Path prefixes** — enable per-domain URL path prefixes (off by default).
- **Allow non-ASCII hostnames** — permit non-ASCII characters in hostnames (off by
  default).
- **Login paths** — the paths that stay reachable on an *inactive* domain, so users
  can still log in or reset a password. Defaults to `/user/login` and
  `/user/password`.
- **CSS classes** — CSS classes added to the page `<body>` per domain, handy for
  domain-specific theming.
- **Language negotiation** — respect per-domain language negotiation.
- **Destination domain on redirects** — allow a `destination` domain to be set on
  redirects.

> **A note on saving settings from the command line:** several of these are boolean
> values, and `drush config:set` mis-parses `false` for boolean keys. Set them
> through the settings form, or with the config API in PHP:
>
> ```php
> \Drupal::configFactory()->getEditable('domain.settings')
>   ->set('www_prefix', TRUE)->save();
> ```

## Permissions

Domain provides a detailed permission set on **People → Permissions**. The main
ones are:

- **Administer domains** — full access to every domain operation, the records, and
  the settings form. Reserve this for site administrators.
- **Create domains**, **Edit assigned domains**, **Delete assigned domains** — let
  editors manage only the domains assigned to them.
- **Assign domain administrators** — delegate who manages which domains.
- **Access inactive domains** — reach domains that are marked offline.
- **View domain list**, **View assigned domains**, **View domain entity** — read
  access to the domain listings and records.
- **View domain information** — a debugging aid that surfaces negotiation details.
- **Use domain nav block** / **Use domain switcher block** — permission to use the
  two navigation/switcher blocks the module ships.

For example:

```bash
drush role:perm:add site_admin 'administer domains'
```

## Blocks and per-domain display

Beyond records and settings, the module ships blocks you can place at **Structure →
Block layout** — a **domain navigation** block linking to each domain and a
**domain switcher** block for jumping between affiliate sites. A **domain**
condition plugin lets you show or hide any block on specific domains, and a domain
cache context ensures cached output varies per active domain.

## What the submodules add

Remember that the base module only creates and negotiates records. For the common
multi-domain features, enable the relevant submodule (see
[Installation](../installation/index.md)) and configure it there: **Domain Access**
adds per-domain content/user access fields, **Domain Source** sets canonical
outbound URLs, **Domain Config** / **Domain Config UI** provide per-domain
configuration overrides (such as a different site name or theme per domain),
**Domain Alias** maps extra hostnames onto a domain, and **Domain Content** adds
per-domain content administration views.
