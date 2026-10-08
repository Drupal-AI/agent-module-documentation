# Configuration

Link attributes has no site‑wide settings form. You configure it **per field**, by
switching a Link field to the **Link (with attributes)** widget and then choosing
which attribute inputs editors should see. You do this on the entity's **Manage form
display** tab, so you can offer different attributes on different fields.

## Switch a Link field to the widget

1. Log in as a user with permission to administer the entity's fields and form
   display (an administrator by default).
2. Go to the entity's **Manage form display** tab. For a content type that is
   **Structure → Content types → [your type] → Manage form display**
   (`/admin/structure/types/manage/{type}/form-display`); other entity types (users,
   taxonomy terms, media, paragraphs) have the same tab.
3. Find your Link field and, in the **Widget** column, change it from **Link** to
   **Link (with attributes)**.
4. Click the **gear icon** at the end of that field's row to open the widget
   settings, then set the options below.

## Widget settings, field by field

- **Enabled attributes** — a set of checkboxes, one per available attribute. Tick
  only the attributes you want editors to be able to set on this field. The built‑in
  attributes are:
  - **id** — an HTML `id` anchor on the link.
  - **name** — the `name` attribute.
  - **target** — a select offering `_self` (same tab) or `_blank` (new tab); the
    classic "open in a new window" control.
  - **rel** — the `rel` attribute, e.g. `nofollow` or `noopener noreferrer` for SEO
    and security on external links.
  - **class** — one or more CSS classes, e.g. `button button--primary` to style a
    link as a button.
  - **accesskey** — a keyboard shortcut for the link.
  - **aria-label** — an accessible label for screen readers, useful on icon‑only
    links.
  - **title** — a `title` tooltip attribute.

  Modules can add further attributes as YAML plugins, and those appear here too.

- **Placeholder for the URL** — placeholder text shown in the empty URL input, to
  guide editors (for example an example address).

- **Placeholder for the link text** — placeholder text shown in the empty link‑text
  input.

- **Open attributes by default** — controls whether the attributes panel starts
  expanded. Leave it collapsed to keep the form tidy, or set it open if editors will
  set attributes frequently.

## Save and use

Click **Update** on the widget settings, then **Save** the form display. Now when an
editor edits this field, they see the link inputs plus a panel with exactly the
attributes you enabled. Whatever they set is stored with the link and rendered
automatically — a link marked `target="_blank"` will open in a new tab, a link given
a `class` picks up your styling, and so on, with no theme changes needed.

Because the enabled‑attributes choice is part of the form display, it travels with
your configuration and can be exported and deployed between environments like any
other config.
