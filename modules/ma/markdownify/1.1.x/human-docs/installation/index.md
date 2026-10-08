# Installation

## Requirements

Markdownify needs a conversion library and two core modules:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Taxonomy** (`taxonomy`) modules — the default
  supported entity types. They are enabled on most sites already.
- The **`league/html-to-markdown`** PHP library (`^5.1`), which does the actual
  HTML‑to‑Markdown conversion. Composer pulls it in automatically.
- Optional: **`league/commonmark`** — suggested if you want extended Markdown
  formatting via a custom converter.

Because the conversion library is a Composer dependency, install with Composer (below)
rather than downloading a zip, or the library will be missing.

## Install with Composer

From the project root:

```bash
composer require drupal/markdownify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the
`league/html-to-markdown` library and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/markdownify -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en markdownify -y
```

That's all that's needed — Markdown is immediately available for nodes and taxonomy
terms at their `.md` URLs. To restrict which content is exposed or tune the converter,
see [How to use it](../index.md#how-to-use-it).

## Grant the admin permission

The module defines an **Administer markdownify** permission at **People → Permissions**
(`/admin/people/permissions`) that gates the settings form. Grant it to whoever should
manage Markdownify's configuration (administrators by default).

## Submodules — enable only what you need

Markdownify ships three optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Markdownify Path** | `markdownify_path` | Lets you reach Markdown via a content item's **path alias** with `.md` — e.g. `/blog/my-post.md` — not just the canonical `/node/1.md`. |
| **Markdownify Views** | `markdownify_views` | Produces Markdown versions of **Views** listing pages, so listings are consumable as Markdown too. |
| **Markdownify File Attachment** | `markdownify_file_attachment` | Inlines the contents of attached text files (`.txt`, `.json`, `.yml`, …) directly into the Markdown output. |

For example, to expose Markdown at alias URLs:

```bash
drush en markdownify_path -y
```

Each submodule requires the base Markdownify module, which is already present once you
have installed it above.
