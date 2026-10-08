# Content Access by Path — manual setup guide

**Content Access by Path** (`content_access_by_path`) aims to confine an editor to
the parts of a site whose **URL aliases begin with a configured path** — so a news
team can edit everything under `/news/…` and nothing else. It depends on core's
Field and Taxonomy modules, and ships an optional submodule
(`content_access_by_path_admin_content`).

The idea is a genuinely useful one. Delegating editing "by section" is a common need
on large sites, and core has no native answer: permissions are per content type and
per ownership, neither of which expresses "this team owns this branch of the site".
Content Access by Path keys on the path alias — which already mirrors the site's
structure — and enforces its update/delete decisions through Drupal's entity access
layer (`hook_node_access()` and `hook_entity_field_access()`), so they apply to the
edit form and to JSON:API/REST writes, not just the rendered page. An editor's allowed
sections are driven by a taxonomy field on their user account.

A couple of behaviours are worth understanding before you configure it:

- **A user with no sections assigned is unaffected** — they keep whatever edit/delete
  access Drupal would otherwise give them. The module only starts to narrow a user
  once their section field is populated.
- **Editors can always edit content they authored**, by design: this is so that a
  wrong alias on their own node never locks them out of it. Scope your roles with that
  in mind.
- **Sections are matched as path prefixes**, so a section of `/news` covers everything
  whose alias begins with `/news`. Choose section paths and aliases so a prefix maps to
  exactly the branch you intend.

This project is covered by Drupal's security advisory policy; check the project page
for the current release before deploying it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and (optionally) its admin‑content submodule.
2. [Configuration](configuration/index.md) — set up the sections and assign editors,
   plus what the module does and does not protect.

## Where it lives in the admin menu

The module provides a settings form (route `content_access_by_path.settings`) under
the site's **Configuration** area, gated by the **"Administer content access by
path"** permission. Per‑editor section assignments are made through a **taxonomy
field on the user account**. See [Configuration](configuration/index.md).
