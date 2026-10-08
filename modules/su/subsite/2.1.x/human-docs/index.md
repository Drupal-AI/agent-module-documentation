# Sub Site — manual setup guide

**Sub Site** (`subsite`) lets you make any node — or a set of nodes — look like a
different website, by overriding the theme, branding, main menu, and more, all from
within your normal editorial process. It is designed for event and campaign
micro-sites, where you want a distinct look for a section of the site without
standing up a whole separate installation.

The clever part is that everything is stored in a field attached to a single node,
which becomes the subsite's "home page". That means subsite configuration travels
with the node — it supports content revisions and fits your usual content workflow,
and it is meant to be driven by **content editors**, not just site administrators.
Any content type can become subsite-enabled simply by adding a subsite field to it,
and you can have as many subsites as you like. For multi-page subsites, Sub Site
leans on core's **Book** module: the subsite home node is the top page of a book,
and its child pages (of any content type) form the subsite's page tree, with the
book navigation shown as the subsite's menu.

Out of the box it ships plugins for four kinds of override: **theme** (pick any
enabled theme), **branding** (override site name, logo, favicon, etc.), **Book
integration** (use a book hierarchy and override the main-menu navigation), and
**social media links** (override social links per subsite, via the Social Media
Links module). A theme negotiator swaps the active theme automatically as visitors
browse inside a subsite, and page output is varied per subsite so caching stays
correct.

Sub Site is intentionally lightweight — it is not a replacement for Domain Access or
Organic Groups, and the maintainer describes it as still having room for
refinement, and is seeking a co-maintainer. It **depends on the Book and Social
Media Links modules**. It is an admin/editor tool: all its routes are
permission-gated, with no anonymous or public mutating endpoints.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the terser sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with Book and Social Media Links).
2. [Configuration](configuration/index.md) — add the subsite field, set the
   defaults, and create your first subsite.

## Where it lives in the admin menu

There are two admin screens under **Structure**:

- **Sub Site overview** (`/admin/structure/subsite`) — lists your existing
  subsites. (Reaching it requires the *Administer Sub Site settings* permission,
  the string the route uses.)
- **Sub Site settings** (`/admin/structure/subsite/settings`) — configure allowed
  content types and defaults; requires *Administer site configuration*.

Most of the day-to-day work, though, happens on the **node form**: editors with the
right permission see a *Subsite* settings panel when creating or editing a
subsite-enabled node.
