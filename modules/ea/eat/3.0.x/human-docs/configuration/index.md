# Configuration

Entity Auto Term does nothing until you tell it **which node bundles** should
generate terms and **in which vocabularies**. That mapping is the whole of the
configuration.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Entity Auto Term**, or navigate directly to
   `/admin/config/system/eat`.

## Map bundles to vocabularies

On the settings form, choose which **node bundles** (content types) should have
auto-terms and select the **vocabulary (or vocabularies)** each one writes into.
A single bundle can be mapped to more than one vocabulary — EAT will create the
node's term in each.

Once saved, the mapping drives everything automatically through the content
lifecycle:

- **On create** — a term named after the node title is created in each mapped
  vocabulary (or an existing same-named term is reused), and a row is written to
  the `{eat}` table linking the node, term, and vocabulary.
- **On edit** — the linked term is renamed to match the node's new title.
- **On delete** — the term and its mapping are removed.

## Backfill existing content

If you already have content that predates EAT, you can generate its terms
retroactively:

- **Batch form** — at `/admin/config/system/eat/batch`, run the batch update to
  create terms and `{eat}` rows for all configured nodes at once.
- **Drush** — `drush eatas` (the `eat-add-single` command) adds a single mapping
  from the command line.

> **Security note:** the batch backfill route is a mutating operation (it creates
> taxonomy terms). Make sure it is only reachable by trusted administrators —
> review who can access `/admin/config/system/eat/batch` on your site and restrict
> it if your permission setup is broad.

## Using the auto-term in Views

To build "related content by auto-term" listings or contextual filters, add a
contextual filter to your View and set its default value to **Content ID from
path for EAT** (EAT's argument-default plugin). It reads the current node's path
and supplies the mapped term id, so the View can list other content sharing that
term.
