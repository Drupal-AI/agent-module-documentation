# System Tags — manual setup guide

**System Tags** (`system_tags`) bridges content and code. You give an important
piece of content a stable, memorable label — like `homepage`, `page_not_found`, or
`terms_of_service` — and then refer to "the page tagged X" from code, Twig,
tokens, or block-visibility rules, without ever hard-coding the entity's ID. Move
the tag to a different node and everything that references it follows, with no
config changes and no broken links.

Tags are lightweight config entities (a machine name plus a label), managed at
**Structure → System Tags**. To mark content with a tag you add an
entity-reference field (targeting the *System Tag* type) to any content type, then
set the tag on individual entities. A pluggable finder resolves the tagged entity,
running proper access and published-status checks and honouring language fallback,
newest-changed first. Finders for **nodes** and **custom blocks** ship built in,
and you can add your own for other entity types.

Three tags are special. Tag a node `homepage`, `access_denied`, or
`page_not_found` and System Tags overrides `system.site` so that node becomes your
site's front page, 403, or 404 page — no manual path configuration. Beyond that you
get a Twig function `system_tag_url('homepage')`, per-entity-type tokens like
`[system_tags:node--homepage]` that resolve to a tagged page's aliased path (great
in Pathauto patterns, metatags, and emails), and a **System Tags** block-visibility
condition to show a block only on tagged pages. An optional **System Tags: Theme**
submodule adds `node--system-tag--<tag>` template suggestions and body classes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the theme submodule.
2. [Configuration](configuration/index.md) — managing tags, adding the reference
   field, the three special pages, the block-visibility condition, and the three
   permissions.

## Where it lives in the admin menu

- **Tags** — **Structure → System Tags** (`/admin/structure/system_tags`): create,
  edit, and delete tags. Ships with three: `homepage`, `access_denied`,
  `page_not_found`.
- **Permissions** — grant the three System Tags permissions at **People →
  Permissions** (`/admin/people/permissions`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Add a **System Tag** entity-reference field to the content types you want to tag
   (see [Configuration](configuration/index.md)).
3. Edit a node and set its tag — for example tag your landing node `homepage` to
   make it the front page instantly.
4. Reference tagged content wherever you need it: `system_tag_url('homepage')` in a
   template, `[system_tags:node--homepage]` in a token-enabled field, or the
   **System Tags** condition in a block's visibility settings.
