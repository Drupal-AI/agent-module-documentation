# Configuration

Entity Logger has a small settings form plus its own permissions. The two things
you configure are **which entity types get a Log tab** and **who is allowed to
view and add log entries**.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the Entity Logger settings form in the **Configuration** area. It is
   backed by the `entity_logger.settings` configuration object.

## Choose which entity types are logged

The settings form lets you enable logging on a **configurable set of entity
types**. Tick the entity types you want to track — for example nodes, users, or a
custom entity type used by an integration. Each entity type you enable gains a
**Log** tab on its individual entities, where the messages recorded against that
entity are listed.

Leave an entity type unticked if you don't need per-entity logs for it; only the
types you enable get the extra tab and storage.

## Set who can see and add logs

Because log entries can contain operational detail — internal process notes,
integration results, error context — control access with the module's own
permissions on the **People → Permissions** page. This is the whole point of the
module's separate permission model: you can let a role read an entity's logs
without giving that role access to the site-wide watchdog / Reports interface.

- Grant the **view** permission only to the roles that should read entity logs.
- Grant the **add / manage** permission only to roles (or integrations acting as a
  user) that should be able to write log entries.

## Save

Save the settings form after choosing your entity types. Then confirm the
permissions on **People → Permissions**, and check that a permitted user sees the
**Log** tab on an entity of an enabled type while an unpermitted user does not.
