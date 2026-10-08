# Google Reviews Import — manual setup guide

**Google Reviews Import** (`google_reviews_import`) pulls the Google reviews of the
business locations you own into Drupal and stores them in a custom entity called
`google_review`. Once the reviews live as Drupal entities, you can display and
manage them natively — with Views, entity queries, or however else you prefer.

Under the hood the module uses the **Migrate** framework (via the
[Migrate Tools](https://www.drupal.org/project/migrate_tools) and
[Migrate Plus](https://www.drupal.org/project/migrate_plus) modules) to fetch the
reviews from Google's API, and it stores your Google API credentials securely
through the [Key](https://www.drupal.org/project/key) module. It ships permissions
that gate creating, viewing, editing and deleting the imported review entities.

The module is under active development, so treat it accordingly on production
sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Migrate/Key dependencies.
2. [Configuration](configuration/index.md) — add your Google API key and run the
   import.

## Where it lives in the admin menu

- **Settings / API keys:** **Configuration → Web services → Google Reviews Import**
  (`/admin/config/services/google_reviews_import_settings`).
- **Imported reviews:** **Content → Google reviews**
  (`/admin/content/google-review`).

## How to use it

Configure your credentials on the settings form, run the migration to import
reviews, then build a View (or use the content listing) to display them. Because
each review is a `google_review` entity, you have full control over how and where
they appear.
