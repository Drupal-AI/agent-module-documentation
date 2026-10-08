# Installation

## Requirements

REST Absolute URLs is deliberately small. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — this is the only dependency,
  and Drupal enables it automatically when you turn on REST Absolute URLs.

There are no third-party Composer or PHP library requirements. In practice you will
also have a REST service running (core REST, JSON:API, or another serialiser) for
the rewrite to have any output to act on.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_absolute_urls -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_absolute_urls -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_absolute_urls -y
```

That is all the setup there is — the module starts rewriting relative URLs to
absolute ones in REST-serialised content immediately.

## Verify it worked

Fetch a piece of content through your REST or JSON:API service that includes a file,
image, or link field — for example a node whose body contains an uploaded image.
In the response, the URL should now begin with your site's full origin
(`https://your-site/sites/default/files/…`) rather than a bare `/sites/…` path.

If the host in the returned URL looks wrong (for example a container name like
`http://nginx/`, or the wrong domain behind a proxy or CDN), fix it by checking
`trusted_host_patterns` and the reverse-proxy settings in `settings.php`, or by
setting the base URL explicitly — see the note in the
[main guide](../index.md).
