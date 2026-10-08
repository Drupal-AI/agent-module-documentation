# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Configuration Manager** (`config`) and **Field** (`field`) modules — enabled
  automatically as dependencies.
- An account and repository on your Git host (**GitHub** or **GitLab**; the Bitbucket
  submodule is a not-yet-functional placeholder), and an **API token** for it — see
  [Configuration](../configuration/index.md).
- The provider submodule for your host, plus its own Composer library dependencies. Each
  submodule's `README` lists the exact libraries it needs (for example, the GitHub and GitLab
  API client libraries), so require those with Composer when you enable that submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/config_pr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed. If you use GitHub or GitLab, also require the API client library named in that
submodule's `README` (Composer usually resolves this for you when the submodule is present).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_pr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module:

```bash
drush en config_pr -y
```

## Submodules — enable the one for your Git host

Config PR ships a provider submodule per host. Enable **only** the one matching where your
repository lives:

| Submodule | Machine name | For |
|-----------|--------------|-----|
| **Config PR GitHub** | `config_pr_github` | GitHub repositories (also GitHub Enterprise / self-hosted) |
| **Config PR GitLab** | `config_pr_gitlab` | GitLab repositories (also GitLab self-managed) |
| **Config PR Bitbucket** | `config_pr_bitbucket` | Bitbucket — placeholder, not yet functional |

For example, for GitHub:

```bash
drush en config_pr_github -y
```

Remember to install that submodule's Composer library dependencies (see its `README`) if
they were not pulled in automatically.

## Verify it worked

Log in as a user with the Config PR permission and open the Configuration Management area.
You should see a **Pull Request** tab. If it is present, the module and your provider
submodule are installed — continue to [Configuration](../configuration/index.md) to connect
your repository and store its API token.
