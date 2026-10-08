# Configuration

Cyrillic to Latin has a single, small settings form whose job is to switch the
on‑the‑fly script conversion on or off.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Cyrillic to Latin**, or
   navigate directly to `/admin/config/regional/cyrillic-to-latin`.

## Enable or disable conversion

The form lets you **enable or disable string conversion**. When enabled, text
that passes through Drupal's translation system (`t()`) and string/text field
values is converted from Serbian Cyrillic to Latin as pages render — and, if the
Address module is present, country names are converted too. When disabled, content
is shown exactly as stored.

Toggle the setting to match your site's script policy, then **Save**. The change
affects how content is rendered from that point on; you may want to clear caches
if converted output does not update immediately.

## Keep in mind

- Conversion is **display‑time only** — your stored content is untouched, so you
  can turn the feature off at any time and see the original Cyrillic again.
- Conversion runs in **one direction** (Cyrillic → Latin), which is the
  unambiguous one; there is no reverse conversion.
