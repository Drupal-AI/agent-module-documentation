# Content Packages — manual setup guide

**Content Packages** (`content_packages`) is a Drush toolset that turns selected
Drupal content entities into canonical, portable "content packages" — Markdown
documents (with YAML front matter) plus asset/reference archives — and imports,
exports, verifies, and diffs them again. It's built for teams that want important
editorial, documentation, demo, or starter content to move through the same
review and deployment process as code and config: content lives in Git, changes
get reviewed in pull requests, and the same package can be replayed across
environments without creating duplicates (imports upsert by UUID).

Everything is done from the command line — there is **no admin page, no settings
form, and no web-facing endpoint**. That's a deliberate security property: the
tool is reachable only by an operator who already has shell/Drush access, so there
is no anonymous import path and no request-driven URL fetching. Archive handling
is hardened too — imports always run verification first (there is no bypass),
path-traversal and absolute-path entries are rejected, and decompression-bomb
limits are enforced before anything is extracted.

The module requires the **CommonMark** and **HTML-to-Markdown** PHP libraries
(pulled in via Composer), and PHP's **ZipArchive** extension for archive export
and verification. It depends on core's **Filter** and **Text** modules, and
optional integrations light up automatically when supporting modules such as
**Media**, **Entity Reference Revisions**, **Paragraphs**, and **Webform** are
installed. It supports Drupal 10 and 11. Note it is intentionally scoped to
*selected* content packages — it is not a full site-wide content sync tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm the required libraries, and enable it.

There is **no configuration page** for this module — it is operated entirely
through Drush commands, described in "How to use it" below.

## Where it lives in the admin menu

Content Packages adds no admin page. You use it entirely from the command line via
`drush content-packages:*` commands.

## How to use it

All operations are Drush commands. The main ones are:

| Command | What it does |
|---------|--------------|
| `drush content-packages:validate <source>` | Validate a package source against a package type (`--package-type`, default `node_markdown_body`). |
| `drush content-packages:import …` | Import package(s) from a source (supports content-scheduling options). |
| `drush content-packages:export …` | Export content to Markdown package files. |
| `drush content-packages:archive:export …` | Export a full archive (content + assets + integrity manifest). |
| `drush content-packages:archive:verify <archive>` | Verify an archive's integrity, references, and structure. |
| `drush content-packages:archive:import <archive>` | Import an archive — always verifies first; supports dry-run/strict. |
| `drush content-packages:diff <source>` | Diff on-disk packages against current site content. |
| `drush content-packages:assets:cleanup` | Remove orphaned package assets (`--delete`). |

A typical workflow: **export** content to Markdown/archive on one site, commit it
to Git and review it in a pull request, then **verify** and **import** it on
another environment. Use **diff** to detect drift between your Git package files
and the live site.

> **Remember the DDEV prefix.** From your host machine run these as
> `ddev drush content-packages:…`; inside the container (`ddev ssh`) run `drush …`
> directly.
