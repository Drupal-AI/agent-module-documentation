# Content First — manual setup guide

**Content First** (`content_first`) renders any node (or a menu) as clean,
layout‑free text — Markdown or simplified HTML, optionally with YAML front
matter — for content review, export, and feeding to tools like mkdocs or LLMs. It
adds a **Content First** tab to node pages that strips away the theme, chrome, and
media wrappers and shows just the content as Markdown, with a heading outline and
copy/download buttons.

It's useful in a few distinct ways. Editors get a distraction‑free view of the
actual copy for reviews and accessibility reading. Teams building documentation
sites or LLM context can export content — the module provides per‑view‑mode
tokens and two Drush commands that write Markdown files (with options for
Obsidian‑style link rewriting and absolute asset URLs) and export the entity field
architecture as YAML. There's even a parallel tab that renders a whole menu tree as
Markdown.

A global settings page controls which entities and bundles get the tab, which
metatags and entity properties become front matter, which CSS selectors to strip
before conversion, and whether menu links are included. An optional submodule,
**Content First Audit** (`content_first_audit`), adds automated heading and
metatag auditing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (note the several contrib/library dependencies).
2. [Configuration](configuration/index.md) — the settings form, field by field,
   plus permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Content First**
(`/admin/config/content/content-first`), reachable by users with the **Administer
content_first** permission. The rendered output appears as a **Content First** tab
on node pages (and on menu edit forms).

## How to use it

1. On the settings form, choose which entities/bundles get the tab and what should
   appear as front matter (see [Configuration](configuration/index.md)).
2. Grant the **View content_first content** permission to the roles that should be
   able to view and export the clean output.
3. Open a node and click its **Content First** tab to read, copy, or download the
   Markdown. Use the heading outline to check structure.

For bulk work, the two Drush commands export content to Markdown files
(`drush cf:export`) and export field architecture to YAML (`drush cf:architecture`)
— see the [agent Drush docs](../agent/drush/commands.md). You can also pull a
node's clean Markdown anywhere tokens are supported via
`[node:content-first-markdown-<view_mode>]`.
