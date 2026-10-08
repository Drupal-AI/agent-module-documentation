# Classes Extractor — manual setup guide

**Classes Extractor** (`classes_extractor`) is a developer and build tool. It
collects the CSS class names that are already stored in your Drupal
**configuration** — the classes set on Views, on entity view displays (including
Display Suite and Layout Builder settings), and inside a text format's allowed
HTML — and exports the combined, de-duplicated list. That list is exactly what a
CSS optimiser such as **Tailwind** or **PurgeCSS** needs as a safelist so those
CMS-configured classes are never stripped from your compiled stylesheet.

It is important to know what the module does **not** do: it does not scan CSS
files, Twig templates, or module source code, and it has no "pick the modules to
scan" option. The only setting is the output **file path**. The set of places it
looks is fixed by its built-in extractor plugins, and developers can add their own
plugin to cover more sources.

There are two ways to get the collected classes out:

- A **Drush command** (`drush cec`) that runs the extraction and writes the
  space-separated list of classes to the file path you configured.
- A **JSON route** (`GET /api/v1/classes-extractor`) that returns the collected
  classes as `{"classes": "…"}`. This route requires the *Administer site
  configuration* permission — it is not a public endpoint.

Classes Extractor renders nothing on the page and has no content or access-control
role of its own. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the output file path and run the
   extraction.

## Where it lives in the admin menu

The module adds a settings form at **`/admin/config/classes-extractor`**
(*Configuration*), reachable via the **Configure** link on the Extend page. See
[Configuration](configuration/index.md).

## How to use it

The typical workflow is:

1. On the settings form, set the **file path** where the class list should be
   written.
2. Run the extraction from the command line:

   ```bash
   drush cec
   ```

   This collects the CSS classes from your configuration and writes the list to
   that file.

3. Feed that file into your CSS build (for example as a Tailwind or PurgeCSS
   safelist), or fetch the current list as JSON (with the admin permission) from:

   ```
   GET /api/v1/classes-extractor
   ```
