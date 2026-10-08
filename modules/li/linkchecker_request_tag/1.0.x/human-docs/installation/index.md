# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Link Checker** module (`linkchecker`) — this module tags Link Checker's
  requests, so it only does anything useful when Link Checker is also installed
  and running.

> **Security-advisory note:** this module is **not covered** by Drupal's
> security advisory policy at the documented version. Review it before relying on
> it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/linkchecker_request_tag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkchecker_request_tag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkchecker_request_tag -y
drush cr
```

The cache rebuild (`drush cr`) is important — it's the step the project's own
instructions call out, after which all future Link Checker requests include the
`X-origin: DrupalLinkChecker` header.

## Verify it worked

Trigger a Link Checker run (for example run cron, or use Link Checker's own
on-demand check) and inspect the incoming requests on a URL you control — a test
endpoint, access log, or reverse-proxy log. The requests coming from your site's
link checker should now carry the `X-origin: DrupalLinkChecker` header.
