# Recurring Events Registration — entity, settings & routes

## Registrant entity
`registrant` (ContentEntity, `src/Entity/Registrant.php`), bundles = `registrant_type`. Ships default
fields `field_first_name`, `field_last_name`, `field_phone` (config/install). A registration belongs to
an event instance and (for series registration) its series.

## Settings
Route `registrant.settings` → `/admin/structure/events/registrant/settings`
(permission `administer registrant entity`, **restrict access: true**). Config
`recurring_events_registration.registrant.config` (schema
`config/schema/recurring_events_registration.schema.yml`; defaults in
`config/install/recurring_events_registration.registrant.config.yml`):

| Key | Default | Meaning |
|---|---|---|
| `show_capacity` | `true` | Show remaining capacity during registration. |
| `insert_redirect_choice` | `current` | Where the register form redirects (`current` / other). |
| `insert_redirect_other` | `''` | Custom redirect URL. |
| `use_admin_theme` | `false` | Use admin theme when managing registrations. |
| `limit` | `10` | Registrant listing items per page. |
| `date_format` | `F jS, Y h:iA` | Date display format. |
| `title` | `[registrant:email]` | Registrant title pattern (token). |
| `email_notifications` | `true` | Master switch for notification emails. |
| `email_notifications_queue` | (bool) | Send notifications via queue instead of immediately. |
| `successfully_registered` / `_waitlist`, `already_registered`, `registration_closed`, `successfully_updated`/`_waitlist` | see install | Status messages. |
| `notifications.<key>.{enabled,subject,body}` | see install | Per-notification config. |

Default notification keys: `registration_notification`, `waitlist_notification`,
`promotion_notification`, `instance_deletion_notification`, `series_deletion_notification`,
`instance_modification_notification`, `series_modification_notification`. Bodies use tokens like
`[eventinstance:title]`, `[registrant:edit_url]`, `[registrant:delete_url]`.

## Routes (`recurring_events_registration.routing.yml`)
| Route | Path | Access |
|---|---|---|
| `entity.registrant.add_form` | `/events/{eventinstance}/registrations/add` | `_entity_create_access: registrant` |
| `entity.registrant.canonical` / `.edit_form` / `.delete_form` | `/events/{eventinstance}/registrations/{registrant}[/edit|/delete]` | `registrant.view/update/delete` |
| `entity.registrant.resend_form` | `.../{registrant}/resend` | `registrant.resend` |
| `entity.registrant.anon_edit_form` / `.anon_delete_form` | `.../{registrant}/{uuid}/edit|delete` | `registrant.anon-update` / `anon-delete` (UUID must match) |
| `entity.registrant.collection` / `.admin_collection` / `.instance_listing` | `/events/registrations`, `/admin/content/events/registrations`, `/events/{eventinstance}/registrations` | `access registrant overview` |
| `registrations.user_tab` | `/user/{user}/registrations` | `user.view` |
| `entity.registrant.instance_contact` | `/events/{eventinstance}/registrations/contact` | `access registrant overview` + custom `canContactRegistrants` |
| `entity.registrant_type.collection` | `/admin/structure/events/registrant/types` | `administer registrant types` |
| `recurring_events_registration.orphaned_registrants` | `/admin/structure/events/orphaned-registrants` | `administer orphaned events entities` |

A `RouteSubscriber` (config-driven) can toggle registration routes on/off.
