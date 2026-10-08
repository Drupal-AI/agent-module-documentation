Castorcito date adds a "date" cfield type so Castorcito components can include date or date-and-time values with a chosen display format.

---

Castorcito date is a small sub-module of Castorcito. It registers one `CastorcitoComponentField` plugin, `date` (class `Date` extending `ConfigurableComponentFieldBase`), that a component builder can add to a component. Its configuration form lets you pick a date type (date only, or date and time) and a display format chosen from the site's configured date formats (loaded via the `date_format` entity storage and previewed with the current time). It ships a config schema (`castorcito.field.date`) and an SDC (`components/castorcito_date/`) for rendering.

---

- Add a publish/event date to a component (e.g. a card or banner).
- Let editors enter a date-and-time or a date-only value inside a component.
- Choose which site date format is used to display the value (short, medium, long, or custom).
- Show a start/end date on a timeline or event component.
- Combine a date cfield with other cfields to build event-listing components.
- Reuse the same date-enabled component across many entity types via a JSON field.
- Override the date SDC markup from a theme with `replaces: 'castorcito_date:castorcito_date'`.
