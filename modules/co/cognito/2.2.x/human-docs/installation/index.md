# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- The **External Authentication** module (`externalauth`) — Composer pulls this in
  automatically as a dependency, and Drupal enables it when you turn on Amazon
  Cognito.
- An **Amazon Cognito user pool** on the AWS side, created with the *Email*
  sign-in flow, plus an app client and (for server-side calls) AWS credentials.

There are no additional PHP library requirements declared by the module itself,
beyond what the AWS integration needs at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/cognito -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including `externalauth` — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cognito -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cognito -y
```

This also enables External Authentication if it is not already on.

## Verify it worked

Enabling the module is only the first step — Cognito cannot take over sign-in until
you supply the connection details described in
[Configuration](../configuration/index.md). Once those are in place, log out and
try signing in: you should authenticate against your Cognito user pool, and a
matching Drupal account should appear under **People**.
