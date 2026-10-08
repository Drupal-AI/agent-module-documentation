# Configuration

Smart Date Range Formatter is configured **per field display**, not from a central
settings page. Everything below happens on the **Manage display** tab of whichever
entity holds your Date Range field.

## Assign the formatter to a field

1. Log in as a user with permission to administer the entity's display (an
   administrator by default).
2. Go to the content type (or other entity) that has your **Date Range** field —
   for a content type this is **Structure → Content types → [your type] → Manage
   display**.
3. Find the Date Range field in the list and, in the **Format** column, choose
   **Smart Date Range**.

## The two date formats

Click the gear/cog icon beside the field to open the formatter's settings. Smart
Date Range Formatter gives you two independent date formats so you can control how
each situation reads:

- **Same-day format** — used when the range's start and end land on the same
  calendar day. Because the date only needs to appear once here, this is where you
  decide how the single date and the two times are presented (for example
  *January 15, 2026, 9:00 AM – 5:00 PM*).
- **Different-day format** — used when the range spans more than one day, so both
  ends are shown in full (for example *January 15, 2026 – January 18, 2026*).

Both formats respect the site timezone and each viewer's personal timezone
setting, and they follow the active interface language, so the same field renders
correctly for a multilingual audience.

## Save

Click **Update** on the formatter settings, then **Save** at the bottom of the
Manage display page. Reload a piece of content that uses the field to see the
formatted range.

## Theming (optional)

Output is rendered through a small Twig template, `smart-daterange.html.twig`, and
the module ships minimal CSS. If you want to restyle the range, override that
template and the CSS in your own theme — no configuration change is required for
that.
