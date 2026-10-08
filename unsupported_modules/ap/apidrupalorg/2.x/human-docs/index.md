# API.Drupal.org — manual setup guide

**API.Drupal.org** (`apidrupalorg`) is a small companion to the **API** module
that holds the site-specific customizations for the api.drupal.org website. It is
only useful if you are running an api.drupal.org-style documentation portal on top
of the API module — on any other kind of site it has nothing to do.

It provides three things. First, an admin **Import** form that migrates comments
from the old Drupal 7 api.drupal.org into the current API module's comment
storage, so historical comment threads survive an upgrade. Second, an inbound
**path processor** that rewrites URLs for the API module's external-documentation
branches, keeping legacy documentation links working. Third, a **footer message**
block you can place in the site footer without needing a custom theme.

There is very little security surface: the only route is the importer, and it is
gated behind three administrator permissions at once (see the configuration page).
The path processor only rewrites request paths, and the block only renders static
markup — there are no anonymous or data-changing endpoints.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it needs Views and the API module).
2. [Configuration](configuration/index.md) — the one-off comments Import form, the
   path processor, and the footer block.

## Where it lives in the admin menu

The comments importer sits at **Configuration → Development → API.Drupal.org
import** (`/admin/config/development/apidrupalorg/import`). The footer message
block is placed through **Structure → Block layout**. The path processor has no UI
— it works automatically once the module is enabled.
