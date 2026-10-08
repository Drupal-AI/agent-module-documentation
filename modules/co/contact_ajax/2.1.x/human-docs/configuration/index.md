# Configuration

Contact Ajax has no central settings page. You configure it **per contact form**,
in a **Contact ajax** section that the module adds to each form's edit page. The
choices are stored on that contact form's configuration, so every form can behave
differently.

## Open the settings

1. Go to **Structure → Contact forms** (`/admin/structure/contact`).
2. Click **Edit** on the form you want (core ships a *Website feedback* form).
3. Scroll to the **Contact ajax** section.

## The settings

### Ajax Form

The master switch. Tick it to make this contact form submit via AJAX — the form area
updates in place instead of reloading the page. Leave it unticked to keep the form
as a normal Drupal contact form. The rest of the options only apply when this is on.

### On submit load

Choose what replaces the form after a visitor submits it successfully. There are
four options:

- **Default message only** — show just the usual "Your message has been sent" status
  message.
- **Message and a fresh empty form** — show the status message *and* a new blank form
  underneath, so a visitor can immediately submit again. Good for forms people fill
  in repeatedly.
- **Node content** — replace the form with the full rendered view of a node you
  choose. Use this to show a dedicated thank‑you page, a marketing call‑to‑action, or
  any other content. When you pick this, a **Node to load** field appears — enter the
  node to render.
- **Custom message** — replace the form with a formatted message you type in. When
  you pick this, a **Message to load** rich‑text field appears, with a text‑format
  selector so you can format and localize the confirmation.

### Advanced options

These are optional and let the module fit into custom page markup:

- **Prefix id** — a custom HTML id for the wrapper `<div>` around the form (the
  default is `contact_ajax_<form_id>`). Set this if your theme or styling needs a
  specific id to target.
- **Render into this HTML element (class/id)** — a CSS selector such as
  `.render-here` or `#render-here`. When set, the AJAX response is injected into that
  element instead of where the form sits, and the original form is removed from its
  place. This is handy for showing the confirmation somewhere else on the page — for
  example a sidebar or a banner region.

If the **Views** module is enabled, the page also scrolls smoothly to the response
after submission, so the visitor sees the confirmation even if it appears elsewhere.

Click **Save** on the contact form to store the settings. Validation errors, by the
way, are handled inline over AJAX automatically — a visitor who misses a required
field sees the error without the page reloading or their input being lost.

## Setting it from the command line

If you prefer Drush, the options are third‑party settings on the contact form config
entity (replace `feedback` with your form's id):

```bash
ddev drush cset contact.form.feedback third_party_settings.contact_ajax.enabled true -y
ddev drush cset contact.form.feedback third_party_settings.contact_ajax.confirmation_type 1 -y
ddev drush cr
```

The `confirmation_type` values are `1` (default message), `4` (message plus empty
form), `2` (node content), and `3` (custom message).
