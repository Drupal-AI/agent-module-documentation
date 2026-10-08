# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The contributed **Metatag** module (`metatag`) — used to apply the title and
  meta description.
- Core **Node** (`node`) and the **Token** module (`token`).
- A **BrightEdge account** with Autopilot and API credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/brightedge_autopilot_page_publisher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Metatag, Token,
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brightedge_autopilot_page_publisher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brightedge_autopilot_page_publisher -y
```

Metatag, Node, and Token are enabled automatically as dependencies if they are not
already on.

## Store your BrightEdge credentials as a secret

The BrightEdge API credentials are secrets — never hard‑code them in settings or
commit them to configuration. With DDEV, save the value into an environment
variable that DDEV loads into the web container:

```bash
ddev dotenv set .ddev/.env --brightedge-api-key=your-real-key-here
ddev restart
```

The flag `--brightedge-api-key` becomes the variable `BRIGHTEDGE_API_KEY`. Keep
`.ddev/.env` out of version control, and reference the variable from your site
configuration rather than pasting the raw value into a form.
