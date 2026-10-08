# CKEditor Small Tag — manual setup guide

**CKEditor Small Tag** (`ckeditor_small_tag`) adds a single **Small** button to the
CKEditor 5 toolbar that wraps the selected text in an HTML `<small>` element. It behaves
just like the built-in Bold, Italic, or Strikethrough buttons — a one-click toggle — and is
the semantically correct way to mark fine print, legal disclaimers, footnotes,
attributions, and other de-emphasized text (rather than using a font-size hack).

The module is a thin, self-contained CKEditor 5 plugin. It declares one toolbar item and
registers `<small>` as an element the plugin provides, so when you add the button to a text
format, Drupal's CKEditor 5 filter integration automatically allows the `<small>` tag in
that format — no manual filter tweaking required.

There is no settings form, no permission of its own, no config schema, and no Drush
commands. It depends only on Drupal core's **CKEditor 5** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## How to use it

There is no admin settings form — you enable the feature by placing the **Small** button in
a text format's toolbar:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a format that uses **CKEditor 5** as its text editor (for example *Basic HTML*).
3. In **Toolbar configuration**, drag the **Small** button from *Available buttons* to the
   *Active toolbar*.
4. Save. (Editing text formats uses the core **Administer filters** permission, a
   restricted, trusted-admin permission.)

Because the plugin declares `<small>` as an element it provides, adding the button
automatically adds `<small>` to that format's allowed HTML tags (visible under *Limit
allowed HTML tags* in the format's filter settings). Removing the button removes the tag
from the auto-allowed set again.

Editors then select text and click **Small** to wrap it in `<small>`, or toggle it off the
same way — exactly like Bold or Italic. Enable the button only on the formats and roles that
should have it.
