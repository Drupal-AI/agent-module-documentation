# Configuration

Contact Storage has **no big settings form of its own**. Most of its configuration
lives on each **core contact form** (as extra settings on the form's edit page),
plus one global option. Everything hangs off **Structure → Contact**
(`/admin/structure/contact`), gated by the core **Administer contact forms**
permission.

## The messages list

Once the module is on, every submission is stored. Manage stored messages at
**Structure → Contact → List** (`/admin/structure/contact/messages`), a bundled
Views page where you can:

- **View** an individual message as an entity page.
- **Edit** a previously submitted message.
- **Delete** messages one at a time, or in bulk with the delete action.

Each contact form also gets a **View messages** operation that opens the list
filtered to that form.

## Add fields to a contact form

Because contact forms are entity bundles, you can add ordinary Drupal **fields**
(for example a phone number or a dropdown) to a form via its *Manage fields*
screen. Those fields are stored on each message, alongside the automatically
recorded **created** time, **user**, and **IP address**.

## Per‑form settings

On each contact form's add/edit page, Contact Storage adds these extras:

- **Submit button text** — override the default *Send message* label (for example
  *Send enquiry*).
- **Add URL alias** — give the form a friendly URL instead of `/contact/machine_name`
  (the alias must start with `/`; it's removed if the form is deleted).
- **Default disabled contact form message** — the message shown when the form is
  disabled (defaults to *This contact form has been disabled.*).
- **Allow preview** — show or hide the preview button on the form (on by default).
- **Maximum submissions** — cap how many times a single user (or IP address, for
  anonymous visitors) may submit the form; `0` means unlimited.
- **Autoreply text format** — the text format applied to the form's autoreply
  message.

## Enable, disable, and clone forms

From the contact form list you can:

- **Disable / enable** an individual form without deleting it (a disabled form shows
  the disabled message above).
- **Clone** a whole contact form, including its fields, as the basis for a new one.

## Global setting — HTML mail

The one global option lives at **Structure → Contact → Settings**
(`/admin/structure/contact/settings`):

- **Send HTML** (`send_html`, off by default) — send contact emails as HTML. This
  requires the **Swiftmailer** module (and uses the module's bundled HTML mail
  template). Saving this setting clears cached entity‑type definitions because it
  swaps the message view builder.

You can also set it from the CLI:

```bash
drush cset contact_storage.settings send_html true
```

## Routing to different recipients

Contact Storage provides a `contact_storage_options_email` field type that maps
selectable options to extra email recipients, so a submission can be routed to
different addresses based on what the user selects. Add it as a field on the
contact form like any other field.

## Deployment

The global `send_html` setting and the per‑form extras are stored as configuration
(the per‑form extras as third‑party settings on each `contact.form.*`), so they
export and deploy between environments with the rest of your config. The stored
messages themselves are content, not config.
