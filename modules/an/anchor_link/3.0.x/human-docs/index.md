# CKEditor Anchor Link — manual setup guide

**CKEditor Anchor Link** (`anchor_link`) adds an "Anchor link" button and an
improved link dialog to CKEditor 5, letting content editors create named anchors
inside body text and link to them. Out of the box, CKEditor 5 in Drupal can link to
URLs but cannot place a named anchor or jump to a specific spot on the same page;
this module fills that gap, which is exactly what you need for in-page navigation,
tables of contents, "back to top" links, and deep-linking to a section of a long
article.

The module bundles the `vardot/ckeditor5-anchor-drupal` CKEditor 5 plugin and wires
it into Drupal's text-format configuration. Once enabled, you add the **Anchor
link** button to a text format's toolbar; editors can then insert a named anchor
(rendered as `<a id="name" class="ck-anchor">`) and create links that point to it.
The module also registers the extra HTML attributes it needs (`id`, `target`,
`rel`, and the `ck-anchor` class) so Drupal's "Limit allowed HTML tags" filter
permits them automatically.

Because the feature is configured per text format, you can enable it on Full HTML
while leaving Basic HTML plain, and different formats can opt in or out
independently. The module also ships a CKEditor 4-to-5 upgrade plugin (so sites
migrating from the old anchor button keep working) and an optional **Linkit**
matcher so anchor links are recognized by Linkit's autocomplete.

CKEditor Anchor Link depends on core's **CKEditor 5** (`ckeditor5`) and **Editor**
(`editor`) modules, plus the `vardot/ckeditor5-anchor-drupal` JavaScript library
that Composer installs for you. It has no admin settings page of its own — you
configure it on each text format.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its CKEditor 5
   library with Composer, then enable it.

## Where it lives in the admin menu

There is **no dedicated settings page**. You enable the feature per text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) — edit a format (for example *Full HTML*) and add
the Anchor link button to its CKEditor 5 toolbar.

## How to use it

To turn the anchor button on for a text format:

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format you want (for example `full_html`).
2. Make sure **Text editor** is set to **CKEditor 5**.
3. In the toolbar configurator, drag the **Anchor link** button from *Available
   buttons* up into the *Active toolbar*.
4. Save the format.

If the format uses the **Limit allowed HTML tags** filter, the module adds the tags
and attributes it needs automatically (`<a id>`, `<a target>`, `<a rel>`, and
`<a class="ck-anchor">`), so you do not have to edit the allowed-tags list by hand.

Editors now get an **Anchor link** button in that editor. They use it to drop a
named anchor at a point in the text, and to create links that jump to any anchor on
the same page — the basis for a manual table of contents, FAQ question-to-answer
links, or "back to top" navigation. Named anchors render with the `ck-anchor` class,
which drives a small visible marker in the editor via the module's bundled CSS.

If you also use the **Linkit** module, you can add this module's anchor matcher to a
Linkit profile at **Configuration → Content authoring → Linkit**
(`/admin/config/content/linkit`) so anchor links show up in Linkit autocomplete. And
if you are migrating a site from CKEditor 4, the module's upgrade plugin keeps
existing anchor buttons working through the standard text-format upgrade — no extra
action needed.
