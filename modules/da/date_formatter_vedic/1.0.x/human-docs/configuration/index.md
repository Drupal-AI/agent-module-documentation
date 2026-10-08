# Configuration

Vedic Date Formatter has a single settings form. You use it to choose which
character triggers the muhūrta substitution and, optionally, to rename any of the
30 muhūrtas.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Vedic Date Formatter**, or
   navigate directly to `/admin/config/regional/vedic-date-formatter`.

## Format character

This is the single PHP date character that the module replaces with the muhūrta
name wherever it appears in a date format string. The default is **`q`**.

Choose this carefully: whatever character you pick is "consumed" by this module
and can no longer be used for its standard PHP `date()` meaning in your format
strings. Avoid any character you actually need for its normal purpose — for
instance, don't reuse a letter you rely on for the day, month, or time. A rarely
used character such as the default `q` is a safe choice.

## Muhūrta names

Below the character setting you can override the label of any of the **30
muhūrtas** (for example Rudra, Ahir Budhnya, Surya). Leave them as the defaults for
the standard names, or edit them to match your preferred transliteration or
wording. The form is language‑aware — it works with Drupal's language manager — so
on a multilingual site you can provide names appropriate to each language.

## Save

Click **Save configuration**. Your chosen character and names take effect
immediately, everywhere the core date formatter is used: Date field formatters,
Views date fields, and any code that formats a date. For example, with the default
character a format of `jS F Y, g:i a (Muhurta: q)` renders as
`23rd April 2025, 10:30 am (Muhurta: Surya)`.
