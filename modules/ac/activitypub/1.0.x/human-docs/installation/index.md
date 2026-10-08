# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Image** module (`image`) — a dependency, enabled automatically when
  you turn on ActivityPub.
- A **publicly reachable site over HTTPS** — federation means other servers need
  to reach your inboxes/outboxes, and the Fediverse expects TLS.

This is an **alpha** release (1.0.0-alpha26). Read the security caveat in the
[main guide](../index.md) and the [configuration guide](../configuration/index.md)
before using it on anything public.

## Install with Composer

From the project root:

```bash
composer require drupal/activitypub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/activitypub -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en activitypub -y
```

## Submodules — enable only what you need

ActivityPub ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **API** | `activitypub_api` | The API layer for ActivityPub. |
| **Comment** | `activitypub_comment` | Federates comments. |
| **Mastodon API** | `activitypub_mastodon_api` | A Mastodon-compatible API surface. |
| **Reader** | `activitypub_reader` | The reader / timeline of federated content. |
| **Scheduler** | `activitypub_scheduler` | Scheduling for federated activities. |

For example:

```bash
drush en activitypub_reader -y
```

Each submodule requires the base ActivityPub module. After enabling, continue to
[Configuration](../configuration/index.md) to set up actors and federation
settings.
