# Migrate Source Directory — manual setup guide

**Migrate Source Directory** (`migrate_source_directory`) adds a Migrate *source
plugin* that reads a **directory of files** — so a folder of documents, images,
or HTML becomes migration rows without you first having to build a CSV that lists
them all.

Migrate ships source plugins for databases, CSV, JSON, XML, and URLs, but the
filesystem itself is a gap. Importing a folder of a thousand PDFs would normally
start with generating a manifest — a script that produces a CSV of filenames,
which then has to be regenerated whenever the folder changes. This plugin removes
that step: you point a migration at one or more directories, and each file becomes
a row with its path and metadata exposed as source properties for the process
pipeline to map onto a file, media, or content entity.

It's a lightweight, developer‑oriented plugin: it depends only on core
**Migrate**, adds no admin pages, permissions, or configuration UI, and is used
entirely from migration YAML. Two practical things to keep in mind — the
directory is read *at migration time*, so a folder that changes between a
`migrate:status` and a `migrate:import` will produce different counts; and because
the directory path comes from the migration configuration, it's chosen by whoever
writes the migration (a developer), not by an end user.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
You use it from your migration definitions, as described below.

## How to use it

Use the `directory` source plugin and point it at one or more directories:

```yaml
source:
  plugin: directory
  track_changes: true
  # One or more directories to scan (recurses into subdirectories).
  directory:
    - /path/to/files/for/import
  # (optional) A regex mask applied to file paths, relative to the directories
  # above — only matching files are processed (e.g. by extension).
  file_mask: '/(.*\.(mp3|m4a|wav)$)/i'
  # (optional) How deep to recurse. -1 (default) means no limit.
  recurse_level: -1
  # (optional) A prefix added to the sourceID when processing files.
  id_prefix: 'optional_sourceid_prefix'
  # (optional) Only process files containing one of these strings (uses strpos,
  # so really only for text-like files).
  file_must_contain_string:
    - ' '
```

Each file becomes a row exposing these source fields: `sourceID` (the file path,
relative to the directory — this is the unique ID), `source_file_basename`,
`source_file_extension`, `source_file_filename`, `source_file_mtime`,
`source_file_path`, `source_file_pathname`, `source_file_realpath`,
`source_file_size`, and `source_file_type`.

### Importing files as Drupal file entities

A common use is copying files into Drupal as `file` entities. Map the real path to
a destination URI with `file_copy`:

```yaml
id: directory_mp3
label: 'Import audio files'
source:
  plugin: directory
  constants:
    uri_file: 'public://'
  track_changes: true
  directory:
    - /path/to/files/for/import
  file_mask: '/(.*\.(mp3|m4a|wav)$)/i'
process:
  source_full_path: source_file_path
  uri_file:
    - plugin: concat
      delimiter: /
      source:
        - constants/uri_file
        - source_file_filename
    - plugin: urlencode
  filename: source_file_filename
  uri:
    plugin: file_copy
    source:
      - '@source_full_path'
      - '@uri_file'
destination:
  plugin: 'entity:file'
```

You can then reference those files from other migrations using their `sourceID`.

### Importing file contents as content entities

You can also iterate over a set of files and import their *contents* — for
example a folder of Markdown files becoming nodes. To read a file's body, pair the
plugin with a `hook_migrate_prepare_row()` implementation (or a custom source
plugin that extends this one) that loads `source_file_realpath` and pulls the
content you need into the row.
