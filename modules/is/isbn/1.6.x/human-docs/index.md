# ISBN — manual setup guide

**ISBN** (`isbn`) adds a dedicated **ISBN field type** to Drupal for storing,
validating, and formatting book identifiers — both the older 10-digit ISBN-10 and
the current 13-digit ISBN-13. It's the natural building block for a library
catalog, a bookstore's product data, or any content type that needs to record a
book's identifier reliably.

The field does three useful things. It **validates** what editors type, rejecting
anything that isn't a well-formed ISBN right on the form, so bad data never gets
saved. It **normalizes** the value on save by stripping hyphens, spaces, and other
punctuation, so `978-0-13-468599-1` is stored as `9780134685991` — which keeps
lookups and de-duplication consistent no matter how someone typed it. And it can
**format** the value for display, running it back through proper hyphen grouping
so readers see a nicely punctuated ISBN.

You use it entirely through Drupal's normal Field UI: add an ISBN field to any
entity bundle (content type, media type, taxonomy term, Commerce product, and so
on), and pick a display formatter. There is **no settings page**, no permissions,
and nothing site-wide to configure. Under the hood it relies on the
`nicebooks/isbn` PHP library (a hard requirement Composer installs for you), and
it also ships a **Feeds** target so ISBN fields can be mapped during a Feeds
import, plus a service developers can call to validate, format, clean, and convert
ISBNs in their own code.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `nicebooks/isbn` library) and enable the module.

## Where it lives in the admin menu

Nowhere on its own — this module has no settings page. You work with it in the
**Field UI** when managing an entity bundle's fields, for example **Structure →
Content types → *(type)* → Manage fields**.

## How to use it

### Add an ISBN field

1. Go to the bundle you want (for example **Structure → Content types → Book →
   Manage fields**) and click **Create a new field**.
2. Choose the **ISBN** field type (it's in the *General* category).
3. Give it a label and machine name, and save the field and storage settings.

The field uses a single plain-text input (a 20-character widget) — there are no
widget settings to fiddle with. Editors just type the ISBN; the module cleans and
validates it automatically.

### Choose how it displays

On the bundle's **Manage display** tab, pick one of the two formatters for your
ISBN field:

- **Non formatted value** (`isbn_default`) — shows the stored digits exactly as
  saved.
- **ISBN formatted value** (`isbn_formatted_formatter`) — runs the value through
  the library's formatter to insert proper hyphen grouping for a readable display.

### What happens when content is saved

When an editor submits the form, the module first validates the ISBN and blocks
the save with a form error if it's invalid. If it's valid, it strips every
non-alphanumeric character before storing, so only the bare digits (and a trailing
`X` check digit, where applicable) are kept.

### For developers

All the ISBN logic is available through the `isbn.isbn_service` service, which
exposes `format()`, `isValidIsbn()`, `convertIsbn10to13()`, `convertIsbn13to10()`,
and `cleanup()` — handy for validating or converting ISBNs in custom forms, REST
handlers, or migrations. The field's validation constraint (`IsbnValidation`) can
also be applied to other string properties if you need ISBN validation outside the
field type itself.
