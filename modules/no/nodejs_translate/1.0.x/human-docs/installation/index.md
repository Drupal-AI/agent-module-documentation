# Installation

Installing Node.js Translate has **two parts**: the Drupal module, and the standalone
**Node.js service** it talks to.

## Requirements

- **Drupal 8.8 through 12** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Language** module (`language`) — enabled automatically as a dependency.
- **Node.js** installed on the server that will run the translation service
  (see <https://nodejs.org/en>).

## Install the Drupal module with Composer

From the project root:

```bash
composer require drupal/nodejs_translate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nodejs_translate -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nodejs_translate -y
```

## Install and run the Node.js service

The translation itself is done by a small Node.js service that ships with the module in
your site's `libraries/google-translate` folder. Install its dependencies and start it:

```bash
cd libraries/google-translate
npm install
npm start
```

The service only works while that process is running. To keep it running in the
background and start automatically, the module's docs suggest **PM2**:

```bash
npm install pm2@latest -g
pm2 start index.js
pm2 save
```

You can run the service on the same server as Drupal (typically reachable at a local
address) or on an external server; you'll tell Drupal where to find it in
[Configuration](../configuration/index.md).

## Verify it worked

With the Node.js service running and the module pointed at it (see
[Configuration](../configuration/index.md)), translate one entity as a test:

```bash
drush nodejs_translate:single_translate node 42
```

Check that a translation is created for the target language. If nothing happens,
confirm the Node.js service process is still running and that the host/IP in the
settings form is correct.
