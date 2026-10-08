# Installation

## Requirements

Graph Mail needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **`microsoft/microsoft-graph`** PHP SDK (`^1.34.0`) — a Composer library, pulled in
  automatically when you require the module.
- An **Azure app registration** in your Microsoft 365 / Entra ID tenant, with the
  **Mail.Send** *application* Graph permission (admin-consented) and a client secret. This is
  set up on the Azure side, not in Drupal — see [Configuration](../configuration/index.md).

It has **no Drupal module dependencies**, but the **Mailsystem** module (`drupal/mailsystem`)
is strongly recommended: it gives you an admin UI for choosing Graph Mail as the site's
sender. Working cron is also recommended so the retry queue can re-send throttled messages.

## Install with Composer

From the project root:

```bash
composer require drupal/graph_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the `microsoft/microsoft-graph`
SDK and update shared dependencies as needed. To add Mailsystem at the same time:

```bash
composer require drupal/graph_mail drupal/mailsystem -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graph_mail -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graph_mail -y
```

Enable Mailsystem too if you're using it:

```bash
drush en mailsystem -y
```

Enabling the module registers the `graphmail` mail plugin but does **not** start routing
mail through it — you still need to enter your Azure credentials and select Graph Mail as the
backend. See [Configuration](../configuration/index.md).

There are no submodules.
