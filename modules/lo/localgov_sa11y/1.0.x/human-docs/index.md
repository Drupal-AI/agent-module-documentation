# LocalGov Sa11y — manual setup guide

**LocalGov Sa11y** (`localgov_sa11y`) brings the **Sa11y** accessibility checker to
**LocalGov Drupal** sites. Sa11y is a front‑end accessibility auditing tool that
highlights problems — missing alt text, heading‑order issues, low colour contrast
and more — directly on the page as a widget, so content editors can spot and fix
accessibility issues in context rather than reading a separate report.

Once enabled, the Sa11y widget appears in the bottom‑right corner of pages rendered
in your front‑end theme. The module is deliberately scoped to the front end: it does
**not** run on pages using the admin theme, so it audits the content as visitors see
it. It ships its own permission so you can decide exactly who sees the checker —
which should be your editors, not the public.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and grant the widget permission to your editors.

This module has **no settings form**. The only thing to configure is *who* sees the
widget, which is a permission set on the standard permissions page (below).

## Where it lives in the admin menu

LocalGov Sa11y adds no configuration page. Its single control is a permission,
**Use LocalGov Sa11y** (`use_localgov_sa11y`), set at **People → Permissions**
(`/admin/people/permissions`). Grant it to the roles whose users should see the
accessibility widget — typically editors and content authors.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Grant the **Use LocalGov Sa11y** permission to your editorial roles at **People →
   Permissions**. Leave it off for anonymous visitors so the audit overlay is never
   shown to the public.
3. As a user with the permission, visit any page on your site using the front‑end
   theme. The **Sa11y** widget appears in the bottom‑right corner; open it to see
   the accessibility issues found on that page and fix them in your content.

Because it is oriented toward the LocalGov Drupal distribution, it is designed to run
as part of a LocalGov site, though its job — auditing your front‑end pages — is
self‑contained.
