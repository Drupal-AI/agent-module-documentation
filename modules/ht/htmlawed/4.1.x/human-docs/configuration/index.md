# Configuration

htmLawed is configured **per text format**, not on a settings page of its own.
You enable the filter on a format and then tell it which HTML to allow.

## Turn on the filter for a text format

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** next to the format you want to protect (for example *Basic
   HTML*, *Full HTML*, or a custom format).
4. In the **Enabled filters** list, tick **htmLawed HTML filter/purifier**.
5. Optionally reorder filters under **Filter processing order** so htmLawed runs
   **last** (see the note at the end).
6. Scroll down to the **htmLawed** section under **Filter settings** to configure
   it, then **Save configuration**.

You can enable htmLawed on more than one format, and each format keeps its own
independent settings.

## The htmLawed settings

The filter has four fields:

### Config.

This is the heart of the filter — a set of htmLawed options written as
comma‑separated, quoted `key => value` pairs (PHP array syntax). It controls what
is allowed and denied. The default is:

```
'safe' => 1, 'elements' => 'a, em, strong, cite, code, ol, ul, li, dl, dt, dd, br, p', 'deny_attribute' => 'id, style'
```

That default allows only the listed tags, strips the `id` and `style`
attributes, and applies htmLawed's built‑in anti‑XSS ruleset. Common keys you can
add or change:

- **`safe => 1`** — turn on htmLawed's anti‑XSS behavior (drops `<script>`,
  `on*` event handlers, `javascript:` URLs, and similar). Recommended for any
  user‑facing format.
- **`elements => 'a, p, ...'`** — the whitelist of allowed tags. Supports htmLawed
  shorthand such as `* -script` (everything except script).
- **`deny_attribute => 'id, style, class'`** — attributes to strip everywhere.
- **`schemes => 'href: http, https, mailto; src: http, https'`** — restrict which
  URL protocols are permitted, per attribute.
- **`comment => 2`** — preserve HTML comments, which is needed to keep Drupal's
  `<!--break-->` teaser marker working.
- **`save_php => 1`** — protect `<?php … ?>` blocks from being altered (useful for
  documentation/code content). The blocks are preserved, not executed.
- **`keep_bad => 1..6`** — choose how disallowed tags are handled (stripped vs.
  neutralized).
- **`tidy => 1`** — pretty‑print / indent the cleaned‑up output.

The full list of options is in the bundled reference at `/admin/help/htmlawed`.

> The Config. string is evaluated as PHP array syntax. This form is controlled by
> the *Administer filters* permission.

### Spec.

An optional htmLawed "spec" string that constrains **attribute values per
element** — for example `table = border: 0-2; img = height: 100-300` to limit a
table's border or an image's height. Leave it blank if you don't need per‑element
value rules.

### Short tip / Long tip

Two pieces of help text shown to authors beneath the editor, describing what HTML
is allowed. The **Short tip** appears in compact filter‑tip listings; the **Long
tip** appears on the full filter‑tips page (and falls back to a generic message
if you leave it empty). These are plain text for humans — they do not affect
filtering.

## Save

Click **Save configuration**. The new policy applies the next time content in that
format is displayed.

## Filter order matters

htmLawed does not create links from URLs or convert newlines into paragraphs — it
only restricts and repairs HTML. So combine it with the filters that do those
jobs, and give htmLawed the **highest weight (run it last)** so it validates the
markup those earlier filters produce. If an earlier filter emits tags you want to
keep, remember to add them to your `elements` whitelist.
