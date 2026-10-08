# Configuration

The consent checkbox is **off until you enable it here** and set your own wording —
which you will almost certainly want to do, because the defaults ship in German and
point at a `/datenschutz` page.

## Open the settings form

1. Log in as a user with the **"administer contact tos checkbox"** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Contact TOS Checkbox**, or navigate
   directly to `/admin/config/user-interface/contact-tos-checkbox`.

The form stores three values in the `contact_tos_checkbox.settings` configuration
object, so your wording travels with the rest of your exported site config.

## Enabled

A checkbox that turns the consent field **on or off** for the site‑wide contact
feedback form. When off, the contact form is unchanged. When on, the required
consent checkbox is injected near the bottom of the form and submission is blocked
until the visitor ticks it. (Stored as `feedback.enabled`.)

## Label

The **text shown next to the checkbox** — the consent statement itself, for example
"I have read and accept the privacy policy." Replace the German default with wording
your legal review approves, in your site's language. (Stored as `feedback.label`.)

## Description

The **help text shown under the checkbox**. It supports an HTML link, so this is
where you link to your actual privacy or terms page (replace the default
`/datenschutz` link with your own URL). Because this value is administrator‑set
configuration that is rendered as markup, treat editing it as a trusted
administrative action. (Stored as `feedback.description`.)

## Save

Click **Save configuration**. Reload the site‑wide contact form to confirm the
checkbox, label, and description appear as intended and that the form cannot be
submitted until the box is ticked.
