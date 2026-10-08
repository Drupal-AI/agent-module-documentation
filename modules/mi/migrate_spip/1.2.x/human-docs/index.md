# Migrate SPIP — manual setup guide

**Migrate SPIP** (`migrate_spip`) helps you migrate content from the
[SPIP](https://www.spip.net/) CMS into Drupal. Its centrepiece is a converter
that turns SPIP's rich-text markup into clean HTML, so that content authored in
SPIP's non-standard editor renders correctly once it lands in Drupal's formatted
text fields.

SPIP's rich-text editor isn't based on any common standard (not HTML, BBCode, or
Markdown), which makes converting its content genuinely tricky. Migrate SPIP
builds on SPIP's own Textwheel engine to reproduce the core conversion behavior,
giving you HTML you can insert into Drupal fields. The migration sources query
the SPIP database directly, so you need access to a copy of the SPIP database
during the migration.

This is a developer/migration utility — it transforms text during import and has
no content or access role of its own. The converted HTML becomes ordinary Drupal
content, which is then filtered by the destination field's text format as usual.
Three optional submodules support the work: **Migrate SPIP UI** provides an
interface for managing settings and testing conversions, **Migrate SPIP Examples**
ships plugin examples you can extend, and **Migrate SPIP Plus** (built on Migrate
Plus) provides ready-made configurations for common SPIP models such as
*articles*, *rubriques*, and *noisettes*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

The base module has **no configuration page**. You use its converter and source
plugins from a migration definition, described below. (The optional **Migrate
SPIP UI** submodule does add an interface for managing settings and testing
conversions.)

## Where it lives in the admin menu

The base module adds no admin page — you use its plugins from migration YAML and
run them with Drush. If you enable the **Migrate SPIP UI** submodule, it provides
a settings-and-test-conversion interface in the admin UI.

## How to use it

1. Give Drupal access to the SPIP source database (or a copy of it), since the
   migration sources query it directly.
2. Write your SPIP migrations. Use the module's rich-text converter (as a Migrate
   process step) on the fields that contain SPIP markup, so their contents are
   converted to HTML before being saved into Drupal formatted text fields.
3. For a head start, enable **Migrate SPIP Plus** to get pre-built configurations
   for standard SPIP models, and look at **Migrate SPIP Examples** for plugin
   patterns you can adapt.
4. Run the migrations with `drush migrate:import` and manage them with the usual
   `drush migrate:status` / `drush migrate:rollback` commands.

For details on extending the module and wiring up the conversion, see the
project's own README on drupal.org.
