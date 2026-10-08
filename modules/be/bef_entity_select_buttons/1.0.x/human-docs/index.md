# BEF Entity Select Buttons — manual setup guide

**BEF Entity Select Buttons** (`bef_entity_select_buttons`) extends
[Better Exposed Filters](https://www.drupal.org/project/better_exposed_filters)
so that, in Views overviews, visitors can pick entity **bundles** with button
widgets instead of a plain select list. Filtering a listing by type becomes a row
of buttons — a nicer, more obvious exposed-filter UI.

This is a Views/exposed-filter usability enhancement and nothing more. It has no
content or access role of its own — the View's access rules still decide what a
visitor may see. You turn it on per exposed filter in the Views UI, alongside
Better Exposed Filters' other widget settings; there is no separate settings page.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

BEF Entity Select Buttons has no admin settings page. The button widget appears as
an option when you configure an exposed **bundle/type** filter on a View under
**Structure → Views**, once Better Exposed Filters is selected as that filter's
widget.

## How to use it

1. Enable the module (Better Exposed Filters must be enabled too — see
   [Installation](installation/index.md)).
2. Edit a View whose exposed filter lets visitors filter by entity bundle/type.
3. In that filter's Better Exposed Filters settings, choose the button widget this
   module adds.
4. Save the View. The bundle filter now renders as buttons instead of a select
   list.
