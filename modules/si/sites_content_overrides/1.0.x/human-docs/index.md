# Sites overrides — manual setup guide

**Sites overrides** (`sites_content_overrides`) adds per‑site content overrides to
a multi‑site built on the **Sites** module. In a Sites setup many domain‑scoped
sites share the same content; this module lets an individual site carry its own
site‑specific variant of an entity, which is resolved transparently whenever that
site (or its preview) is the active context — so callers get the override without
having to know it exists.

The problem it solves is "the same page, but different on this one site." Rather
than duplicating content or branching logic everywhere, you mark an entity as
overrideable and edit a per‑site version of it. Under the hood the module works by
**decorating the services that load entities**: a site‑aware entity resolver plus
decorators over the route entity param converter and the entity repository make
both route‑based and programmatic entity loads return the site‑specific override
when one exists. A Views query extender keeps listings site‑aware, a validation
constraint handles concurrent‑edit conflicts per site, and Navigation top‑bar items
surface the override status and the override/revert actions in the admin UI.

This module builds on the (non‑core) **Sites** ecosystem — it depends on
`form_decorator` and core `navigation`, and only makes sense on a site already
running the `sites` / `sites_preview` stack. It has a small configuration form
where you choose which entity types and bundles are overrideable, and it ships four
optional submodules that extend overrides into Content Moderation, Layout Builder,
paragraph Behaviors, and a per‑site Revisions UI.

One access‑control detail is worth understanding. When you are editing a site
override, the module deliberately grants update/delete access to paragraphs on that
override edit route — this bypasses the Content Moderation gate that would
otherwise block paragraph edits. It does so **only after delegating the real
authorization check to the Sites module's per‑site content access**
(`$site->contentAccess('update', …)`), and the override action links are
CSRF‑tokenised, so the bypass is scoped to the site‑override edit flow rather than a
blanket permission.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — choose which entity types and bundles
   are overrideable, then edit per‑site overrides.

## Where it lives in the admin menu

The settings form sits at **`/admin/config/sites/content-overrides`**, behind the
`administer site configuration` permission. Once entity types are configured, you
edit and revert overrides from within a site's context, and the Navigation top bar
shows each page's override status and actions.
