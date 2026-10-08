# GraphQL Export — manual setup guide

**GraphQL Export** (`graphql_export`) writes a GraphQL server's schema out to a
file — either as SDL (the human-readable `.graphqls` schema language) or as a
JSON introspection result. Getting the schema out of a running Drupal site is
usually the awkward part of a decoupled workflow, and this module makes it a
first-class artefact you can download, script, or commit alongside your
configuration.

It is aimed at teams building a decoupled front end. Code generators turn the
SDL into a typed client, CI can diff the committed schema to catch a breaking
API change before it ships, and reviewers can read the file to see what an API
change actually did. The module leans on the GraphQL module's own access model:
its export routes are guarded by the same explorer-access check that protects
the GraphQL explorer for that server, so it inherits the permission model
rather than inventing a new one.

There are three ways to export: a web UI, a Drush command, and an automatic
hook that fires whenever you run `drush config:export`. It has no settings form
of its own — the Drush behavior is switched on by a small snippet in
`settings.php`, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside GraphQL.

There is **no configuration page** for this module. The export UI is an action,
not a settings form, and the Drush integration is configured in `settings.php`
(see "How to use it" below).

## Where it lives in the admin menu

GraphQL Export adds no top-level settings page. Once enabled, each GraphQL
server gains an **Export** tab at
`/admin/config/graphql/servers/manage/{server_machine_id}/export`, where you can
view and manually download the schema (as SDL or JSON). You reach it from
**Configuration → Web services → GraphQL Servers**, then the server you want.

## How to use it

**From the UI.** Go to the server's export page above and download the schema in
whichever form your front-end tooling expects.

**With Drush.** The `graphql-export:schema` command exports on demand, and you
can select the output type with a command option. To have the schema written
automatically on every configuration export, add a snippet like this to
`settings.php`, naming each server and where its files should be written:

```php
$settings['graphql_export'] = [
  'my_server_machine_id' => [
    'graphqls' => '../path/to/save/schema.graphqls',
    'json'     => '../path/to/save/schema.json',
  ],
];
```

The paths can be anything writable by Drupal at export time. With that in place,
`drush config:export` writes the schema files as a post-command step — so the
schema travels with your configuration in version control, and a pull request
that changes a type shows the schema change right in the diff.

> **Note:** This 2.x branch targets GraphQL 4.x. If you are still on GraphQL
> 3.x, use the module's `8.x-1.x` branch instead, which offers only the Drush
> integration and has slightly different settings.
