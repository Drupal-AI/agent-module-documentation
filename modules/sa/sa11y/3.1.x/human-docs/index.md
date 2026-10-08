# Sa11y — manual setup guide

**Sa11y** (`sa11y`) brings the Sa11y accessibility checker into Drupal. Sa11y is an
in-page, editor-facing auditing tool: instead of a separate report, it overlays
accessibility issues — missing alt text, out-of-order headings, low colour
contrast and the like — directly on the rendered page as an editor reviews the
content, with a small widget that appears in the bottom-right corner of the screen.

It is aimed at editorial and accessibility work, giving content authors immediate,
in-context feedback on the pages they are building. It does not enforce anything or
block publishing — it simply surfaces problems where they occur so they can be
fixed.

Sa11y works as soon as you enable it and grant the right people access. It runs
only on pages that use your **front-end theme**, not the admin theme — so visit a
normal page of your site with your public theme active and you will see the widget.
The one thing you control is *who* can see the checker, via the module's own
permission. It has no other module dependencies, no submodules, and no third-party
libraries to install.

> **Note on naming:** this is a brand-new module that happens to reuse an old
> project namespace. It has no relationship to, and is not an upgrade of, whatever
> previously lived at this name.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable, and grant
   the permission.

## How to use it

There is no settings form to configure. After enabling the module:

1. Grant the **use Sa11y** permission (`use_sa11y`) to the roles whose members
   should see the checker — typically editors and content authors — at
   **People → Permissions** (`/admin/people/permissions`).
2. Log in as one of those users and visit any page on your site that uses the
   **front-end theme**. The Sa11y widget appears in the bottom-right corner; open
   it to review flagged accessibility issues on that page.

Because it runs only on front-end (non-admin-theme) pages, you will not see the
widget while working inside the administration interface.
