# BEF HTML5 Date plugin — manual setup guide

**BEF HTML5 Date plugin** (`bef_html5_date`) adds an HTML5 date-input option to
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters).
With it, a Views exposed date filter can use the browser's own native HTML5 date
picker instead of a plain text input — so visitors get the familiar calendar
control their browser provides, and don't have to type a date in exactly the right
format.

This only shapes the exposed filter's input widget; it does not change which
results come back, and the View's own access rules still apply. There is no
settings page — you pick the HTML5 date option per exposed filter, in the Views
UI, in the Better Exposed Filters settings for that date filter.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BEF HTML5 Date plugin has no admin settings page. The HTML5 date option appears
when you configure an exposed **date** filter on a View under **Structure →
Views**, once Better Exposed Filters is selected as that filter's widget.

## How to use it

1. Enable the module (Better Exposed Filters must be enabled too — see
   [Installation](installation/index.md)).
2. Edit a View with a **date** filter exposed to visitors.
3. In the exposed filter's Better Exposed Filters settings, choose the **HTML5
   date** option.
4. Save the View. The date filter now uses the browser's native date picker.
