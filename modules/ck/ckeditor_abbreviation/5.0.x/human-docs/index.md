# CKEditor Abbreviation — manual setup guide

**CKEditor Abbreviation** (`ckeditor_abbreviation`) adds an **Abbreviation** button
to the CKEditor 5 toolbar (and a matching right-click context-menu item) so content
editors can wrap selected text in an `<abbr>` tag with a `title` explanation. The
result is an accessible tooltip — hover over "HTML" and readers see "HyperText
Markup Language" — produced through a guided dialog instead of hand-typing tags in a
source view.

It is essentially a pure CKEditor 5 plugin: the only PHP in the module is a help
hook. Selecting text and clicking the button opens a small balloon dialog with two
fields — the abbreviation text and its title/explanation. Clicking inside an existing
`<abbr>` and reopening the dialog (or choosing "Edit Abbreviation" from the context
menu) lets you edit it; clearing the title drops the `title` attribute, and clearing
the abbreviation untags the text entirely.

There is no settings form, no permissions, and no configure route. You turn the
feature on the same way you enable any CKEditor 5 button: add it to a text format's
toolbar under **Text formats and editors**, and make sure the format's HTML filter
allows the `<abbr title>` markup so the tooltips survive filtering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no dedicated admin page. You configure it through core's text-format
settings at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

**Enable the button on a text format:**

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit a format whose editor is **CKEditor 5** (for example *Full HTML*).
3. In **Available buttons**, drag the **Abbreviation** button into the **Active
   toolbar**.
4. If the format uses the **Limit allowed HTML tags and correct faulty HTML** filter,
   make sure `<abbr>` — and the `title` attribute on it, written as `<abbr title>` —
   is in the allowed tags, so the tooltip is not stripped out on save.
5. Save.

**Use it while editing:**

- Select some text, click **Abbreviation**, and fill in the abbreviation text and
  its title/explanation in the balloon dialog.
- To edit an existing one, put the cursor inside the `<abbr>` and click the button
  again, or right-click and choose **Edit Abbreviation**.
- Clear the **title** field to keep the text but drop the tooltip; clear the
  **abbreviation** field to untag it.

Enabling the button writes it into the format's editor configuration
(`editor.editor.<format>` → `settings.toolbar.items`), and the allowed markup lives
in the format's filter configuration — both of which are exported with your config
for deployment.
