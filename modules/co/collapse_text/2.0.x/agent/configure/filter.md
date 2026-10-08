# Configure the Collapsible text blocks filter

There is no dedicated settings page; the `configure` route is core's filter overview
(`admin/config/content/formats`, route `filter.admin_overview`). You enable and tune the filter per
**text format**.

## Enable on a format

1. Edit a format, e.g. `admin/config/content/formats/manage/full_html`.
2. Check **Collapsible text blocks** under *Enabled filters*.
3. Under **Filter processing order**, drag it **below (after)**:
   - *Limit allowed HTML tags* (`filter_html`) — required, or section HTML escapes the restriction.
   - *Convert line breaks into HTML* (`filter_autop`) — recommended.
   - Any HTML corrector (`filter_htmlcorrector`), `media`, `entity_embed` — known to conflict; run collapse_text after them.

Drush example (add the filter to an existing format):

```php
// drush php:eval
$fmt = \Drupal\filter\Entity\FilterFormat::load('full_html');
$fmt->setFilterConfig('filter_collapse_text', [
  'status' => TRUE,
  'weight' => 20, // heavier than filter_html / filter_autop
  'settings' => ['default_title' => 'Click to expand', 'form' => TRUE],
])->save();
```

## Settings keys (schema `filter_settings.filter_collapse_text`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `default_title` | string | "Click here to expand or collapse this section" | Title used when a section has no `title=` and no heading to borrow. Required (may not be empty). |
| `form` | bool | `1` (true) | Wrap each generated group in an empty `<form>` so `<details>` validates as HTML. Turn off to emit a bare `<div>` wrapper. |

## Authoring syntax (reference)

- `[collapse]…[/collapse]` — collapsible section (open by default).
- `[collapsed]…[/collapsed]` — alias for `[collapse collapsed]…` (starts closed).
- Attributes: `title="…"`, `class="c1 c2"`, `collapsed="collapsed"` (order: `collapsed` first if unquoted).
- `<collapse …>` angle-bracket form is rewritten to `[collapse …]`.
- Escape a literal marker with a leading backslash: `\[collapse` renders as `[collapse` (first backslash stripped).
- Per-text-area overrides: `[collapse options form="noform" default_title="…"]` (only the first `options` tag is read; applies to the whole field).
- Untitled section: the filter lifts the first `<h1>`–`<h6>` as the title and removes that heading from the body.

## Sanitization / XSS responsibility (by design)

This is a `TYPE_TRANSFORM_IRREVERSIBLE` filter. Section **titles** are hardened
(`htmlspecialchars(..., ENT_QUOTES)`), but section **body** content is passed through
`Markup::create()` — i.e. marked already-safe and not re-filtered. The filter therefore relies on
running *after* the format's own sanitizing filters (*Limit allowed HTML tags*). Practical rule: only
enable Collapse Text on formats that already restrict HTML (or that are restricted to trusted roles),
and always keep it ordered after `filter_html`. If it runs before HTML restriction, an author could get
unfiltered markup inside a section. This is standard Drupal text-format filter-ordering hygiene, not a
module vulnerability.
