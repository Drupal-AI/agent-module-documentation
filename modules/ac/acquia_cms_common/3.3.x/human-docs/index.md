# Acquia CMS Common — manual setup guide

**Acquia CMS Common** (`acquia_cms_common`) is the **shared foundation** every
other Acquia CMS module builds on — the common configuration, editorial roles,
and cross-cutting functionality that the rest of the family depends on. It is not
a content type; it is the infrastructural base of Acquia's Drupal distribution.

Rather than inventing features, it assembles and pre-configures a broad stack of
well-known contrib and core modules so the distribution has a consistent editorial
experience out of the box: content moderation and a moderation dashboard,
content/config translation and language, CKEditor 5, Metatag (Open Graph, Twitter
Cards) and Schema.org metatags, Pathauto and Redirect, a Simple Sitemap, Acquia
Purge cache invalidation, Password Policy rules, security hardening (Seckit,
username-enumeration prevention), Smart Trim, Diff, Config Ignore/Rewrite, and
Workbench Email. Because it wires all of that together, it pulls in a long
dependency list when you enable it.

Like the rest of the family this is *distribution configuration and glue*,
designed to be adopted together with the other `acquia_cms_*` modules rather than
cherry-picked. It is exactly right on an Acquia CMS site and a strong set of
assumptions on an unrelated one — and it must stay enabled as long as any other
Acquia CMS module is on, since they all build on it. It also ships two optional
submodules, **Acquia CMS Development** and **Acquia CMS Support**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its large dependency set, and choose the optional submodules.

## Where it lives in the admin menu

Acquia CMS Common has no single settings form of its own — it is a foundation
layer. What it configures shows up in the standard admin locations of the modules
it sets up, for example:

- **Content → Moderated content** and the moderation dashboard — editorial
  workflow.
- **Configuration → People → Password policies** — the password rules it ships.
- **Configuration → Search and metadata** — Metatag, Pathauto, Redirect, Simple
  Sitemap.
- **People → Roles** — the editorial roles it defines.

## How to use it

You do not usually interact with this module directly; you install it (or, more
often, it is pulled in automatically by another Acquia CMS module) and then work
through the standard admin screens of the pieces it configures. Its two
submodules are optional:

- **Acquia CMS Development** (`acquia_cms_development`) — development-oriented
  settings; enable it on local/dev environments only.
- **Acquia CMS Support** (`acquia_cms_support`) — support/diagnostic tooling.

Enable those individually with `drush en` if you want them (see
[Installation](installation/index.md)).
