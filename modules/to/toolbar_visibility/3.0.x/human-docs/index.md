# Toolbar Visibility — manual setup guide

**Toolbar Visibility** (`toolbar_visibility`) removes Drupal's administration toolbar
on the themes (and, optionally, the domains) you choose. The classic use is keeping the
toolbar on your admin theme while making it disappear on the public front-end theme —
so logged-in editors browsing the live site don't get the admin chrome, and cached
anonymous pages don't render it.

It's a small, focused module: a single settings form lists every installed theme as a
checkbox, and on every page it simply doesn't render the toolbar when the active theme
is flagged. If you also run the contrib **Domain** module, the form gains a
multi-select so you can hide the toolbar on specific domains too.

To be clear about what this is: it's a **display** toggle, not access control. It just
stops the toolbar from being rendered on matching themes/domains — a user who never had
toolbar access wouldn't have seen it anyway. It depends on core's **Toolbar** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choosing the themes (and domains) to hide
   the toolbar on.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Toolbar Visibility**
(`/admin/config/toolbar-visibility`), gated by the module's own **Administer toolbar
visibility** permission.
