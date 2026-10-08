# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **PECL `msgpack` PHP extension** must be installed and enabled in PHP. This
  is the key prerequisite — the module is a thin wrapper around the extension's
  `msgpack_pack()` / `msgpack_unpack()` functions, so it cannot work without it.

There are no other module dependencies.

## Install the PHP extension

Install the `msgpack` extension for your PHP version before enabling the module.
On a typical Debian/Ubuntu host this is often:

```bash
pecl install msgpack
```

then enable it in your PHP configuration and restart PHP‑FPM. Check that it is
loaded:

```bash
php -m | grep msgpack
```

> **Using DDEV?** Add `msgpack` to the `webimage_extra_packages` (or install it
> via a `.ddev/web-build` Dockerfile using `pecl install msgpack`), then
> `ddev restart`. Confirm with `ddev exec 'php -m | grep msgpack'`.

## Install with Composer

From the project root:

```bash
composer require drupal/msgpack -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/msgpack -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en msgpack -y
```

## Verify it worked

If the module enables without a "missing extension" error, the extension is
present and the `serialization.msgpack` service is registered. You can confirm the
service exists with Drush:

```bash
drush php:eval "var_dump(\Drupal::hasService('serialization.msgpack'));"
```

A `bool(true)` result means the serializer is ready to be wired into a consumer.
