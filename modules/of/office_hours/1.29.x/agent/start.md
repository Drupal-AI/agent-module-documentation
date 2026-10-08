# office_hours — agent start

Defines the `office_hours` field type (weekly open/closed hours + exceptions + seasons) plus
widgets, formatters (incl. live open/closed **status**), Views integration, and theming. Attach
it via Field UI (no central admin page). Depends on core `field` + `datetime`.

- Add the field, widget & formatter options → [configure/field.md](configure/field.md)
- Field API (isOpen/getStatus/slots), Views, status AJAX → [api/status.md](api/status.md)
- Alter hooks (current time, time format) + EventSubscriber → [hooks/hooks.md](hooks/hooks.md)
- Theme hooks & templates → [theming/templates.md](theming/templates.md)
