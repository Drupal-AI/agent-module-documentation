# Search Tracking — manual setup guide

**Search Tracking** (`search_tracking`) logs the search terms visitors type into a
search form on your site, storing each keyword together with the visitor's IP
address and a timestamp, so administrators can review what people are searching
for. The collected data is displayed with a ready-made **View**, which you can
customise like any other view.

It works by watching a search form you describe to it. On the configuration page
you tell the bundled JavaScript how to find the search field — by the form's **ID**
or **class**, plus the input's **name** attribute (a URL parameter can also be
used). When a visitor searches, the JavaScript reads the entered term and sends it
to the module, which stores the keyword, IP address, and time in a dedicated
database table. You then build or customise the **Search Tracking** view under
Views to display the data. It requires **Drupal 8, 9, or 10** and has no module
dependencies of its own.

This module needs configuration before it tracks anything: you must enter the
correct form attributes, or nothing is captured (and a mistake in the attributes
produces an error). If those form details do not match your search form, no data
is recorded.

The module's stable release is **not covered** by Drupal's security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter the form attributes to track
   and build the display view.

## Where it lives in the admin menu

The configuration form is at **Configuration → Search and metadata → Search
Tracking → Form config** (`/admin/config/search/search-tracking/form-config`),
reachable by the administrator role. The data is displayed through Views under
**Structure → Views** (`/admin/structure/views`).
