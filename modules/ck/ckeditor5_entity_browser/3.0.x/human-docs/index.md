# CKEditor Entity Browser — manual setup guide

**CKEditor Entity Browser** (`ckeditor5_entity_browser`) adds **entity browser
buttons to CKEditor 5's link dialog**, so when an editor inserts a link they can
search for and pick existing content instead of typing a URL by hand.

Linking to internal content normally means leaving the editor, finding the page,
copying its address, and coming back — a trip editors get wrong. The result is body
content littered with links to `/node/123`, links to the wrong page, and links to a
staging domain someone pasted once. An entity browser in the link dialog removes
the trip: search, select, done.

**One thing is worth checking against your setup**, because it decides whether this
is a convenience or a correctness feature: what the button stores. A browser that
inserts the *resolved URL* saves typing; one that inserts an *entity reference*
means the link keeps working when the page's path alias changes. Both help; only
the second fixes the underlying fragility. It also pairs well with modules that
rewrite stored `/node/123` links to their aliases at display time — the two address
opposite ends of the same problem. Note a current limitation: only canonical
entities can be inserted at this time.

The module depends on core's CKEditor 5 and the **Entity Browser** module, and it
works alongside other link-UI plugins such as Linkit. It runs on Drupal 10 and 11.
Which entity browsers appear in the link UI is configured per text format, walked
through in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Entity Browser.
2. [Configuration](configuration/index.md) — set up an entity browser view and
   enable it in the CKEditor 5 link UI per text format.

## Where it lives in the admin menu

There is no standalone settings page. Entity browsers are created and managed under
**Configuration → Content authoring → Entity browsers**, and you choose which of
them appear in the link UI per text format at **Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`) — see
[Configuration](configuration/index.md).
