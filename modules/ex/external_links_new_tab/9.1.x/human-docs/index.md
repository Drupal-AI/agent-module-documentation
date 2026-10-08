# External Links In New Tab — manual setup guide

**External Links In New Tab** (`external_links_new_tab`) makes every external link
your site renders open in a new browser tab, automatically. Enable the module and
you are done — there is nothing to configure. Whenever Drupal builds a link that
points to another site, the module adds `target="_blank"` (open in a new tab) and
`rel="noopener"` to it.

The `rel="noopener"` part is a small but important security and privacy hardening:
it stops the newly opened page from getting a reference to your page through
`window.opener`, which prevents "reverse tabnabbing" attacks and suppresses the
window handle. So this module both improves the browsing experience and makes your
outbound links safer, with zero effort from editors.

It is worth knowing exactly which links are affected. The module works on links that
pass through Drupal's link/theme layer — menu links, `#type => 'link'` render
elements, rendered link fields, and anything built with Drupal's Link API (including
links other modules generate). It does **not** rewrite raw `<a>` tags that are
hard-coded in body text, block markup, or Twig templates, because those never reach
the hook the module uses. The module has no settings form, no permissions, no
configuration, and no dependencies — the whole thing is a single alter hook.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no configuration and no admin page. Once the module is enabled, external
links across the site automatically open in a new tab with `rel="noopener"`. To
confirm it is working, view a page that contains a link to another site (for example
an external menu link) and inspect the rendered `<a>` tag — it should carry
`target="_blank"` and `rel="noopener"`.

If you ever need to change this behaviour — for instance to also add `noreferrer`,
or to exclude certain domains — that requires a small custom module implementing your
own `hook_link_alter()`; there are no built-in options for it.
