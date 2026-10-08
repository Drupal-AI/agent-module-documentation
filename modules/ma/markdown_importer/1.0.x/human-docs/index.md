# Markdown Importer — manual setup guide

**Markdown Importer** (`markdown_importer`) pulls Markdown files out of a public
GitHub or GitLab (or other public‑hosted Git) repository and turns them into Drupal
content. It is built for teams that keep their documentation as Markdown in a
repo — a "docs as code" workflow — and want that content available as nodes inside
Drupal.

You point the module at a repository, tell it which content type and field should
receive the content, and it fetches the Markdown files (scanning subdirectories
recursively) and converts them to HTML using the `league/commonmark` parser. It
depends on core's **Filter** module and supports Drupal 10 and 11.

Two things are worth knowing up front. First, the import reads from an
**admin‑configured public repository** — it is not a place where arbitrary users
paste URLs, and private repositories are not supported in this version (they would
need authentication that the module does not provide). Second, conversion is done
with secure defaults (`html_input: strip`, `allow_unsafe_links: false`), so raw
HTML in the source Markdown is stripped rather than rendered.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (including the CommonMark libraries) and enable it.
2. [Configuration](configuration/index.md) — point the importer at a repository,
   choose the target content type and field, and run an import.

## Where it lives in the admin menu

The import form lives at **Configuration → Web services → Import Markdown**
(`/admin/config/services/import-markdown`).
