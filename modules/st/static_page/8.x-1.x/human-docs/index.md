# Static Page — manual setup guide

**Static Page** (`static_page`) lets you configure a node type so that one of its
text-area fields defines the *entire* HTML page — no theme, no sidebars, no Drupal
chrome. You paste the full source code of an HTML page into the field, save the
node, and the visitor gets back exactly that markup. It is the simplest way to
serve a hand-authored one-off page (a landing page, say) from inside Drupal while
bypassing the theme layer.

The problem it solves is a common one: sometimes you just want "a nice page with
some words" — a block of authored markup — and assembling it from fields and a
template is more machinery than the job needs. Static Page hands the whole page
body to an author instead. Any CSS or JavaScript the page needs goes directly into
that markup. The module depends only on core's Node module.

You configure it by dedicating a content type to static pages (one that has a
single text-area field) and telling the module which field holds the page source.
After that, adding a static page is just adding a node of that type: the title is
only used in the admin interface, and the text area holds the full HTML.

**Please read the security note carefully.** A content type configured as a static
page **bypasses Drupal's normal text filtering entirely**. Whatever text format
you attach to the field, the markup is only ever as safe as that format allows —
and if it is a permissive format like *Full HTML*, an author can inject arbitrary
markup, including `<script>`, which is a stored-XSS capability. Use a restricted,
filtered text format for anyone who is not a fully trusted author, and only grant
the ability to create static-page content types to people you trust.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, the Composer command,
   and enabling the module.
2. [Configuration](configuration/index.md) — dedicating a content type, choosing
   the field, and the security choice that comes with it.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Content authoring → Static
page** (`/admin/config/content/static_page`). There you pick which content types
act as static pages and, for each, which text-area field holds the page source.
