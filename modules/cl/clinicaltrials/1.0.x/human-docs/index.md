# Clinical Trials — manual setup guide

**Clinical Trials** (`clinicaltrials`) pulls clinical-trial data from the public
**ClinicalTrials.gov API** into your Drupal site and turns it into structured
content. It's aimed at medical, research, and healthcare sites that want to present
trial listings and details sourced from the official registry, without manually
copying data across. The module provides a dedicated **"Clinical Trial" content
type** and imports matching trials from the API as nodes of that type.

You configure the API connection and your query parameters in the Drupal admin
interface — deciding which trials to pull. Importing is then handled either from the
command line with the module's Drush command (`drush ct-import-studies`) or on a
schedule via cron, so your trial listings can be kept current automatically. The
import provides logging and error handling so you can see how each run went.

The data it fetches is public registry data, so there are no credentials to guard,
but note that the module makes outbound requests to ClinicalTrials.gov. Access to
the module's configuration is gated by the **`administer clinical trials config`**
permission. It depends on core's **Language** module and supports Drupal 8 through
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   grant the permission.
2. [Configuration](configuration/index.md) — the API settings, query parameters,
   and import scheduling.

## Where it lives in the admin menu

The module adds a settings page in the admin interface (gated by `administer
clinical trials config`) where you set the API query parameters and import
behaviour. See [Configuration](configuration/index.md).

## How to use it

1. Enable the module — it provides the **Clinical Trial** content type.
2. Configure the API query parameters on the settings page (see
   [Configuration](configuration/index.md)).
3. Run an import, either manually or on cron:

   ```bash
   drush ct-import-studies
   ```

   Matching trials are fetched from ClinicalTrials.gov and created as Clinical Trial
   nodes.
