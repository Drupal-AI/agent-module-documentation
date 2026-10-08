<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registration Confirmation sends an immediate confirmation email to the registrant when a registration reaches the completed state, with a per-registration-type subject and message.

---

The submodule adds three **per-registration-type third-party settings** under the key
`registration_confirmation`: `enable` (boolean), `subject` (string) and `message` (a text_format
value/format pair). These appear as a "Confirmation email settings" fieldset on the registration
type edit form. An `EventSubscriber` listens for a registration reaching its completed state and, if
the type has `enable` on, uses the base module's `RegistrationMailer` to send the configured subject
and message to the registrant's email. The message is filtered through the chosen text format and
supports **tokens** (e.g. `[node:title]`, plus registration and host tokens) when the Token module is
installed, so you can personalise the confirmation with the event title, date, registrant name and
so on. This is distinct from the base module's reminder emails (scheduled) and from the Wait List
submodule's separate wait-list confirmation — this one fires immediately on completion. There is no
global settings form; everything is configured per registration type.

---

- Email attendees a confirmation the moment their registration completes.
- Personalise the confirmation subject with the event title via `[node:title]`.
- Include event date, location and registrant name in the body using tokens.
- Enable confirmations only for certain registration types (e.g. paid events).
- Provide a branded HTML confirmation message using a rich-text format.
- Reassure registrants their sign-up succeeded without manual admin follow-up.
- Send a distinct confirmation per event type with type-specific wording.
- Turn confirmations off for internal/staff registration types.
- Combine with base reminder emails so registrants get confirm-now + remind-later.
- Localise the confirmation by crafting per-language message content.
- Give registrants a record of what they signed up for and any next steps.
- Include a link back to the event or a calendar file reference in the message.
- Set a plain-text confirmation for types where HTML email is undesirable.
- Configure confirmation copy as exportable config on the registration type.
- Notify a registrant when an admin completes their pending registration.
- Use tokens to insert the number of spaces reserved into the confirmation.
- Provide contact/support details automatically in every confirmation.
- Ship a consistent confirmation across a family of related event types.
- Avoid writing custom mail code by configuring subject/message in the UI.
- Only enable the confirmation once copy is finalised, via the `enable` toggle.
