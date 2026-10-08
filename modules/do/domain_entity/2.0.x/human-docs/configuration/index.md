# Configuration

Configuration happens in two places: a form where you turn domain access **on**
for whole entity types, and a per-type form where you choose **how** affiliation
is assigned for each bundle.

## Step 1 — enable domain access for an entity type

1. Log in as a user with the **Administer domains** permission.
2. Go to **Configuration → Domain → Domain entities**
   (`/admin/config/domain/entities`).
3. You will see a table listing every fieldable entity type. **Tick** the ones
   that should become domain-aware (for example Taxonomy term, Media, or a custom
   entity) and **untick** any you want to turn off.
4. **Save.** Ticking a type adds a multi-value `domain_access` reference field to
   it; unticking removes that field storage again.

> **Careful when disabling:** unticking a type deletes its `domain_access` field
> storage, which removes the domain assignments stored on those entities.

This same form also has the global **bypass** checkbox described at the bottom of
this page.

## Step 2 — choose the per-bundle behavior

Once a type is enabled, it gets its own settings page at
`/admin/config/domain/entities/{entity_type_id}`. For each **bundle** you pick how
a new entity is affiliated to domains:

- **Automatic** — a newly created entity is silently affiliated to the current
  domain (the one it was created on). No widget is shown to the editor. Good when
  content should simply belong to wherever it was made.
- **User** — an options-buttons widget appears on the entity form so the editor
  explicitly chooses which domain(s) the entity is published to. You can set a
  default selection.

On the same page you can also set **default domains** for new entities and list
**excluded routes** — routes that should be exempt from the optional domain-source
URL rewriting.

## How access is enforced

Once configured, the module filters both access checks and entity listing queries
so that an entity is only visible on the domains it references. Two important
rules to keep in mind:

- An entity with **no** domain assignment is treated as affiliated to **all**
  domains. So content migrated in without a domain will be broadly visible (or,
  where you expected it to be scoped, may behave unexpectedly) — assign domains
  deliberately.
- Trusted multi-domain editors can work across their assigned domains if they hold
  the relevant permission (below).

## Permissions

The module ships both static and dynamic (per-bundle) permissions under **People
→ Permissions**:

- **Access entities affiliate on assigned domains** — a restricted permission that
  lets a multi-domain editor see and edit entities across the domains they are
  assigned to, in the admin UI.
- **Per-bundle create / update / delete** permissions — mirror Domain Access's
  node permissions, so you can delegate management of a specific bundle to editors
  scoped to their own domains.

## Troubleshooting: the bypass switch

On the main Domain entities form there is a **bypass access conditions** checkbox
(config `domain_entity.settings` → `bypass_access_conditions`, off by default).
Turning it on disables the module's query filtering, so entities temporarily
behave as accessible on all domains. Use it to diagnose a View or query that is
returning unexpected results, then turn it back off.

```bash
drush cset -y domain_entity.settings bypass_access_conditions true
```
