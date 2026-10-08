# CKEditor InfoCard — manual setup guide

**CKEditor InfoCard** (`ckeditor_infocard`) adds an InfoCard button to CKEditor 5.
An InfoCard is essentially an inline version of an accordion: it wraps a span of
text so that extra information can be tucked away and revealed, with default
styling provided out of the box. It gives editors a lightweight way to add
expandable in‑line detail inside rich text without building a full accordion or
custom markup. The module is a fork of CKEditor Abbreviation, adapted for this
in‑line card behavior.

It depends on core CKEditor 5 and works on Drupal 10 and 11. There is no settings
page — the plugin is enabled per text format, and you must remember to turn it on
in the text‑editor settings before the button appears. The module does not define
any permission of its own — who can use the button is governed by core's existing
text‑format and editor permissions.

Note this is a minimally maintained module and the maintainer flags that the
WYSIWYG editing experience still has rough edges. Test it against your content
before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You turn the button on per
text format, described under "How to use it" below.

## How to use it

Add the InfoCard button to each text format where you want it:

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Click **Configure** next to a format that uses CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **InfoCard** button from the
   *Available buttons* tray into the *Active toolbar*.
4. Make sure the format's **Allowed HTML tags** permit the InfoCard `<span>`
   markup — the `class="js-infoCard"` class and the `data-content` attribute — so
   it survives filtering.
5. Click **Save configuration**.

Which roles can use the button follows from who you already allow to use that text
format (core's text‑format permissions); the module adds no permission of its own.
When editing content in the format, select some text and click the InfoCard button
to turn it into an inline card.
