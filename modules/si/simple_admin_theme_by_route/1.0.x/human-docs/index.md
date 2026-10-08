# Simple Admin Theme by Route — manual setup guide

**Simple Admin Theme by Route** (`simple_admin_theme_by_route`) lets you apply your
site's current **administrative theme** to any route you choose — not just the
built-in admin paths. If you have a custom form, a custom-entity management page, or
some other route that lives outside `/admin` but really ought to look like part of
the admin interface, this module lets you make that happen by simply listing the
route's name.

It is a small, focused theming utility. It has no dependencies and no submodules,
and it does one job: for the routes you name, it negotiates the admin theme instead
of the default front-end theme. It has no bearing on content or access control — it
only decides which theme renders a matched route.

Compared with similar options, the docs note that core's Admin Theme handling and
the *Admin Theme* module work by path, which cannot distinguish, say,
`node/123/edit` based on whether node 123 is a page or a blog — and the
*Administration Theme by Content Type* module keys off content type. Simple Admin
Theme by Route keys off the **route name**, which is a different and sometimes more
precise lever. Note that this project is **not covered by Drupal's security
advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — list the routes that should use the
   admin theme.

## Where it lives in the admin menu

Its settings sit under **Appearance → Use admin theme**
(`/admin/appearance/use-admin-theme`), where you add the route names that should be
rendered with the admin theme.
