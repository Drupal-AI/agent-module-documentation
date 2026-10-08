# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Key** module (`key`) — its only hard dependency, used to store the
  ScrapingBot API credential securely.
- A working **AI** field-interpolation setup (Drupal's AI module and a configured
  provider), since this add-on contributes a scraping step to that workflow.
- A **ScrapingBot** account and API key — the external service that actually
  fetches pages.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_interpolator_scraping_bot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Key module and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_interpolator_scraping_bot -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_interpolator_scraping_bot -y
```

There are no submodules.

## Store the ScrapingBot API key

Keep the ScrapingBot credential as a secret, not in plain config. On DDEV, save it
as an environment variable and back a Key entity with it:

```bash
ddev dotenv set .ddev/.env --scrapingbot-api-key=<value>
ddev restart
```

Then create a **Key** entity (under **Configuration → System → Keys**) using the
environment provider so it reads the `SCRAPINGBOT_API_KEY` variable, and select
that Key where the module asks for its ScrapingBot credential. This keeps the
secret out of version control and out of any config export.
