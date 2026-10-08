# Configuration

Migration Hbk Auto needs one thing configured before it can do anything: the URL
of the Drupal 7 site it should import from. This tells the module where to fetch
data during the migration.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). Unlike the import action endpoints, this settings
   form is properly restricted to that permission.
2. Go to **Configuration → System → Migration settings**, or navigate directly to
   `/admin/config/system/migration-settings`.

## The Drupal 7 source site URL

The form has a single field: the **URL of your Drupal 7 site** from which data
will be imported. Enter the full base URL of the source site (the one running the
**migrateexport** module) and save the form.

This value is stored in the `migration_hbk_auto.settings` configuration as
`source_site_url`, and every subsequent step in the Vue import interface uses it
to reach the source site. If the imports later fail to find any entities, the
first thing to check is that this URL is correct and reachable from your Drupal
server.

## Save

Click **Save configuration**. With the source URL in place, go to the import
interface at `/admin/migration-hbk-auto/import-from-d7` and begin the migration
(see the [main guide](../index.md) for the step-by-step flow).

> **Remember the security caveat.** The settings form is admin-only, but the
> import/action endpoints that actually create fields and write config are gated
> only by *access content*. Keep the module on a locked-down or offline build, and
> disable it once the migration is done.
