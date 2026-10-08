# Bootstrap tools (twbstools) — manual setup guide

**Bootstrap tools** (`twbstools`) is a small companion module for the **Bootstrap
5 theme**. It adds exactly one thing: a **style guide / cheatsheet** page at
`/styleguide` that renders every Bootstrap 5 component — buttons, alerts, cards,
forms, tables, badges, utilities and the rest — on a single page, styled with your
site's own Bootstrap assets.

That makes it a quick, in-site reference for the whole team. Front-end developers
get a living catalogue of the classes and markup available in the theme; content
editors can see what styled components look like before using them; and everyone
can sanity-check that a Bootstrap or theme upgrade didn't visually break anything —
all without leaving the site to browse getbootstrap.com.

There is genuinely **nothing to configure**: no settings, no permissions to
manage, no fields. The page is a bundled, static copy of Bootstrap's own
cheatsheet, rendered inside your theme. Its one real requirement is that the
**Bootstrap 5 theme** is installed, because the page's styling relies on that
theme's Bootstrap library — without it the page renders unstyled.

This guide is written for a **human**. If you want a terse, token-cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The style guide page is at **`/styleguide`**, and there's a menu link and tab for
it under **Configuration → Development → Styleguide**
(`/admin/config/development`). The page uses the *Access content* permission, so
it's viewable by anyone who can see site content.

## How to use it

Just enable the module (and make sure the Bootstrap 5 theme is installed) and
visit **`/styleguide`**. Scroll or use the page's side navigation to browse the
components. Resize the browser to check responsive behavior, and copy any markup
patterns you need into your own templates or content. There are no settings to
adjust — this page *is* the whole module.
