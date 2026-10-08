# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **JSON:API** module — the transport Entity Share uses (enable it if it is
  not already on).
- The **`league/oauth2-client`** PHP library (`^2.4`), which Composer installs
  automatically and which the OAuth authentication option needs.
- Recommended: the **Key** module (`drupal/key`) to store remote credentials
  securely. If you want OAuth-authenticated sharing, the **Simple OAuth** module
  (`drupal/simple_oauth`) on the server site.

Remember that a real sync involves **two Drupal sites** — a server and a client.
You can install everything on one site to explore the configuration, but a pull
needs a reachable second site.

## Install with Composer

On each site involved, from the project root:

```bash
composer require drupal/entity_share -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and pull in the OAuth client library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_share -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module and the right submodules

The base module alone does almost nothing — enable the submodule(s) for the role
each site plays.

On the **server** site (the one holding the content to share):

```bash
drush en entity_share_server -y
```

On the **client** site (the one pulling content in):

```bash
drush en entity_share_client -y
```

(Enabling a submodule enables the base `entity_share` module automatically. A site
that is both a server and a client enables both.)

Optionally, on the client, add any of the extra submodules:

```bash
drush en entity_share_async -y   # queue large imports asynchronously
drush en entity_share_lock -y    # lock imported content against local edits
drush en entity_share_diff -y    # show a local-vs-remote diff before importing
```

## Verify it worked

Go to **Configuration → Web services → Entity Share**
(`/admin/config/services/entity_share`). With the server submodule enabled you
should see a **Channels** section; with the client submodule enabled you should see
**Remotes** and **Import config**. Continue with
[Configuration](../configuration/index.md) to set up sharing.
