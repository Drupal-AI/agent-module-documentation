# Stylify — manual setup guide

**Stylify** (`stylify`) is an on-site CSS editor. Trusted users open a page, click
a **CSS Editor** button in the bottom-right corner, and write custom CSS right
there with syntax highlighting and a live preview — no theme deploy required. The
CSS is saved in the database and then served to every visitor who can see the
matching page.

What sets it apart from theme-only CSS editors is that it understands **scope**.
On a single page you can attach CSS at several different levels: **global**
(site-wide front-end), **admin global** (the administrative interface), **per
route or View**, **per entity type** (say, all nodes), **per content type** (all
Blog posts), or an **individual entity** (just node 123). Each saved stylesheet is
served only where it applies, and empty stylesheets are not attached at all, which
keeps things fast.

It works as soon as you enable it and grant the right permissions — there is no
mandatory settings form to fill in before you can start, though there is a small
settings page for housekeeping (releasing stale edit locks). Stylify has **no
contributed-module dependencies** and bundles the Ace code editor for syntax
highlighting.

**Please read this before granting access.** Custom CSS added through Stylify
affects every visitor who can see the page, so these permissions are effectively
code-deployment rights and every one of them is marked *restrict access*. Grant
them only to trusted administrators. The module does apply some safeguards —
basic CSS validation that blocks certain dangerous patterns, an editing lock so two
people cannot clobber the same stylesheet, CSRF tokens and flood/rate control on
the save endpoints — but validation reduces risk rather than making untrusted CSS
safe. Treat Stylify access the way you would treat the ability to deploy code.

This guide is written for a **human** clicking through the admin UI and the on-page
editor. If you are an AI coding agent, read the terser sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the editor permissions.
2. [Configuration](configuration/index.md) — the permissions, the on-page editing
   workflow, and the central stylesheet-management screens.

## Where it lives in the admin menu

Two admin screens sit under **Configuration → System**:

- **Stylify stylesheets** (`/admin/config/system/stylify/stylesheets`) — list,
  edit, delete, export, and import saved stylesheets.
- **Stylify Settings** (`/admin/config/system/stylify`) — housekeeping such as
  releasing a stale editor lock.

The main way you *create* CSS, though, is the on-page **CSS Editor** button in the
bottom-right corner of any page where you have permission to edit — see
[Configuration](configuration/index.md).
