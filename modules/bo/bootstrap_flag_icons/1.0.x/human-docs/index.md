# Flag icons Bootstrap CkEditor — manual setup guide

**Flag icons Bootstrap CkEditor** (`bootstrap_flag_icons`) adds two flag-icon
features to a multilingual Drupal site. First, it provides a **Bootstrap 5
dropdown language switcher** — a button that opens a list of your site's
available languages, each shown with its flag icon, so visitors can switch
language with a click. Second, it gives content editors a **CKEditor tool for
inserting flag icons** directly into their text.

Both features are about presentation, not permissions. The language switcher
simply reflects the languages you have already configured on the site; it does
not decide who can see what. If you have not set up multiple languages yet, the
switcher has nothing to switch between.

This is a niche, lightweight module: enable it, place the switcher block where you
want it, and turn on the CKEditor button in your text format's toolbar.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module has no central settings page. Its two pieces are enabled where those
kinds of things normally live:

- The **language switcher** is a block — place it under **Structure → Block
  layout** in the region you want (for example a header).
- The **flag-icon insert button** is a CKEditor tool — enable it in the toolbar
  of a text format under **Configuration → Content authoring → Text formats and
  editors**.

## How to use it

1. Make sure your site has more than one language configured (core's Language and
   Content Translation / Interface Translation modules), otherwise the switcher
   has nothing to show.
2. Place the **Bootstrap 5 flag-icon language switcher** block in a visible
   region via **Block layout**.
3. To let editors drop flag icons into content, edit a **text format**, and drag
   the module's flag-icon button into the CKEditor toolbar.
4. Use a Bootstrap 5 theme so the dropdown styling matches the rest of the site.
