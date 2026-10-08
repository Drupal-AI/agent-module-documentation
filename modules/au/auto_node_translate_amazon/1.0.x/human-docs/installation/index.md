# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Auto Node Translate** module (`auto_node_translate`), which is a hard
  dependency — this module is only a provider for it. Composer pulls it in
  automatically.
- An **AWS account** with access to Amazon Translate, and a set of AWS
  credentials (access key ID and secret access key) with permission to use it.

There are no third-party Composer or PHP library requirements declared, but you do
need working AWS credentials for translation to run.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_node_translate_amazon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including Auto Node Translate — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/auto_node_translate_amazon -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it together with the parent module:

```bash
drush en auto_node_translate auto_node_translate_amazon -y
```

## Store your AWS credentials

Before configuring the module, put your AWS keys in environment variables rather
than typing them into config that might get exported. With DDEV:

```bash
ddev dotenv set .ddev/.env --aws-access-key-id=<value> --aws-secret-access-key=<value>
ddev restart
```

(Never commit `.ddev/.env`.) See [Configuration](../configuration/index.md) for
how to point the module at these values and select your AWS region.

There are no submodules.
