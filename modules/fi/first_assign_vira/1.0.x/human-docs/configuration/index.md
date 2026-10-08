# Configuration

Entity Auto Term is configured in two parts: the **mappings** that decide which
content creates which terms, and an optional **backfill batch** for content that
predates your mappings.

## Set up the mappings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Entity Auto Term**, or navigate directly to
   `/admin/config/system/eat`.
3. Add one or more mapping items. Each item pairs:
   - an **entity type** (for example *Content* / node),
   - a **bundle** (for example a specific content type such as *Article*), and
   - one or more **target vocabularies** where the mirrored terms should be
     created.
4. Save the form.

From now on, whenever a matching entity is **created**, the module creates a term
named after its title in each mapped vocabulary (reusing an existing term if one
with the same title already exists) and records the entity→term link in its own
`eat` table. When a matching entity is **edited**, the linked term's name is updated
to the entity's new title.

## Backfill existing content

Mappings only affect entities going forward. To create terms for content that
existed before you configured the mappings, run the bulk backfill:

1. Go to `/admin/config/system/eat/batch`.
2. Start the batch. It walks the matching content and creates the terms that would
   have been created had the mapping existed at the time.

> **Access note:** The backfill route performs a site-wide term-creation action,
> and by default it is reachable with only the core **Access content** permission
> — which is broader than you might expect for a mutating operation. If that
> matters on your site, restrict who can reach `/admin/config/system/eat/batch`
> accordingly.

## Use the terms in Views

The module provides a Views **argument default** plugin that supplies an entity's
linked term ID as a default contextual-filter argument. Use it in a View to build,
for example, a "related content" block driven by the auto-created terms.
