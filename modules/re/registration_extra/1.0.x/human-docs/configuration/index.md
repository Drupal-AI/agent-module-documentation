# Configuration

Registration Extra has no settings page of its own. Its options attach to each
**registration type**, and its extra features (a token, a download) surface on the
Registration forms and lists you already use.

## Per-registration-type defaults

1. Go to **Structure → Registration types** and **edit** the registration type you
   want to configure (these types are provided by the Registration module).
2. Registration Extra adds the following defaults to the type:
   - **Default confirmation message** — the message shown to a user after they
     complete a registration of this type.
   - **Default organizer email(s)** — the addresses treated as the organizers for
     this type.
   - **Default reminder email template** — the message used when reminding
     registrants.
   - **Notify organizers on new registration** — when enabled, the organizer
     addresses above receive an email each time someone registers.
3. Save the registration type.

Setting these as defaults on the type means you don't have to re-enter the same
message and addresses on every individual registration.

## The registrant-data token

Registration Extra provides a token, **`[registration_extra:registration_data]`**,
that outputs **all the data a user submitted** for a registration. Use it inside a
confirmation message, an organizer notification, or a reminder template to include
the full submission without listing each field by hand.

> Because this token can expose everything a registrant entered — potentially
> personal data — be deliberate about **where** you place it. It's appropriate in a
> mail sent to organizers or back to the registrant; avoid putting it anywhere it
> could be seen by people who shouldn't see other registrants' data.

## Downloading registrations

The module adds the ability to **download all registrations for a form**, so you
can export the list of who registered (for example to a spreadsheet for an event).
Look for the download option on the registration form's manage/registrations
screen provided by the Registration module.

## Keep access controls and privacy in mind

Registration Extra works entirely through the Registration module, so all of
Registration's own controls — who may register, capacity limits, and any approval
requirement — still apply. When you enable organizer notifications, use the
all-data token, or export registrations, you are moving registrant information
(potentially PII) around, so confirm that where it lands is consistent with your
privacy policy and that only the right people can reach it.
