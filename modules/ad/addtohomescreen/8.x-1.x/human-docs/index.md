# Add to Homescreen — manual setup guide

**Add to Homescreen** (`addtohomescreen`) invites mobile visitors to add your site
to their device's homescreen, giving it an app-like icon and a more
PWA-flavoured feel. It uses the well-known cubiq *add-to-homescreen* JavaScript
library, which it attaches to your front-end pages, and shows an unobtrusive prompt
inviting the visitor to install the site.

A single admin settings form controls the prompt: its invitation text, how often
and when it appears, and its appearance. It targets mobile/handheld browsers on
both iOS and Android and needs no external service — everything runs client-side
from the bundled library.

It is a front-end UX enhancement with no access-control role of its own (it adds
one permission that gates its settings form). It works well alongside a web app
manifest if you are building a fuller PWA. It supports Drupal 8, 9, and 10.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form controlling the
   prompt text, timing, and appearance.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → Add to
Homescreen** (`/admin/config/user-interface/addtohomescreen`), gated by the
*administer add to homescreen* permission. The install prompt itself appears on
front-end pages for mobile visitors.
