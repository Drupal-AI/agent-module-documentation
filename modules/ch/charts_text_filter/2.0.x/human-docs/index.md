# Charts Text Filter — manual setup guide

**Charts Text Filter** (`charts_text_filter`) lets content editors insert charts
directly into a WYSIWYG field. It provides a **CKEditor 5 plugin** — a Drupal
Charts toolbar button — that opens a chart configuration form (from the
[Charts](https://www.drupal.org/project/charts) module) right inside the editor,
so an editor can build and preview a chart and drop it into the body text without
touching any markup. (An earlier version required hand‑editing the field source;
that approach is now discouraged.)

It is an authoring bridge, not a standalone feature: the actual chart rendering
comes from the Charts module, which must be enabled and configured with a default
library. This module depends on Charts plus Drupal core's **CKEditor 5**,
**Editor**, and **Filter** modules. There is no separate settings page — setup
happens on your text formats.

One security note worth knowing up front: because this turns authored content into
rendered charts, enable the filter only on **text formats that trusted editors
use**. Chart definitions are authored content, and the chart data is whatever the
editor supplies, so keep the feature off formats available to untrusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Charts and CKEditor 5.

There is **no dedicated configuration page** for this module. Setup is done on your
text format(s) — see "How to use it" below.

## Where it lives in the admin menu

There is no page of its own. You configure it on your text formats at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), and the Charts library defaults live at
**Configuration → Content authoring → Charts** (`/admin/config/content/charts`).

## How to use it

Set it up once per text format, then author as usual.

1. Make sure **Charts** is enabled and configured with a default library at
   `/admin/config/content/charts`.
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit the format you want (one that uses
   CKEditor 5, and one only trusted editors can use).
3. Drag the **Drupal Charts** icon from the available buttons into the **Active
   toolbar**.
4. Under the format's filter settings, tick the box to **enable Charts Text
   Filter**.
5. Save the text format.

Now, when editing a field that uses that format, click the **Drupal Charts** icon
in the toolbar. A configuration form opens where you build the chart (you can
preview it within the form) and then insert it into the WYSIWYG content.
