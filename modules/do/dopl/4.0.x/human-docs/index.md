# Drupal.org project link filter — manual setup guide

**Drupal.org project link filter** (`dopl`) is a tiny but handy text‑format
filter that turns short shorthand into proper links to Drupal.org projects. If you
blog about Drupal or mention modules in forum posts and documentation, you know
the small friction of linking to a project page every time. With this filter you
simply write something like `views.module` and it renders as a link to the Views
project page (`https://drupal.org/project/views`).

Several equivalent shorthands are supported for ease of reading and writing:
`name.module`, `name.theme`, `name.translation`, `name.installprofile`, and
`name.project`.

There is a nice refinement when core's **Update Manager** (`update.module`) is
enabled: the filter uses it to fetch the *real* project title, so instead of a
link that reads "dopl.module" you get one that reads "Drupal.org project link
filter." If a named project does not actually exist, the filter simply leaves the
text alone. With Update Manager disabled, the filter links every matching pattern
it finds regardless of whether the project really exists.

It depends only on core's **Filter** module, runs on Drupal 9.3, 10, and 11, and
is enabled per text format. It is currently in maintenance‑fixes‑only status,
seeking a co‑maintainer, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings form** for this module. You "configure" it by
enabling its filter on the text formats where you want it — done on the standard
core **Text formats and editors** page, described below.

## Where it lives in the admin menu

The filter is turned on per text format at **Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`). Edit a format and
enable the Drupal.org project link filter in its list of filters.

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors** and edit
   the text format your authors use (for example *Basic HTML* or *Full HTML*).
2. In the **Enabled filters** list, tick the Drupal.org project link filter.
3. Check the **filter processing order** so the filter runs at a sensible point
   relative to other filters, then save.
4. Now, in content using that format, write shorthand such as `views.module` or
   `pathauto.project` and it will render as a link to the matching Drupal.org
   project. With Update Manager enabled, the link text becomes the project's real
   title.
