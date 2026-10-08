# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Drupal's **External Authentication** (`externalauth`) machinery, which the
  module uses to map OAuth identities to accounts — Composer pulls in what it
  needs.
- The `league/oauth2-*` client libraries, pulled in by Composer for the base
  module and each provider.
- An **OAuth application** registered with each provider you want to offer
  (GitHub, GitLab, etc.), giving you a client ID and secret.

## Install with Composer

From the project root:

```bash
composer require drupal/league_oauth_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the League client
libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/league_oauth_login -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en league_oauth_login -y
```

## Submodules — one provider per login source

The base module owns the login flow; each **provider** is a submodule you enable
for the sign‑in source you want. Enable them individually with `drush en`:

| Provider | Machine name | Login source |
|----------|--------------|--------------|
| **GitHub** | `league_oauth_login_github` | GitHub accounts (ships with this project) |
| **GitLab** | `league_oauth_login_gitlab` | GitLab accounts (ships with this project) |
| **Bitbucket** | `league_oauth_login_bitbucket` | Bitbucket accounts (separate project) |
| **Slack** | `league_oauth_login_slack` | Slack accounts (separate project) |

For example, to offer GitHub login:

```bash
drush en league_oauth_login_github -y
```

Each provider submodule requires the base League OAuth Login module, which is
already present once you have installed it above. The Bitbucket and Slack
providers are separate Composer packages — see their own installation guides.

## Verify it worked

Enable at least one provider and configure it with its client ID, secret, and
redirect URI (see [Configuration](../configuration/index.md)). Then visit the
login form and confirm the provider's sign‑in option appears, and that clicking it
redirects you to the provider and back. Always test over **HTTPS**.
