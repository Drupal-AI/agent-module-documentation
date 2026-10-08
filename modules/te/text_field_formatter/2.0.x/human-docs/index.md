# Text Field Formatter — manual setup guide

**Text Field Formatter** (`text_field_formatter`) is a field formatter for plain
`string` fields that extends Drupal core's built‑in **String** formatter and adds
an optional HTML **wrapper tag** around the value, plus configurable **CSS
classes** and arbitrary **HTML attributes** on that wrapper. It lets you control a
text field's markup right from the *Manage display* screen, with no Twig template
override or custom formatter plugin.

Because it subclasses core's String formatter, it keeps all the standard behavior
— including the "Link to the referenced entity" option — and layers four extra
settings on top: which tag to wrap the value in (`div`, `h1`–`h6`, or `span`; the
`a` tag is deliberately disallowed to avoid clashing with the entity link), a list
of wrapper classes, freeform wrapper attributes, and an optional override for the
link label (with token support) when the value is linked to its entity.

Typical uses are giving a "subtitle" string field a semantic `<h2>`, wrapping a SKU
in a `<span class="sku">`, or attaching `data-*`/`id` attributes and utility
classes to a field for CSS or JavaScript targeting — all configured per bundle and
per view mode. Other modules can extend the list of available wrap tags (for
example to add `<p>`) through a small alter hook.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the settings keys
and the `hook_default_wrap_tags_alter()` hook — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Text Field Formatter has **no settings page of its own** (`configure: null`). It is
a formatter you select on a field's display, so you will work with it on a
bundle's **Manage display** tab — for example **Structure → Content types → *your
type* → Manage display**.

## How to use it

There is no global configuration; you use it by choosing it as a field's format
and setting its options there:

1. On a bundle's **Manage display** tab, find a **plain text (string)** field.
2. Set its **Format** to **"Text field formatter"**.
3. Click the gear to configure the options:
   - **Field wrapper** (`wrap_tag`) — the HTML tag to wrap each value in: `div`,
     `h1`–`h6`, or `span`. Leave it as *none* for no wrapper. (`a` is not offered,
     as it would conflict with the entity‑link feature.)
   - **Wrapper classes** (`wrap_class`) — one or more CSS classes for the wrapper,
     separated by spaces or commas.
   - **Wrapper attributes** (`wrap_attributes`) — extra HTML attributes, one per
     line in `attribute|value` form (for example `data-role|subtitle` or
     `id|main-subtitle`; the value is optional).
   - **Override link label** (`override_link_label`) — only used when the core
     **Link to the referenced entity** option is on; replaces the link text, and
     supports tokens resolved against the field's entity.
4. Save the display.

At render time each value is wrapped in your chosen tag with the given classes and
attributes; if you left the wrapper as *none*, the output is just the plain string
(exactly like core). Settings are stored on the entity view display like any
formatter, so they export with your configuration and can differ per bundle and
view mode.

**Extending the tag list:** developers can add or remove available wrap tags (such
as adding `<p>`) with `hook_default_wrap_tags_alter()` — see the
[`agent/`](../agent/start.md) docs.
