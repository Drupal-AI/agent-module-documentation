# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** (`field`) module — ships with Drupal.
- The contributed **Token** (`token`) module — it provides a popup browser that
  shows the tokens available for use in Tealium tag fields. Composer pulls it in
  automatically with the command below.
- A **Tealium iQ account** and container details (account, profile, and
  environment) from your Tealium administrator.

## Install with Composer

From the project root:

```bash
composer require drupal/tealiumiq -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tealiumiq -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tealiumiq -y
```

If you want to place Tealium tags based on the Context module's conditions, also
enable the bundled context submodule:

```bash
drush en tealiumiq_context -y
```

## Set permissions carefully

The module adds two restricted permissions — **manage global tealium tags** and
**administer tealium settings**. Because a tag manager can run arbitrary
JavaScript on every page, grant these only to the roles you would trust to deploy
code. Set them under **People → Permissions**.

## Next steps

Enter your Tealium account details and set up your default tags — see
[Configuration](../configuration/index.md).
