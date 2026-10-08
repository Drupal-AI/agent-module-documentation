# Configurable Anonymizer — manual setup guide

**Configurable Anonymizer** (`configurable_anonymizer`) lets you define which
sensitive fields on your site hold personal data (PII) and then scrub them with a
Drush command — the classic need when you copy a production database down to a
staging or development environment and must not carry real user data with it. You
configure, per entity type and bundle, which fields to anonymize and which anonymizer
plugin to use for each, and then run the command to replace those values.

It is built around a small, extensible plugin system: field-anonymizer plugins define
*how* a given field is anonymized. It ships with a default plugin that uses Drupal
core's `FieldItemListInterface::generateSampleItems()` to generate replacement data,
plus a UUID anonymizer, and you can add your own plugins for specific field types via
an attribute-based plugin type. A configuration form maps your fields to anonymizers,
and a Drush command performs the run. It also adjusts user-entity queries via a
tagged-query hook. It relies entirely on Drupal core APIs — the only extra requirement
is Drush. This is the 1.0.1 release for core 11.

Because this module is a **data-protection tool that deletes real personal data**, the
operational discipline around it matters as much as the configuration:

- **Never run it against production.** It overwrites real user data. It is meant to be
  run on a *copy*.
- **Run it before anyone accesses the non-production copy.** Anonymization must happen
  after the database sync but *before* the environment is used, so real data is never
  exposed on the lower environment.
- **Treat the field configuration as part of your privacy process.** Deciding which
  fields are PII is a data-protection decision; a field you forget to list will keep
  its real values. Review the mapping against your actual privacy obligations, and test
  the result before relying on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — mapping entity fields to anonymizer
   plugins, and running the anonymization safely.

## Where it lives in the admin menu

Once enabled, the configuration form sits at **Configuration → Development →
Anonymizer** (`/admin/config/development/anonymizer`).
