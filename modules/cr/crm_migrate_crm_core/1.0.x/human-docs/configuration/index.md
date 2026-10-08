# Configuration

The one thing you configure in the admin UI is the **bundle mapping** — how each CRM Core
(Drupal 7) contact type should map to a Drupal CRM contact bundle. Set this up before you
run the migration so contacts land in the right bundles on the new site. There is no
other settings page; the rest of the configuration is the Drupal 7 database connection you
added during [installation](../installation/index.md).

## Open the bundle-mapping form

1. Log in as a user with the **Administer CRM Migrate CRM Core** permission (this is a
   restricted, admin-level permission).
2. Go to **Configuration → Development → CRM Migrate CRM Core bundle mapping**, or
   navigate directly to `/admin/config/development/crm-migrate`.

## Map contact types to CRM bundles

On this form, map each **CRM Core contact type** from your Drupal 7 site to the **Drupal
CRM contact bundle** it should become (for example mapping legacy individual, household,
and organization types onto the corresponding CRM bundles). The migration's process
plugins (`ContactTypeMap` and `RelationshipTypeMap`) apply these mappings automatically
when the migration runs, so review them carefully before importing — this is your chance
to preview and adjust how legacy data will be reshaped.

Save the form when the mapping is complete.

## Then run the migration

With the mapping saved and the D7 source database connected, run the migrations with
Drush (contacts first, then relationships):

```bash
drush migrate:import crm_core_contact
drush migrate:import crm_core_relationship
```

See the [overview page](../index.md) for the full run instructions, including importing
the migration config if the migrations do not appear in `drush migrate:status`.

## Security note

The bundle-mapping form and the module's Drush commands are gated by the restricted
**Administer CRM Migrate CRM Core** permission, and the migration source queries are
parameterized (safe against SQL injection). Grant the permission only to trusted
administrators running the migration.
