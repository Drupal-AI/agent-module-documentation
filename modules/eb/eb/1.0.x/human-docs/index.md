# Entity Builder — manual setup guide

**Entity Builder** (`eb`) is a visual, spreadsheet-and-YAML-driven way to build
your Drupal content architecture. Instead of clicking through the Field UI to
create each content type, field, and display one at a time, you describe the whole
model as a **definition** — either in a flat YAML file (one row per item, easy to
edit in a spreadsheet) or through a grid interface — then preview it and apply it
to your site. Entity Builder works out the correct order of operations for you, so
you never have to worry about, say, creating a taxonomy before the field that
references it.

The workflow is **definition-centric**: definitions are reusable config entities
you can apply repeatedly with smart, idempotent sync — new items are created,
changed items are updated, and unchanged items are skipped. Under the hood Entity
Builder turns each definition into atomic operations (create bundle, create field,
configure display, and so on) and resolves their dependencies automatically. It
supports 14+ operation types across bundles (content types, vocabularies, media
types), fields, form/display configuration, and menus, and it offers full
rollback and audit logging.

The base module (**Entity Builder Core**) provides the processing engine and YAML
import, and depends only on core `field`, `field_ui`, and `user`. A browser-based
interface comes from the included **eb_ui** sub-module, and separate extension
projects add more: **Entity Builder AG-Grid** (strongly recommended — a full
Excel-like spreadsheet experience), plus integrations for Field Group, Pathauto,
and Auto Entity Label. A complete set of **Drush commands** makes it usable in
CI/CD pipelines. Entity Builder targets **Drupal 11**, and this release is an
early **1.0.0‑alpha1**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its UI, and consider the recommended AG-Grid extension.

Entity Builder has **no single settings form** — instead of a configuration page,
you work with *definitions* (via the UI, YAML, or Drush), previewing and applying
them. That workflow is described in "How to use it" below.

## How to use it

1. **Enable the UI.** Turn on the included `eb_ui` sub-module (and, for the best
   editing experience, install the Entity Builder AG-Grid extension) so you get a
   browser-based interface for building definitions.
2. **Create a definition.** Describe your bundles, fields, field groups,
   displays, and menus — either in the spreadsheet-style grid or as flat YAML.
   With AG-Grid you get tabbed sheets, inline dropdowns for entity/field types and
   widgets/formatters, auto-generated field names, and real-time validation.
3. **Preview the changes.** Entity Builder shows what will be created, updated, or
   skipped before anything touches your site.
4. **Apply the definition.** Entity Builder converts it into atomic operations,
   resolves the dependencies, and applies them in the right order — logging each
   change.
5. **Re-run or roll back as needed.** Applying the same definition again is safe
   (unchanged items are skipped), and any applied definition can be fully undone.
   For automation, drive all of this from the Drush commands in a CI/CD pipeline.

Full documentation — a quick-start guide, the complete YAML format reference, the
list of operations, an extension-development guide, and the Drush command
reference — ships in the module's own `docs/` directory.
