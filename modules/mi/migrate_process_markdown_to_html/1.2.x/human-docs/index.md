# Migrate Process Markdown to HTML — manual setup guide

**Migrate Process Markdown to HTML** (`migrate_process_markdown_to_html`) is a
Migrate process plugin that converts **Markdown source values into HTML** as part
of a migration. If your source system stores content as Markdown but you want it
to land in Drupal as HTML, drop this plugin into the process pipeline for that
field and the conversion happens during import.

Under the hood it uses the well‑regarded **CommonMark** package from The League of
Extraordinary Packages, so you get standards‑compliant Markdown rendering — and
you can optionally turn on any of CommonMark's extensions (tables, footnotes,
autolinks, GitHub‑flavored Markdown, strikethrough, task lists, and more) by
listing them in the plugin configuration.

It depends only on core **Migrate** (`migrate`) and supports **Drupal 10 and 11**.
This is a developer/migration tool that runs in the Migrate pipeline (typically
Drush‑driven); the Markdown it converts is admin‑defined migration input, and
there is no admin settings screen. You configure the plugin inline in your
migration YAML.

> **Store the HTML against a text format.** The plugin produces HTML that becomes
> field content. Store it against an appropriate Drupal **text format** and render
> it through Drupal's filter system, so any HTML is subject to that format's XSS
> filtering on output — rather than outputting the converted markup raw.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core Migrate.

There is **no configuration page** for this module. It has no settings form; you
use the `markdown_to_html` plugin from migration YAML as described below.

## How to use it

Add the `markdown_to_html` plugin to the process step for the destination field,
with `source` pointing at the Markdown field. Optionally list the CommonMark
extensions you want enabled:

```yaml
process:
  bar:
    plugin: markdown_to_html
    source: foo
    markdown_extensions:
      - attributes
      - autolink
      - description_list
      - disallow_raw_html
      - embed
      - external_link
      - footnote
      - github_flavored_markdown
      - heading_permalink
      - inlines_only
      - mention
      - smart_punct
      - strikethrough
      - table
      - table_of_contents
      - task_list
```

The `markdown_extensions` list is optional — omit it for plain CommonMark
rendering. Each entry corresponds to an extension shipped with the CommonMark
package. The `disallow_raw_html` extension is worth noting: it strips raw HTML
embedded in the Markdown, which is a sensible choice when the source content is
not fully trusted.
