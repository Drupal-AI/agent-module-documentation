# Static Generator — manual setup guide

**Static Generator** (`static_generator`) makes a complete static HTML copy of
your Drupal site — every page, plus all the JavaScript, CSS, images and other
assets — so the copy can be served from a plain, fast web server that has no PHP,
database, or cache layer at all. The usual pattern is to keep the real Drupal
install behind a firewall (where you edit content) and push the generated static
files out to a public-facing host with `rsync`.

The point of doing this is performance, security, and reliability. The public
site is nothing but static files, so it serves extremely quickly, has no database
or user accounts to attack, and loses almost every moving part that normally
breaks. Static Generator continues the old Drupal 7 "Static" module (renamed
because `static` is a reserved word in PHP).

It is not a fire-and-forget module — it needs configuration before it does
anything useful. You tell it where to write the generated files, what `rsync`
commands to use for deployment, which content types trigger regeneration, and how
pages should be rendered. It supports **ESI fragments**: any element whose CSS
class starts with `sg-esi--` is turned into an ESI include, so shared blocks can
be regenerated on their own without rebuilding every page. It also hooks into
**Content Moderation** — when a node transitions to *published* its static page is
regenerated automatically, and when it is *archived* the static page is removed.
The module depends on core's Node, Content Moderation, Workflows, and Field UI
modules. Most day-to-day generation is driven from Drush.

This guide is written for a **human** setting the module up through the admin UI
and command line. If you want terse, token-cheap references for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and enabling the module.
2. [Configuration](configuration/index.md) — the settings form and the Drush
   commands that drive generation and deployment.

## Where it lives in the admin menu

Once enabled, the module's settings form sits at **Configuration → Static
Generator** (`/admin/config/static_generator`, route
`static_generator.settings`). Per-entity-type generation settings live at
`/admin/config/static_generator/type/{entity_type_id}`.

## How to use it

Every web route in the module requires the **Administer static generator**
permission — there is deliberately no anonymous or low-privilege endpoint. From
the admin UI a content author can regenerate a single node from `/node/{nid}/gen`
or a single media item from `/media/{mid}/gen`, and inspect generation status at
`/node/{node}/sg`. Full-site generation, block generation, asset deployment and
cleanup are all run from Drush (`drush sg`, `sgp`, `sgb`, `sgf`, `sgr`, `sgd`) —
see the configuration guide for the full list.

A note on trust: because deployment is real shell tooling, the `rsync`/`mkdir`/
`rm` command strings are built from your configuration values without shell
quoting, and the advanced `guzzle_options` setting is evaluated as PHP on each
render (and could, for example, disable TLS verification). None of this is
reachable by an anonymous visitor — it can only be influenced by someone who
already holds the *Administer static generator* permission — but it is a good
reason to grant that permission only to fully trusted administrators.
