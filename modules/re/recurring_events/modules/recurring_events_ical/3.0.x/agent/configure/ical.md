# Recurring Events iCalendar — export & mapping

## Download routes (`recurring_events_ical.routing.yml`)
| Route | Path | Access |
|---|---|---|
| `entity.eventseries.ical` | `/events/series/{eventseries}/ical` | `_entity_access: eventseries.view` |
| `entity.eventinstance.ical` | `/events/{eventinstance}/ical` | `_entity_access: eventinstance.view` |

`EventExportController` (`src/Controller/EventExportController.php`) returns a `Response` with headers
`Content-Type: text/calendar` and `Content-Disposition: attachment; filename="event.ics"`, body from
`$this->eventICal->render($event)`.

## The render service
`recurring_events_ical.event_ical` = `Drupal\recurring_events_ical\EventICal`
(interface `EventICalInterface`). Public: `render(EventInterface $event): string` — builds the VCALENDAR
/ VEVENT text using the configured property mappings and tokens.

## iCal property mapping (config entity)
`event_ical_mapping` config entity, managed at `/admin/structure/events/ical`
(routes `entity.event_ical_mapping.{collection,add_form,edit_form,delete_form}`, all permission
`administer eventinstance types`). Schema `recurring_events_ical.event_ical_mapping.*` →
`properties` is a sequence of `recurring_events_ical.ical_property.*`. Each entry maps an iCalendar
property (e.g. SUMMARY, DTSTART, DTEND, LOCATION, DESCRIPTION, URL) to a value expressed with **tokens**
(requires the `token` module), so property values are resolved per event at export time.

Add a mapping (UI): *Structure → Events → iCalendar → Add* → set each property's token value.

## Computed link field
`recurring_events_ical.module` (`hook_entity_base_field_info_alter`) adds a computed base field
`event_ical_link` (class `src/Field/EventICalLinkItemList.php`, field type/formatter under
`src/Plugin/Field/`) to `eventseries` and `eventinstance`, display-configurable on view. It also sets
an `ical` link template on both entity types (canonical + `/ical`). Enable the field in a view display
to render an "Add to calendar" link, or use `$entity->toUrl('ical')`.
