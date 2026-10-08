# Configure a view to render attachments as tabs

There is **no admin settings form** for this module. Everything is configured on the view itself,
through the display extender's option group. Two things must be true: (1) the extender is registered
in Views' global settings, and (2) the extender is `enabled` on the parent display and on each
attachment you want to become a tab.

## Step 0 — register the display extender (required, and not automatic)

The extender only becomes selectable/instantiable once its id is in
`views.settings:display_extenders`. The module *ships* an install hook meant to add it, but the
function in `views_attachment_tabs.install` is named `views_attachment_tabs_views_install()`
(an extra `_views`), so it does not match `hook_install` for this module and never runs — on a fresh
install `views.settings:display_extenders` stays empty. Enable it one of two ways:

- UI: **Structure → Views → Settings → Advanced**, tick **"Views attachment tabs"** under
  *Display Extenders*, save.
- Drush/config: add `views_attachment_tabs_extender` to the list, e.g.

```bash
ddev drush cget views.settings display_extenders          # inspect current list
# then set it (example when the list is otherwise empty):
ddev drush cset views.settings display_extenders.0 views_attachment_tabs_extender -y
ddev drush cr
```

Uninstalling the module removes the id again (`views_attachment_tabs_uninstall` — note this hook is
named correctly and *does* run).

## Step 1 — the option group on each display

With the extender registered, editing a view shows an **"Attachment tabs"** option group (middle
column, `second` column) on any display that **uses attachments** (page, block, feed, …), and an
**"Attach as tab"** summary under the *Attachment settings* of each **attachment** display. Both open
the same form (form-state `section` = `views_attachment_tabs`) with these fields:

| Field | Option key | Type | Default | Notes |
|---|---|---|---|---|
| Enable | `enabled` | checkbox | `FALSE` | Must be on for the display to participate. |
| Use replacement tokens from the first row | `tokenize` | checkbox | `FALSE` | Enables Views/Twig token replacement in the title. |
| Tab title | `title` | textfield | `''` | Shown on the tab button. Falls back to the literal "Tab" when empty. Supports global tokens always, and per-row field/argument Twig tokens when `tokenize` is on. |
| Tab weight | `weight` | number | `0` | −100…100; sorts both the tab button and its panel. |

The `title`/`weight`/`tokenize` fields are `#states`-hidden until *Enable* is checked.

## Step 2 — build the view

1. Create a view with a display that accepts attachments (e.g. **Page** or **Block**).
2. On that parent display, open **Attachment tabs**, check **Enable**, set a **Tab title** (this
   becomes the first/main tab), **Apply**.
3. Add an **Attachment** display; set its **Attachment settings → Attach to** to the parent display.
4. On the attachment, open **Attach as tab**, check **Enable**, give it a **Tab title**, **Apply**.
5. Repeat 3–4 for each attachment, then **Save**.

Tabs are ordered by `weight` (then array order); the parent/main view is one of the tabs (flagged
`is_main_view`). A tab is silently skipped at render time if it has no content or no title (guards a
half-configured view in preview).

## Where the config lives

Per-display options are stored inside the view config entity at:

```yaml
# views.view.<id> → display.<display_id>.display_options.display_extenders.views_attachment_tabs_extender
enabled: true
title: 'My tab'
weight: 0
tokenize: false
```

Schema: `views.display_extender.views_attachment_tabs_extender`
(`config/schema/views_attachment_tabs.views.schema.yml`) with keys `enabled` (boolean),
`title` (label), `weight` (integer), `tokenize` (boolean).

## Theme note

The base template ships **no styling or interactivity**. After enabling the extender you must supply
theme markup: turn on `views_attachment_tabs_bootstrap` (Bootstrap themes) or
`views_attachment_tabs_olivero` (Olivero), or implement
`hook_preprocess_views_view_attachment_tabs()` — see [../hooks/preprocess.md](../hooks/preprocess.md).
