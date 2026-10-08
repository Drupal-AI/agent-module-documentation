# Configuration

IntlDate is configured by creating one or more **date format** configuration
entities, then applying them to date fields or calling them from Twig. Because they
are config entities, the formats you create export and deploy like core's date
formats.

## Open the admin UI

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default — all IntlDate routes are gated by this permission).
2. Go to **Configuration → Regional and language → IntlDate**, or navigate directly
   to `/admin/config/regional/intl-date-time`.

## Create an ICU date format

1. On the IntlDate admin page, add a new date format.
2. Give it a **name** (a human label) and a machine name — this is how you'll pick
   it later on a field or reference it in Twig.
3. Define the **ICU pattern** for the format. ICU pattern components are richer than
   core's `date()` patterns and are what let the format adapt per locale — the ICU
   date/time pattern reference documents the available components
   (<https://unicode-org.github.io/icu/userguide/format_parse/datetime/>).
4. Save. The format is now available site‑wide as a reusable, named format.

Create as many as you need — for example a long date, a short date, and a
month‑and‑year format.

## Apply a format to a date field

1. Go to the **Manage display** tab of the content type (or other entity) that has
   the date field.
2. Set the date field's **formatter** to the IntlDate formatter, and choose the ICU
   date format you created.
3. Save. The field now renders in the correct shape for each language.

## Format a date in Twig

IntlDate provides a Twig function so templates can format a date value directly with
one of your ICU formats — useful in custom templates, newsletters, or anywhere a
field formatter doesn't apply. Reference the date value and the format you defined,
and the output follows the visitor's locale.

## Verify it worked

Switch the site (or a page) between languages and confirm the same date renders
appropriately for each — localized month names, the locale's own ordering, and, if
relevant, a non‑Gregorian calendar. That per‑language correctness is exactly what
IntlDate adds over core's fixed date patterns.
