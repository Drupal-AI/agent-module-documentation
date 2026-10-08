<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules & integrations

All submodules live under `modules/` and depend on the base module. Each ships its own
`*.info.yml` at version `3.1.0`, `core_version_requirement: ^11` (Commerce is `^11`; the others
`^11 || ^12`).

## bookable_calendar_commerce — paid reservations (new in 3.1)
Adds capacity-safe paid bookings through Drupal Commerce 3.x. Depends on `commerce_cart`,
`commerce_checkout`, `commerce_order`, `commerce_payment`, `commerce_product`. Assign a published
product variation to a calendar and choose per-reservation or per-attendee pricing plus a checkout
hold duration. Each booking becomes a separate order item and a `pending_payment` capacity **hold**
(via `ReservationManager::hold()`); the reservation is `confirm()`-ed only when Commerce reports the
order fully paid. Removing the order item, cancelling the order, or letting checkout expire releases
the held capacity (cron clears expired holds). Priced calendars reject direct API/JSON:API placement
(`CommerceCheckoutRequired` constraint) and ignore one-click booking so payment cannot be bypassed.
Key classes: `ReservationCheckoutManager`, `CommerceReservationLifecycle`, `ReservationHoldExpirer`,
`ReservationOrderRepository`, `PricingConfiguration`/`PricingRepository`, `CommerceHooks`.

## bookable_calendar_external — external-sync queue plumbing (new in 3.1)
Queues reservation changes for installed external calendar providers and drives inbound availability
reconciliation. Provides the queue workers (`ExternalCalendarSyncWorker`,
`ExternalCalendarAvailabilityWorker`), schedulers/reconcilers, a sync-status repository, and a
`ReservationSyncSubscriber`. Enable it alongside a provider submodule below. The base module defines
the provider/account manager service-collector interfaces
(`bookable_calendar.external_calendar.provider_manager` / `.account_manager` /
`.availability`) and the `ExternalCalendarAvailability` booking constraint.

## bookable_calendar_google — Google Calendar provider (new in 3.1)
Google Calendar event + free/busy provider (depends on `bookable_calendar_external`). Configure at
`/admin/config/system/bookable-calendar/google`. OAuth Web-application client (ID/secret), connect a
Google account, then pick a per-calendar destination calendar. Outbound: one **private** event per
confirmed reservation, inviting only that customer (privacy); optional unique Google Meet per
reservation (UUID as a stable, retry-safe conference key). Inbound (opt-in): cron hides opening
instances that overlap unrelated busy events, and restores them when the meeting moves/removes;
module-created events are marked and ignored so sync cannot block its own opening. The client secret
and OAuth tokens are **authenticated-encrypted (sodium)** in non-exported key-value storage
(`GoogleTokenVault`); production may set
`$settings['bookable_calendar_google_encryption_key']` (base64 32-byte). Classes under
`src/OAuth/**`, `src/Destination/**`, `GoogleCalendarProvider`, `GoogleOAuthController`.

## bookable_calendar_microsoft — Microsoft Outlook provider (new in 3.1)
Microsoft Graph event + free/busy provider (depends on `bookable_calendar_external`). Configure at
`/admin/config/system/bookable-calendar/microsoft` (Entra app registration: client ID/secret,
tenant, delegated permissions). Same per-calendar, per-reservation private-event model, optional
unique Microsoft Teams meeting per reservation, and opt-in inbound availability blocking. Tokens are
encrypted in non-exported storage (`MicrosoftTokenVault`). Classes mirror the Google submodule under
`src/OAuth/**`, `src/Destination/**`, `MicrosoftCalendarProvider`, `MicrosoftOAuthController`.

## bookable_calendar_vbo_booking — bulk booking (retained from 2.x)
Views Bulk Operations actions to bulk-create or bulk-remove reservations on opening instances
(`BookAction`, `BookOpeningInstance`, `RemoveBookingsOnOpening`, plus a derivative). Uses the same
reservation manager as other write paths. Depends on `views_bulk_operations`.

## Optional (not submodules)
- **ECA + BPMN.iO** — time-based reminder workflows (`config/optional` ships an ECA process +
  Modeler API data model; enable and turn on "Booking Notifications: Day Before"). Requires cron.
- **Token** — richer entity/chained tokens and a token browser on the settings/calendar forms.
- **FullCalendar** — display opening instances via a View using the FullCalendar format.
