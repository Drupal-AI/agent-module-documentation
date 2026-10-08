# SynImport — manual setup guide

**SynImport** (`synimport`) bulk-imports and exports Drupal content between a site
and a directory of structured YAML files, driven entirely from the command line
with Drush. It walks nodes, Commerce products, taxonomy terms, menus and custom
blocks, writes one YAML file per entity (copying attached images and files into a
`files` subfolder), and can read that same structure back to recreate the entities
on another site.

The problem it solves is site-to-site content migration for Synapse-built sites:
export a directory on one site, move it, and import it on another. Field values can
be plainly typed or given an explicit type (`image`, `media`, `attach`, `taxonomy`,
`paragraph`, `variations`, `attribute`); anything unrecognised falls back to text.
One important limitation — SynImport does **not** create or check that the target
content types and fields exist. You must set up the matching bundles and fields on
the destination site first, or the import will not land correctly.

The whole module is command-line only: there are no admin pages, no routes, no
permissions and no settings form. That means it is reachable only by an operator
who already has shell or Drush access to the server. It depends on the `idna`
module and ships no submodules.

Two things happen over the network **during import** that are worth knowing before
you run it against untrusted files. First, any field value that begins with `http`
is fetched server-side and saved into `public://import/` — so a crafted import file
can make the site fetch a remote URL. Second, one code path pulls "visit-card"/brief
data from the fixed external hosts `app.biz-panel.com` / `biz-panel.com`,
authenticating with a token derived from a hardcoded salt plus the ISO week number.
Because import sources are operator-supplied, treat the YAML directory you import as
trusted input and only import files you produced or fully trust.

This guide is written for a **human** operator. If you are an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

SynImport is used entirely through Drush from the Drupal root. Export a whole site
with `drush synexport <dir> <status>` (status `1` for published, `0` for
unpublished), or export just one slice with `drush synexport:node`,
`synexport:product` or `synexport:taxonomy`. Import a full directory with
`drush synimport <dir>`, or import a single kind of content with
`drush synimport:node`, `:menu`, `:taxonomy`, `:product`, `:block`, `:contact` or
`:synlanding_config`. The full command reference lives in the agent docs at
[`agent/drush/commands.md`](../agent/drush/commands.md). Remember to create the
destination content types and fields before importing.
