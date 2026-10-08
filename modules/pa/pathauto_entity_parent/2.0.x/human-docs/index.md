# Pathauto entity parent — manual setup guide

**Pathauto entity parent** (`pathauto_entity_parent`) lets a node declare a
**parent** node and then generates path aliases that reflect the resulting
hierarchy, producing URLs like `/my-page/my-child-page-1/my-child-page-2`. URLs
that mirror a site's structure are worth having — `/services/planning/apply` tells
a visitor where they are, gives search engines a signal about relationships, and
makes a section recognisable at a glance in analytics and logs.

Drupal's own tools don't produce this directly. Pathauto builds an alias from
tokens, but a node has no parent to reference; menus express hierarchy for
navigation but aren't available to the alias pattern; taxonomy expresses
classification and yields a different shape (`/category/subcategory/title`); and
core's **Book** module does model parents but brings navigation and printing
assumptions most sites don't want. Giving content an explicit parent and feeding
that into the alias is the direct answer.

Three real costs come with URLs that encode hierarchy — price them before
adopting the pattern:

- **Moving a page changes its URL and every descendant's.** You'll want automatic
  redirects on alias change, which makes the
  [Redirect](https://www.drupal.org/project/redirect) module effectively a
  prerequisite rather than an optional companion.
- **Depth compounds.** Four levels of nesting produce long URLs, and a rename near
  the root rewrites everything beneath it.
- **A cycle is possible unless prevented.** A parent chain that loops back on
  itself would recurse during alias generation — confirm the module refuses one
  rather than discovering it during a bulk regeneration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Pathauto is required; Drupal 11 only).

Setup is short enough to fold in here rather than a separate configuration
chapter — see "Set it up" below.

## Where it lives in the admin menu

Choose which content types can be nested at **Configuration → Search and metadata
→ Parent** (`/admin/config/search/parent`, route
`pathauto_entity_parent.settings_form`).

## Set it up

1. Enable the module (see [Installation](installation/index.md)). Pathauto must be
   installed with an alias pattern for your content type.
2. Go to `/admin/config/search/parent` and enable nesting for the content types
   that should offer a parent option. Only the types you enable here gain the
   parent field.
3. When editing a node of an enabled type, choose its **parent** node. The alias
   is then generated to reflect the parent chain (for example
   `/services/planning/apply`).
4. Install and configure the **Redirect** module first if these URLs matter for
   SEO, so that moving a page automatically leaves a redirect from its old URL.
