# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- A **Pusher account** at [pusher.com](https://pusher.com) with a Channels app
  created, so you have an **app id**, **key**, **secret**, and **cluster** to
  connect with.

## Install with Composer

From the project root:

```bash
composer require drupal/pusher_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pusher_api -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pusher_api -y
```

## Store your Pusher credentials securely

Your Pusher **app id / key / secret** are secrets. Never hard-code them in
`settings.php` under version control and never commit them. Supply them through an
environment variable instead.

With DDEV you can store the value in the project's `.env` file (which must stay out
of version control) and let DDEV load it into the web container:

```bash
ddev dotenv set .ddev/.env --pusher-app-secret=<your-secret>
ddev restart
```

The flag `--pusher-app-secret` becomes the environment variable
`PUSHER_APP_SECRET` inside the container. You can confirm it is present without
printing its value:

```bash
ddev exec 'test -n "$PUSHER_APP_SECRET"'   # exit status 0 means it is set
```

Where the module or your code supports it, prefer referencing the secret through a
**Key** entity using Key's environment provider, so the secret is read from the
environment at runtime rather than stored in config. Otherwise read it directly
from `settings.php` with `getenv('PUSHER_APP_SECRET')`.

Because Pusher is an external service, make sure your server is allowed to make
outbound HTTPS requests to Pusher's API endpoints (egress). Connections should use
TLS.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep pusher_api
```

From here, real-time features come from an ecosystem module built on Pusher API or
from your own custom code that publishes events to Pusher channels. Verify the
connection by publishing a test event and watching for it in a subscribed browser
(or in the Pusher dashboard's debug console).
