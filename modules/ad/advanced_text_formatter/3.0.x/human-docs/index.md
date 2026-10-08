# Advanced Text Formatter — manual setup guide

**Advanced Text Formatter** (`advanced_text_formatter`) adds a single, flexible
field formatter called **Advanced Text** to your site. A "formatter" is the thing
that decides how a field's value is displayed, and this one gives you a lot of
control in one place: you can trim long text to a length (with an ellipsis and
word-boundary awareness), show a field's summary when it has one, run token
replacement, choose exactly how HTML markup is handled, and optionally wrap the
value in a link to its entity. It saves you from writing a custom formatter just
to truncate or re-filter existing text.

The formatter works on the common text and string field types — `string`,
`string_long`, `text`, `text_long`, and `text_with_summary`. Because it is a
formatter, there is **no global settings page**: you turn it on and tune it
per field, on an entity's **Manage display** page (or inside a View). Enabling the
module simply makes the *Advanced Text* option available in the format drop-down;
nothing changes until you select it for a field.

Its only dependencies are Drupal core's **Text** and **Filter** modules, and it
runs on Drupal 8, 9, 10, or 11. Note that the 3.0.x line is a release candidate
(`3.0.0-rc2`). It provides no submodules, permissions, services, or Drush
commands — it is deliberately just one formatter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the exact setting keys,
their defaults, and the drush recipe to set them — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — select the formatter on a field and
   set every option, field by field.

## Where it lives in the admin menu

There is no dedicated admin page. You use the formatter from any entity's **Manage
display** screen — for example **Structure → Content types → Article → Manage
display** (`/admin/structure/types/manage/article/display`) — by setting a text
field's **Format** to *Advanced Text* and clicking its gear icon to adjust the
settings. It also appears as a field formatter option inside Views.

## How to use it

On a Manage display page, pick **Advanced Text** in a text field's format column,
then open its settings to trim the output, choose a markup filter, enable summary
or token replacement, and optionally link to the entity. Because the settings are
per field and per view mode, you can, for example, trim the body to 300 characters
in a teaser view while showing it in full elsewhere. The full walkthrough is on the
[Configuration](configuration/index.md) page.
