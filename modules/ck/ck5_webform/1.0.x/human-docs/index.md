# CKEditor 5 Webform — manual setup guide

**CKEditor 5 Webform** (`ck5_webform`) lets editors embed a **Webform** directly into
rich-text content. Instead of managing shortcodes or hand-written HTML snippets, it
adds a native CKEditor 5 widget: editors browse and select an active webform in a
modal, and a placeholder shows exactly where the form will appear. On the public site
a dedicated server-side filter turns that placeholder into a fully functional,
accessible Drupal Webform.

It bridges powerful form functionality and a friendly authoring experience. The
widget supports an AJAX modal browser to search active webforms without leaving the
page, live editor placeholders so editors can see the layout before saving, and
double-click editing to swap one form for another. Because the embedded webform
renders through the Webform system, it keeps the webform's own access rules and
handlers — the module itself has no access-control role. It depends on core
**CKEditor 5** and the contributed **Webform** module, and supports Drupal 10 and 11.

Setup is per text format: add the Embed Webform button to the toolbar and enable the
module's filter (which does the front-end rendering). If your format uses core's
*Limit allowed HTML tags* filter, you also need to allow the module's embed tag so the
placeholder survives filtering.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and the Webform dependency.

## Where it lives in the admin menu

There is no standalone settings page. You enable the widget per text format at
**Administration → Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`). Webforms themselves are managed under the Webform
module (**Structure → Webforms**).

## How to enable the widget in a text format

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the format your editors use (for example *Basic HTML* or *Full HTML*).
2. In the CKEditor 5 toolbar configuration, drag the **Embed Webform** icon up into
   the active toolbar.
3. In **Enabled filters**, enable the **CKEditor 5 Webform Embed** filter — this is
   what renders the form on the public site.
4. If the format uses **Limit allowed HTML tags**, add the module's webform embed tag
   to the allowed-tags list so the embed is not stripped.
5. Save the format.

Editors using that format can now click **Embed Webform**, pick a webform from the
modal, and see a placeholder in the editor. Double-click the placeholder to swap in a
different form.
