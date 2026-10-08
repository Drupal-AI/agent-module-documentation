<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Vedic Date Formatter

Route: `/admin/config/regional/vedic-date-formatter` (permission `administer site configuration`).

## Options
- **Format character** — the single PHP date character replaced with the muhūrta name (default `q`). Avoid characters you use for their standard meaning.
- **Muhūrta names** — override any of the 30 muhūrta labels (e.g. Rudra, Ahir Budhnya, Surya). Language-aware via `language_manager`.

## How it works
- `date_formatter_vedic.decorator` (`src/Service/DateFormatterDecorator.php`) decorates the core `date.formatter` service at priority 10.
- On format, `src/Service/DateReplacementService.php` detects the configured character in the format string and swaps it for the muhūrta that corresponds to the given timestamp (30 muhūrtas / day, 48 minutes each).

## Usage
Use the character in any Drupal date format string, e.g.:
```
jS F Y, g:i a (Muhurta: q)
```
Works anywhere the core date formatter is used — Date field formatters, Views date fields, and `\Drupal::service('date.formatter')->format()` calls.
