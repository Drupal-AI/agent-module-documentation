# Create and translate — manual setup guide

**Create and translate** (`create_and_translate`) adds a second save button to the
node form that saves the node and then takes the editor **straight to its Translate
tab**, instead of landing on the freshly saved node. On a multilingual site the step
after creating content is almost always translating it, and the default path there —
save, read the confirmation, find the Translate tab, click it — is three interactions
and a page nobody wanted to look at, repeated for every piece of content. This module
removes them.

It is a small ergonomic change with a real effect when a team produces content in
several languages every day: invisible when it works, immediately missed when it is
gone. Editors who are **not** translating simply use the normal Save button as before.

On Drupal 8 and later there are **no settings** — the button appears on the node form
once the module is enabled (the older Drupal 7 line had a per-content-type settings
form and role permissions, but this version does not). The dependency list is a little
broader than the feature implies: it requires **Content Translation**, **Language**,
**Node** and **Taxonomy**, so enabling it will pull in Taxonomy even on a site that
doesn't otherwise use it — worth knowing before you install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   alongside its multilingual dependencies.

There is **no configuration page** for this module on Drupal 8+ — it has no settings
form. Its behaviour is described below.

## How to use it

1. Make sure your site is multilingual and the content type you're editing is set up
   for translation (under **Configuration → Regional and language → Content language
   and translation**).
2. Create or edit a node. Alongside the usual **Save** button you'll see the module's
   extra save-and-translate button.
3. Click it to save the node and land directly on its **Translate** overview, ready to
   add translations — skipping the confirmation page and the hunt for the Translate
   tab.

Editors who don't need to translate can keep using the normal **Save** button.
