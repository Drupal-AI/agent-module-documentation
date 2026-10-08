# Year — manual setup guide

**Year** (`year`) provides a field type that stores just a year — nothing else. It
saves the value as a compact unsigned integer, validates it against a
configurable minimum and maximum, and offers two ways to enter it: a plain text
box or a select-list dropdown. It is handy for things like "Year built", a
publication or copyright year, or a birth year, where a full date field would be
overkill.

The valid range is flexible. The minimum is a plain year (default 1900), and the
maximum can be either a specific year or a relative expression like `now` or
`+5 years`, resolved when the field is used — so you can allow "up to the current
year" or "up to five years ahead" without editing the field each year. A field
default value can be relative too.

An optional submodule, **Year Views** (`year_views`), adds a friendly exposed
dropdown filter for year fields in Views, so site builders can offer a curated list
of years instead of a free-text numeric filter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the Views submodule.

## How to use it

The field is configured like any other Drupal field — there is no separate admin
settings page.

1. On a content type (or any fieldable entity), go to **Manage fields** and **Add
   field**, choosing the **Year** field type.
2. On the field's settings, set:
   - **Min** — the earliest valid year (default 1900).
   - **Max** — the latest valid year: either a specific year, or a relative
     expression such as `now` or `+5 years`.
3. On **Manage form display**, choose the widget:
   - **Textfield** (`year_default`) — a simple text box that shows the allowed
     range in its description.
   - **Select list** (`year_select`) — a dropdown of every year in the range, with
     a **sort order** setting so you can list years ascending or descending
     (descending is handy so recent years appear first).
4. Optionally set a **Default year** on the field, which also accepts a relative
   expression like `now`.

On **Manage display**, the default formatter renders the stored year as plain
text. Submitted values are validated against your min/max range automatically.

### Importing and Views

- The field ships a **Feeds** target, so it can be populated during a Feeds import.
- Enable the **Year Views** submodule to add an exposed year **dropdown filter** to
  a View. Its dropdown range is configurable (also accepting relative expressions,
  defaulting to roughly `-30 years` to `+15 years`) with an ascending/descending
  order option.
