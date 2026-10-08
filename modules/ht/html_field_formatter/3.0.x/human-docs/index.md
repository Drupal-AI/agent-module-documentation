# HTML Field Formatter — manual setup guide

**HTML Field Formatter** (`html_field_formatter`) adds one field formatter, simply
called **HTML**, that outputs the stored value of a text or string field as real
HTML markup on the entity display — instead of escaping it and showing the tags as
plain text. It is the reusable, configurable version of the old "just print the
field with `|raw`" trick.

Use it when a field already contains trusted HTML that you want rendered as-is: a
third-party embed code (video, map, social widget), a hand-authored snippet, inline
SVG or icon markup, or a pre-built HTML fragment. It applies to the field types
`text`, `text_long`, `text_with_summary`, `string`, and `string_long`, and works on
multi-value fields (each value is rendered as its own element).

The formatter has a single option, **Allowed tags**. When you leave it empty (the
default) the field value is rendered **verbatim, with no filtering and no
escaping** — whatever markup is in the field, including `<script>`, reaches the page
untouched. When you list one or more tags, the value is instead run through
Drupal's XSS filter so only the tags you named survive.

> **Security — read this before you wire it up.** With the default empty *Allowed
> tags*, output is completely unsanitized by design. Only point the HTML formatter
> at fields whose content comes from **trusted roles**: anyone who can edit such a
> field can inject stored script that runs for every visitor. If the field may be
> edited by lower-privileged or untrusted sources (imports, webforms, user
> profiles, remote feeds), set an *Allowed tags* whitelist so the value is filtered.
> XSS protection here is the site builder's responsibility, not the module's.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no settings page, so there is no separate configuration guide —
the one setting lives on the field's display and is covered in *How to use it*
below.

## Where it lives in the admin menu

There is no admin page of its own. You select the formatter per field on an
entity's **Manage display** tab, for example
**Structure → Content types → Article → Manage display**.

## How to use it

1. Go to the **Manage display** tab of the entity bundle that has the field
   (`/admin/structure/…/display`).
2. Find your text or string field and set its **Format** to **HTML**.
3. Click the settings cog. The one option is **Allowed tags** — a textarea, one
   HTML tag name per line.
   - **Leave it empty** to render the value exactly as stored, with no filtering.
     Choose this only for trusted-author fields.
   - **List tags** (for example `p`, `a`, `strong`, `em`) to keep only those tags
     and strip everything else. This is the safe choice for any field that might
     contain untrusted input.
4. Click **Update**, then **Save**.

The settings summary shows your allowed-tags list when one is set. Because it is a
normal formatter, you can apply it differently per view mode — for example raw HTML
in the full view and a plainer format in teasers.
