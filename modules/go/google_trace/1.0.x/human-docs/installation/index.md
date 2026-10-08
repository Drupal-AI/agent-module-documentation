# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- A **Google Cloud** project with the Cloud Trace API available, plus credentials
  the environment can present (a service-account JSON, or workload identity).
- The `google/cloud-trace` PHP client, which Composer pulls in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/google_trace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/google_trace -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en google_trace -y
```

## Set the environment variables

For the trace client to authenticate, set both of these in the web environment
(see the main [guide](../index.md) for detail):

- `GOOGLE_APPLICATION_CREDENTIALS` — path from the Drupal root to the credentials
  JSON (e.g. `../files/my-project-5115.json`).
- `GOOGLE_CLOUD_PROJECT` — your Google Cloud project name.

## Verify it worked

Instrument some code to queue a trace (or run `drush queue:run google_trace_queue`
after traffic), then check **Cloud Trace** in the Google Cloud console for the
traces. If credentials are missing, the module logs the problem to the
`google_trace` logger channel rather than throwing an error — check that channel if
nothing arrives.
