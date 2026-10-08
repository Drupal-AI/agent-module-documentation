# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No contrib module dependencies, no third-party PHP libraries. It relies only on
  core's key/value stores (`keyvalue` and `keyvalue.expirable`).

## Install with Composer

From the project root:

```bash
composer require drupal/state_expirable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/state_expirable -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en state_expirable -y
```

That's the whole setup. Enabling the module registers the
`state_expirable.state` service, ready to inject or fetch from your custom code.
There is no configuration form.

## Verify it worked

From a Drush PHP shell (`drush php`) or your own code, confirm the service exists
and round-trips a value:

```php
$state = \Drupal::service('state_expirable.state');
$state->set('test.key', 'hello', 60);
print $state->get('test.key'); // hello, until it expires ~60s later
```
