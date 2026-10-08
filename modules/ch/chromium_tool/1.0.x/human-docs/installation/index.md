# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`), which Composer pulls in as a dependency.
- Core's **Image** module (`image`), enabled automatically as a dependency.
- A **Chrome or Chromium binary** installed in the environment where Drupal runs
  (see "Provide a Chromium binary" below).

## Install with Composer

From the project root:

```bash
composer require drupal/chromium_tool -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update and install shared
dependencies, including the AI module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chromium_tool -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chromium_tool -y
```

## Provide a Chromium binary

The service drives a real headless browser, so a Chrome/Chromium executable must be
present on the server (or in the container) that runs Drupal. Install Chromium in
that environment, then note the full path to its executable — the module needs that
path.

In a DDEV project, install Chromium inside the **web** container rather than on your
host, since that's where the site's PHP runs. Once it's installed, an administrator
sets the executable path in the module's admin configuration (requires the
**Administer site configuration** permission).

## Grant the permission

Chromium Tool defines a permission that governs use of the screenshot tool. On
**People → Permissions**, grant it only to trusted roles — the tool drives a
server-side headless browser that fetches the URLs it is given, so treat access as
a privileged capability.

## Verify it worked

Confirm the module is enabled (`drush pml --status=enabled | grep chromium_tool`),
that a Chromium binary is installed and its path is configured, and — if you use the
AI module — that the screenshot function/tool is now offered to your AI agent. A
successful screenshot of a known-good URL confirms the browser is wired up
correctly.
