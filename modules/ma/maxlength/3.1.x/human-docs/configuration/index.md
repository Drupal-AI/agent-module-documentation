# Configuration

MaxLength has **no configuration form of its own**. Instead it attaches its settings
to individual field widgets, so you turn it on one field at a time, right where you
already manage how that field is edited.

## Open the field widget settings

1. Log in as a user who can administer the content type (an administrator by
   default).
2. Go to **Structure → Content types → *[your type]* → Manage form display**
   (`/admin/structure/types/manage/{type}/form-display`). You can also do this on any
   other fieldable entity — taxonomy terms, media, and so on.
3. Find the field you want to limit and click the **gear icon** on the right of its
   row to open the widget's settings.
4. Expand the **MaxLength Settings** section.

Which options appear depends on the widget. Supported widgets include plain text
fields (`string_textfield`, `string_textarea`), formatted text fields
(`text_textfield`, `text_textarea`), text‑with‑summary and key/value widgets (which
also get summary options), and the Link field (`link_default`, plus Linkit). Widgets
that aren't supported simply won't show the section.

## The settings

- **Maximum number of characters** — the character limit for the field's value. Set
  it to the length you want to enforce (for example `80` for a node title). Leave it
  at `0` or blank to disable the counter for this field. Must be a positive number.

- **Maximum length countdown message** — the text shown live beneath the field as the
  author types. Three placeholders are substituted in real time:
  - `@limit` — the maximum you set,
  - `@remaining` — how many characters are still available,
  - `@count` — how many characters have been typed.

  The default is *"Content limited to @limit characters, remaining:
  **@remaining**"*. Reword it to match your editorial voice if you like.

- **Enforce the maximum length (hard limit)** — a checkbox that decides the *mode*:
  - **Ticked** — a **hard limit**: the field physically blocks typing once the
    maximum is reached.
  - **Unticked** — a **soft limit**: the author can keep typing past the maximum, and
    the counter simply goes negative to show how far over they are.

- **Summary options** *(text‑with‑summary and key/value widgets only)* — a second pair
  of fields, **Maximum number of characters for the summary** and its own countdown
  message, so you can limit the summary independently of the main body.

## Save

Click **Update** on the widget settings, then **Save** at the bottom of the Manage
form display page. The **Manage form display** overview will show a short summary of
the active limit next to the field. Open a piece of content of that type and you'll
see the live countdown as you type.

Because these are widget third‑party settings, they export with your
`core.entity_form_display.*` configuration — so the limits you set here are
deployable to other environments like any other config.

> **Developers:** to make MaxLength available on a custom widget type, implement
> `hook_maxlength_widget_settings()` — see the sibling
> [`agent/`](../../agent/start.md) docs.
