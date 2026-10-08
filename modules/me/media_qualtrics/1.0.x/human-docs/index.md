# Media Qualtrics — manual setup guide

**Media Qualtrics** (`media_qualtrics`) lets you embed a Qualtrics survey or form
directly on a Drupal page. Editors simply paste the survey's URL into an ordinary
text field, and the module renders it as a responsive, auto-resizing `<iframe>` —
no bespoke media type or hand-written embed code required.

It works as a **field formatter** built on the Media Remote module. You add the
"Remote Media - Qualtrics" formatter to any plain string field, and whenever that
field holds a Qualtrics URL it becomes an inline survey. The embed grows and shrinks
with the survey content (Qualtrics posts height changes back to the page and a small
JavaScript resizer adjusts the iframe), and there is a graceful "view it on
qualtrics.com" fallback link for browsers that block the frame.

For safety, the module only renders URLs that match an **allowed-hosts** list you
control. By default that is `https://qualtrics.com`, but you can add your own
Qualtrics vanity domains. Any URL that doesn't match an approved host is silently
skipped, so editors can't turn the field into an arbitrary external iframe. If you
run the CSP (Content Security Policy) module, Media Qualtrics also adds your allowed
hosts to the `frame-src` directive automatically so the embeds aren't blocked.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull
   in Media Remote, and enable it.
2. [Configuration](configuration/index.md) — the allowed-hosts settings form, the
   only settings the module has.

## How to use it

1. **Add a text field** to hold the survey URL. On the content type (or other
   entity) go to **Manage fields**, add a plain **Text (plain)** field (a `string`
   field), and save.
2. **Apply the formatter.** On the same entity's **Manage display** tab, set that
   field's format to **Remote Media - Qualtrics** and save.
3. **Approve the host** if you use a custom Qualtrics domain — see
   [Configuration](configuration/index.md).
4. **Create content.** Paste a Qualtrics survey link (for example a
   `/jfe/form/…` or `/se/?SID=…` URL) into the field and save. The page now shows
   the survey inline as an auto-resizing iframe.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Qualtrics settings**
(`/admin/config/media/qualtrics`). The formatter itself is applied on each entity's
**Manage display** screen under **Structure**.
