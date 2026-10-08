# Installation

## Requirements

AI Playwright builds on the AI Agents stack and drives a headless browser:

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- The **AI** module (`ai`) and the **AI Agents** module (`ai_agents`) — the agent
  framework this tool plugs into.
- Core's **File** module (`file`) — for the captured screenshots.
- A working **Playwright / headless Chromium** runner in the environment. The
  module launches a browser subprocess, so the host needs Playwright and its
  browser binaries available. This is an environment/runner requirement, not a
  Composer package.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_playwright -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as AI Agents.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_playwright -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. Note that the Playwright
> runner and its browser binaries must be available in whatever environment runs
> the subprocess.

## Enable the module

```bash
drush en ai_playwright -y
```

Drupal enables `ai`, `ai_agents`, and `file` as dependencies if they are not
already on.

## After enabling

1. Grant **Administer AI Playwright** to the administrator doing setup and **Use
   AI Playwright** to the agents/users that should capture pages.
2. Configure the runner and the base URL of the site the tool should open.
3. Keep the runner environment **trusted** — it executes a headless-browser
   subprocess against your site's pages.
