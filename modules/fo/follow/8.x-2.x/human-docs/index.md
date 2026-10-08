# Follow — manual setup guide

**Follow** (`follow`) adds "follow us" links to your social-network profiles,
rendered as blocks. It provides two kinds of link set: a **sitewide** set (your
organisation's own social profiles) and a **per-user** set (each member's own
profiles), each exposed as its own block.

The **Follow Site** block lists all the links for the site itself and is visible
on all pages by default. The **Follow User** block lists a user's own follow links
and appears on user profile pages. Administrators define the sitewide links on a
settings form; individual users add their own links from a page on their profile.
Supported networks include Facebook, Twitter/X, LinkedIn, YouTube, Vimeo, Flickr,
Tumblr, last.fm, and more, each with its own icon. The icons and templates are
provided and can be overridden to match your theme, and a Views field plugin lets
you render follow links inside listings.

> **Tip:** the module recommends also enabling something like the *External Links*
> module so follow links open in a new tab — the module deliberately avoids
> `target="_blank"` because it does not validate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — define the sitewide links, place the
   blocks, set permissions, and let users add their own links.

## Where it lives in the admin menu

- **Configuration → People → Follow** (`/admin/config/people/follow`) — the
  sitewide settings form where you enable and define the network links shown in
  the Follow Site block.
- **`/user/{UID}/follow`** — the per-user page where a user adds their own follow
  links.
- **People → Permissions** (`/admin/people/permissions/module/follow`) — the
  module's permissions.
- **Structure → Block layout** (`/admin/structure/block`) — where you place the
  Follow Site and Follow User blocks.

## How to use it

1. Define your organisation's social links on the settings form.
2. Place the **Follow Site** block (for example in the footer) so the sitewide
   links appear across the site.
3. Place the **Follow User** block on user profile pages, and let members add
   their own links at `/user/{UID}/follow`.
4. Optionally use the Views field plugin to show follow links inside a listing —
   for example a member directory or article bylines.
