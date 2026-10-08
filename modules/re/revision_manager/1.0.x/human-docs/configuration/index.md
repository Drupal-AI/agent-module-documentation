# Configuration

Revision Manager deletes nothing until you turn it on for at least one entity
type and give it a rule. This page walks through the settings form, the two
retention rules, per-bundle overrides, and how cleanup actually runs.

## Open the settings form

1. Log in as a user with the **Administer Revision Manager** permission.
2. Go to **Configuration → Content authoring → Revision Manager**, or navigate
   directly to `/admin/config/content/revision-manager`.

The form lists every entity type on your site that supports revisions (nodes,
media, taxonomy terms, block content, menu links, groups, and any others your
modules provide) and lets you enable revision management for each one.

## Enable the entity types you want to manage

Tick the entity types Revision Manager should prune. Leaving a type unticked
means its revisions are never touched. Enable only the types you actually want
to trim — turning on management for a type does nothing by itself until you also
give it a rule below.

## Set the retention rules

For each enabled entity type you choose one or both retention rules. These
become the **defaults** for that entity type (bundles can override them — see
below).

### Amount — keep the newest N revisions

Enable the **Amount** rule and enter a count. Revision Manager keeps that many
of the most recent revisions and marks older ones for deletion. For example,
setting Amount to 3 keeps the three newest revisions of each node (plus the
current one, which is always protected). The default value is 3.

### Age — delete revisions older than N months

Enable the **Age** rule and enter a number of months. Revisions older than that
cutoff (measured by when they last changed) are marked for deletion. The default
value is 6 months.

### Using both together (important)

When you enable **both** Amount and Age for the same type or bundle, Revision
Manager is deliberately conservative: a revision is deleted only if **every**
enabled rule independently agrees it should go. So "keep 5" plus "older than 6
months" deletes only revisions that are both beyond the newest 5 *and* older
than 6 months. Enabling more rules therefore deletes *fewer* revisions, not
more. In every case the current revision and any pending (forward) revisions are
always kept, and multilingual entities are handled per translation.

## Global cleanup and logging options

The settings form also offers two site-wide toggles:

- **Disable automatic queueing** — by default, saving an entity automatically
  queues it for a revision-cleanup check. Tick this if you'd rather not queue on
  every save and instead run cleanup only on a schedule (see below).
- **Verbose log** — when enabled, every revision deletion is written to the log
  (watchdog) so you have an audit trail of what was pruned.

## Per-bundle overrides

The rules on the settings form are per entity *type*. To fine-tune an individual
bundle, edit that bundle after its entity type has been enabled — for example
**Structure → Content types → Article → Edit**. Revision Manager adds its rule
fields to the bundle edit form, and any values you set there override the
entity-type defaults for that bundle only. This lets you, say, keep 10 revisions
on Articles while the rest of your node types follow the site default. Bundles
you don't customize simply follow the entity-type defaults.

## Running the cleanup

Marking revisions for deletion and actually deleting them are two separate
steps. Deletion happens when entities are processed through the
`remove_revisions` queue:

- **Automatically on save** — unless you enabled *Disable automatic queueing*,
  every time an entity is saved it is queued for a cleanup check.
- **On demand from the form** — tick **Enqueue enabled entities for revision
  deletion** on the settings form to queue everything at once.
- **From the command line** — run:

  ```bash
  drush rm:queue
  ```

  This batch-queues all enabled entities across every managed type. It's ideal
  to run from cron or CI so pruning happens on a regular schedule. It only
  *queues* the work; the queue itself is processed by cron (or manually with
  `drush queue:run remove_revisions`), and that is when revisions are actually
  deleted.

## Custom retention rules (for developers)

The Amount and Age rules are plugins, and you can write your own retention rule
by implementing a `RevisionManager` plugin. See the agent docs at
[`plugins/revision-manager.md`](../../agent/plugins/revision-manager.md) for the
plugin interface and a minimal example.
