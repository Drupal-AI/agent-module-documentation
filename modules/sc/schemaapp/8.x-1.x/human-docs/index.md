# Schema App — manual setup guide

**Schema App** (`schemaapp`) connects your Drupal site to the hosted
[Schema App](https://www.schemaapp.com/) platform — an external service for
creating and managing schema.org structured data — so your pages emit rich
structured data (JSON‑LD) that is authored and managed in Schema App rather than
built by hand in Drupal. The Drupal module's specific job is to provide **local
caching** of the markup that Schema App generates, so your pages can serve it
quickly.

This is the module to reach for when your structured‑data / SEO strategy is run
through the Schema App service instead of assembled from individual schema.org
modules. You author your markup in your Schema App account and project, and the
Drupal module fetches and caches it locally for output on your pages.

Because it is an integration with a third‑party service, **Schema App requires an
active Schema App subscription** and connects to a Schema App project in your
account. You configure the connection in Drupal, supplying the credentials the
service needs — store any API key or credential as a secret (an environment
variable or a Key entity), never hard‑coded in configuration or committed to
version control. The module produces structured‑data markup only; it has no
access‑control role. It requires **PHP 7.4** and supports Drupal 10.1 and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and check the PHP requirement.
2. [Configuration](configuration/index.md) — connect the module to your Schema App
   account and project.

## Where it lives in the admin menu

Once enabled, the settings live under **Configuration → Development → Schema**
(`admin/config/development/schema`), where you connect the site to your Schema App
account.
