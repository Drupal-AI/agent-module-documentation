# Readmore — agent index

One field formatter (`readmore`) for `text` / `text_long` / `text_with_summary` fields: shows a trimmed
preview with client-side *Read more* / *Read less* toggle links. No admin page, no permission, no Drush.
Depends on core `field`.

- **Formatter settings, the truncation logic, template & JS library** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Plugin: `ReadmoreFormatter` (`@FieldFormatter id="readmore"`). Config schema
  `field.formatter.settings.readmore`.
- Settings: `trim_length` (default 500), `trim_on_break` (`<!--break-->`), `show_readmore`,
  `show_readless`, `ellipsis`, `wordsafe`.
- Theme hook `readmore` → `templates/readmore.html.twig`; library `readmore/readmore` (jQuery/CSS).
