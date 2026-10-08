# Body Attributes — manual setup guide

**Body Attributes** (`body_attributes`) lets site builders add CSS classes and
arbitrary HTML attributes to the page's `<body>` tag (and other tags) through
configuration, instead of editing theme templates. If you need a class or a
`data-` attribute on the body element so that some CSS or JavaScript can target
the whole page — often for a third‑party integration or a custom styling hook —
this module lets you set it from the admin UI.

That saves you from creating or overriding a theme template just to add a single
attribute, and keeps those hooks in configuration where they are easy to review
and change. It targets Drupal 10.3+ and 11.

Because the attributes you enter are written directly into the page markup, this
is a **markup‑affecting, trusted‑role feature**. Administration is gated by the
`administer body attributes` permission, and you should grant it only to trusted
roles — anyone who can set arbitrary attributes can influence the page's HTML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Make sure your account (or a dedicated trusted role) has the
   **`administer body attributes`** permission — set this under **People →
   Permissions** (`/admin/people/permissions`).
2. Open the module's settings and enter the classes and/or HTML attributes you
   want added to the `<body>` tag (and any other supported tags).
3. Save. The attributes are then emitted into the page markup site‑wide.

Keep the values under the control of trusted administrators only, since they are
inserted directly into the rendered HTML.
