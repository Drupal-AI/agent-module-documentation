# smart_trim — agent start

Provides the **"Smart trimmed"** field formatter (id `smart_trim`) for `text`, `text_long`,
`text_with_summary`, `string`, `string_long` fields. HTML-aware truncation by chars or words,
optional suffix + "Read more" link. No admin settings page — configured per field on the
**Manage display** screen (`/admin/structure/types/manage/<bundle>/display`). Depends on
`token`, core `field`/`filter`/`text`.

- Configure the formatter (trim length, suffix, more link, options) → [configure/formatter.md](configure/formatter.md)
- Alter the read-more link + tokens → [hooks/hooks.md](hooks/hooks.md)
- Override output template + theme suggestions → [theming/theming.md](theming/theming.md)
