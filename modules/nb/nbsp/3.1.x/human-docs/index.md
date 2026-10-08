# CKEditor Non-breaking space Plugin — manual setup guide

**CKEditor Non-breaking space Plugin** (`nbsp`) is a small tool that lets content
authors insert a non-breaking space (`&nbsp;`) into CKEditor 5 content with a
toolbar button or the **Ctrl+Space** keyboard shortcut. A non-breaking space
keeps two words on the same line — handy for a company name like "Acme Corp", a
number and its unit like "10 kg", or a title and a name you don't want split at a
line break.

Because a non-breaking space is invisible, the plugin highlights it in blue while
you edit, so you can actually see where you've placed one. Behind the scenes the
inserted character is stored as a small `<nbsp>` marker, and a companion text-
format filter ("Cleanup NBSP markup") converts that marker — plus any legacy
`<span class="nbsp">` from older content — into a real non-breaking space on
output. That keeps your stored markup clean and your rendered page valid.

The module has no settings page, no permissions, and no Drush commands. You turn
it on per **text format** by adding its toolbar button and enabling its filter,
which is all standard Drupal text-format configuration. It requires core's
**CKEditor 5** and **Editor** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You configure NBSP on each text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

Enable NBSP on a text format in three steps, on that format's configuration page
(`/admin/config/content/formats/manage/<format>`):

1. **Add the toolbar button.** In the CKEditor 5 toolbar configuration, drag the
   **Non-breaking space** button (item id `nbsp`) from *Available buttons* into
   the *Active toolbar*.
2. **Enable the filter.** Tick **Cleanup NBSP markup** in the format's *Enabled
   filters* list. This is what converts the stored `<nbsp>` marker into a real
   non-breaking space on output, so leave it on.
3. **Allow the tag (only if needed).** If the format has *Limit allowed HTML tags
   and correct faulty HTML* switched on, add `<nbsp>` to the allowed HTML tags so
   the marker survives filtering. If that filter is off, there's nothing to do.

**Save configuration.** Now, when editing content in that format, authors can
click the button or press **Ctrl+Space** to insert a non-breaking space (shown in
blue in the editor), and it renders as a proper `&nbsp;` on the published page.

To remove NBSP from a format later, just take the button off the toolbar and
disable the filter.

A good pattern is to enable it on **Full HTML** first, and add it to **Basic
HTML** only if you also whitelist the `<nbsp>` tag there.
