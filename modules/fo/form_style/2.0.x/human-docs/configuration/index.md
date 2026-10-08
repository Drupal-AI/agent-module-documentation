# Configuration

Form Style works the moment you enable it — the showcase at `/admin/form_style`
needs no setup. The settings form only tunes what the showcase shows, so
everything here is optional.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **`/admin/config/form_style`** (route `form_style.settings`).

This is a different page from the showcase itself (`/admin/form_style`) — the
showcase is what you *look at*, and this form is where you adjust it.

## Settings

- **Disable Inline Form Errors on the showcase page** — Drupal core's Inline Form
  Errors module moves each validation message next to its field. Turning this
  option on suppresses that behaviour **for the showcase page only**, so you can
  compare how errors render *with* and *without* inline form errors. This is
  handy when you are evaluating two error‑presentation approaches side by side.
  Leave it off to see the standard inline‑error experience.

Save the form, then reload `/admin/form_style` and re‑submit it to see the effect
on the error messages.

## Reminder

These settings are about reviewing form theming and error presentation on a
development site. They do not change anything about how forms behave elsewhere on
your site, and the module should not be enabled in production regardless of these
settings.
