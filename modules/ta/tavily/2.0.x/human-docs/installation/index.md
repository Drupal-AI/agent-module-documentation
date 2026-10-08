# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — used to store your Tavily API key securely.
- A **Tavily account** and API key. Tavily is a paid third‑party service; a free
  trial is available. Sign up at [tavily.com](https://tavily.com).
- To actually put the Automators to work you will also want the
  [AI module](https://www.drupal.org/project/ai) and its **AI Automator**
  submodule installed. The `tavily.api` service can be used on its own from
  custom code without the AI module.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/tavily -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tavily -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tavily -y
```

## Verify it worked

After enabling, go to **Configuration → Tavily → Settings**
(`/admin/config/tavily/settings`). If the settings form loads and lets you enter
an API key, the module is installed correctly. See
[Configuration](../configuration/index.md) for the next steps.
