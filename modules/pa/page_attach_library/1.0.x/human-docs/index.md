# Page Attach Library — manual setup guide

**Page Attach Library** (`page_attach_library`) lets an administrator attach any
registered Drupal asset library (its CSS and JS) to the pages whose path matches
a pattern you configure — all from a settings form, with no custom module to
write.

Drupal ships thousands of small asset libraries (yours, your theme's, and every
contrib module's), and the "proper" way to load one only on certain pages is to
write a `hook_page_attachments()` in code. This module turns that into a
point‑and‑click task: you build a list of rules, each pairing a set of page paths
with a set of library identifiers, and at render time the module attaches the
listed libraries to any matching page.

Each rule has an **Enabled** checkbox, a **Pages** field (one path per line, with
the `*` wildcard and the `<front>` token), and a **library** field listing one or
more `module_name/library_name` identifiers. Rules live in configuration and can
be reordered by drag‑and‑drop. A rule only takes effect if the library it names is
actually declared by an installed module or theme — you cannot conjure assets that
do not exist — and the whole feature is limited to trusted administrators through
the core **Administer site configuration** permission. It has no anonymous or
mutating endpoints, makes no outbound HTTP requests, and handles no credentials.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — build the rules that map page paths
   to asset libraries.

## Where it lives in the admin menu

The settings form is at **Configuration → Page Attach Library → Page Attach
Library Settings**
(`/admin/config/page-attach-library/page-attach-library-settings`), behind the
**Administer site configuration** permission.
