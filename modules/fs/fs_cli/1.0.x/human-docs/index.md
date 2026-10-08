# File System to CLI — manual setup guide

**File System to CLI** (`fs_cli`) exposes Drupal's file system API as a small set
of **Drush commands**, so you can inspect and manipulate files from the command
line and from automation without writing one-off PHP snippets.

Every command runs through Drupal's `file_system` service rather than touching the
disk directly. That means operations honour Drupal stream wrappers — `public://`,
`private://`, `temporary://`, and remote backends such as `s3://` (via the S3 File
System module) — so a script behaves the same whether files live on local disk or
in object storage. Each command returns machine-readable **JSON** by default, which
makes the module a good fit for deployment pipelines, CI jobs, and infrastructure
tooling that needs to act on the result of a file operation.

There are no routes, controllers, forms, or permissions, and nothing is exposed on
the web. Access is governed entirely by who can run Drush on the server. Bear in
mind that destructive operations (`fs:move`, `fs:delete-dir`) act on whatever path
you pass, so treat it like any other shell tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. There is no configuration to do.

This module has **no configuration page** — it is entirely CLI-driven and requires
no setup after enabling.

## How to use it

Every command accepts a `--format` option (default `json`). The available commands:

| Command | Alias | What it does |
|---------|-------|--------------|
| `fs:file-exists` | `fs-fe` | Report whether a file exists. |
| `fs:directory-exists` | `fs-de` | Report whether a directory exists. |
| `fs:copy` | | Copy a file, creating the destination directory if needed. |
| `fs:move` | | Move a file, creating the destination directory if needed. |
| `fs:mkdir` | | Create a directory. |
| `fs:scan-dir` | | List files in a directory matching a regular-expression mask. |
| `fs:delete-dir` | | Delete a directory and its contents recursively. |

For `fs:copy` and `fs:move`, an optional `replace` argument controls what happens
when the destination already exists: `0` renames (appends an incrementing numeric
suffix until unique), `1` replaces the existing file (the default), and `2` does
nothing and returns an error.

A few examples:

```bash
# Check whether a file exists on the public file system.
drush fs:file-exists public://logo.png

# Copy a file to S3-backed storage (with S3 File System configured).
drush fs:copy public://export.csv s3://backups/export.csv

# List every JPEG file under a directory.
drush fs:scan-dir public://images '/\.jpg$/'

# Create a working directory and remove it afterwards.
drush fs:mkdir temporary://build
drush fs:delete-dir temporary://build
```

Because the output is JSON, you can pipe it into `jq` for further processing in a
deployment or CI script.
