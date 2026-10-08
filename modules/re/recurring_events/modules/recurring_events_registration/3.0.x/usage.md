Recurring Events Registration lets visitors register for events, adding a Registrant entity with capacity limits, waitlists, series-vs-instance registration, and a configurable set of email notifications (confirmation, waitlist, promotion, modification/deletion).

---

The submodule defines the `registrant` content entity (bundle type `registrant_type`, ships default first-name/last-name/phone fields) representing one registration for an event instance or series. `RegistrationCreationService` (`shared: false`) computes registration state for a given instance/series: capacity and availability (`hasAvailability()`, `retrieveAvailability()`), whether registration is open (`registrationIsOpen()`, open/close schedule types & modifiers), waitlist handling (`hasWaitlist()`, `retrieveWaitlistedParties()`, `promoteFromWaitlist()`), duplicate-email checks, and the registration type (`series` or `instance`, enum `RegistrationType`). `NotificationService` builds and sends (or queues, via `EmailNotificationsQueueWorker`) the configured notification emails with token replacement; the notification set and default subjects/bodies live in `recurring_events_registration.registrant.config`. Registration is driven through `/events/{eventinstance}/registrations/...` routes: add/edit/delete/view/resend, an overview list, a per-user registrations tab, and a "contact registrants" form. Notably, anonymous registrants get UUID-scoped edit/delete routes (`/.../{uuid}/edit`, `/.../{uuid}/delete`) whose access handler (`RegistrantAccessControlHandler::checkAnonymousAccess`) requires the registrant to be owned by anonymous AND the URL's UUID to exactly match the registrant's own (unguessable) UUID before honoring the `edit/delete registrant entities anonymously` permissions — the UUID acts like a capability token, so no separate finding. Computed Views fields/filters expose capacity, registration count, availability and waitlist counts. Provides several alter hooks (waitlist promotion, notification sending, notification types, message params). The nested `recurring_events_reminders` submodule adds scheduled reminder emails.

---

- Let users register for a specific event instance.
- Let users register once for an entire event series (series registration type).
- Cap the number of registrants per event and show remaining capacity.
- Add registrants to a waitlist when an event is full.
- Automatically promote a waitlisted registrant when a spot opens up.
- Open and close registration on a schedule relative to the event date.
- Send a confirmation email when a registration succeeds.
- Send a waitlist email when someone joins the waitlist.
- Notify registrants when they are promoted from the waitlist.
- Notify registrants when an event/series is modified or deleted.
- Let anonymous registrants edit or cancel via an unguessable UUID link (no login).
- Let authenticated users manage their own registrations from a user tab.
- Contact all registrants of an event via the contact form.
- Resend a registration confirmation email to a registrant.
- Prevent duplicate registrations by the same email address.
- Show a per-event registrations overview to staff.
- Expose capacity, count, availability and waitlist counts as Views fields/filters.
- Queue notification emails for background sending under load.
- Customize each notification's subject and body with tokens.
- Add custom fields to the registrant entity via its bundle type.
- Alter which registrant is promoted from the waitlist via a hook.
- Suppress a notification for specific registrants via a hook.
- Send reminder emails before an event using the reminders submodule.
