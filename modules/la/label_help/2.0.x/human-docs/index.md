# Label Help — manual setup guide

**Label Help** (`label_help`) lets you add a line of guidance that appears directly
**below a field's label**, above the input, on entity edit forms. Drupal's built-in
field description always sits *underneath* the input, which is easy for an editor to
miss. Label Help puts the explanation right where the eye lands first — next to the
label — so instructions like "Enter the event's public title" or "Do not enter
personal data" are read before the field is filled in.

You configure the help text **per field**, and there is no separate admin page: a
**Label help message** textarea is added to each field's normal settings form. Type
your guidance there, save the field, and it appears on every edit form that uses the
field. Clearing the textarea removes it again. The value is stored on the field's
configuration, so it exports and deploys with the rest of your config, and it can be
translated per language.

Drupal's form widgets vary enormously — a plain textfield, a set of checkboxes, a
datetime with several sub-inputs, an autocomplete, a multi-value table — so placing
help text "next to the label" is trickier than it sounds. Label Help handles this
with a cascade of around eighteen widget-specific rules that pick the right insertion
point for each kind of element, with a sensible fallback. It renders the help through
a themeable element with dedicated styling for the Seven, Claro, and Gin admin
themes, so it looks at home wherever you use it.

Developers get a second way in: a `#label_help` Form API property that sets the same
help text on any element in a form you build in code, no field configuration needed.
The module has no admin settings page, no permissions, and no Drush commands, and
depends only on Drupal core. It bundles a small **label_help_test** submodule (a demo
content type) for exercising the placements.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the `#label_help` property
and debug flags — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adding help text per field, where it is
   stored, theming, and the debug options.

## Where it lives in the admin menu

Label Help adds **no page of its own**. You set help text on each field's edit form —
for a content-type field that is **Structure → Content types → *(your type)* → Manage
fields → Edit**. See [Configuration](configuration/index.md).
