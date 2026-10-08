# Configuration

Choices has one settings page for the global mode and the library source, plus a
per-field widget you set on individual fields. This page covers both.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Choices**, or navigate directly to
   `/admin/config/user-interface/choices`.

## Settings, field by field

- **Use CDN** (`use_cdn`, default off) — when ticked, the Choices.js library is
  loaded from the jsDelivr CDN instead of your local `/libraries/choices.js/`
  copy. Leave it off if you self-host the library. Saving this toggle clears the
  relevant cache so the swap takes effect right away.
- **Enable globally** (`enable_globally`, default off) — the master switch for
  global mode. When off, only the field widget can enhance selects. When on, the
  three settings below appear (the form reveals them dynamically).
  - **CSS selector** (`css_selector`, default `select[multiple]`) — a list of CSS
    selectors, one per line or separated by whitespace, that Choices will attach
    to. For example `select#edit-type` or `.choices-select`. This is required when
    global mode is on. (Whitespace between selectors is collapsed into a
    comma-separated list at render time.)
  - **Include** (`include`, default *everywhere*) — where global mode runs:
    **everywhere**, **admin pages only**, or **front-end pages only**. Use this to
    improve the back-end UX without touching the theme, or vice versa.
  - **Configuration options** (`configuration_options`, default empty) — a JSON
    object of [Choices options](https://github.com/Choices-js/Choices#configuration-options)
    applied to matched selects, e.g.
    `{"removeItemButton": true, "searchFields": ["label"]}`. These merge over the
    library defaults. See the note on validation below.

Click **Save configuration** to apply.

## The Choices field widget

Instead of (or in addition to) global mode, you can enhance one specific field:

1. Go to the entity's **Manage form display** (for example **Structure → Content
   types → *(type)* → Manage form display**).
2. For a supported field, change its widget to **Choices**. Supported field types
   are **entity reference**, **List (text)**, **List (integer)**, and **List
   (float)** — anything that presents an options list.
3. Click the widget's cog and, if you like, enter a JSON **configuration options**
   object for that field only. It's validated the same way as the global one.

The widget works whether or not global mode is enabled — they are independent.

## How the JSON options merge

When several sources apply to the same select, options are combined in this order
(later wins on conflicts):

**per-field widget options → global settings options → Choices library defaults**

So a field's own widget options override the global ones, which override the
library defaults.

## A note on JSON validation

The **configuration options** field (both global and per-widget) is validated
only as *"is this a well-formed JSON object?"* — any syntactically valid JSON
object is accepted, and an empty value is fine (it just uses the defaults).
Individual Choices option names are **not** checked, so a typo in an option key
won't be flagged here; double-check option names against the Choices.js
documentation.

## Set config from the command line (optional)

```bash
ddev drush cset choices.settings enable_globally 1 -y
ddev drush cset choices.settings css_selector 'select[multiple], .choices-select' -y
ddev drush cset choices.settings include 2 -y   # 2=everywhere, 0=admin only, 1=front-end only
ddev drush cset choices.settings use_cdn 1 -y
```
