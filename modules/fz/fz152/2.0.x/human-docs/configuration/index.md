# Configuration

All of FZ152's settings live under **Configuration → System → FZ152**
(`/admin/config/system/fz152`) and require the **Administer fz152** permission.
There are three sub‑forms — a general settings form, a forms list, and the
privacy‑policy page — plus the public policy page they produce.

## General settings

This is the main FZ152 settings form:

- **Enable** — the master switch. When this is off, no consent checkbox or note is
  injected anywhere.
- **Is checkbox** — when on, the module adds a **required checkbox** the visitor
  must tick before the form submits. When off, it shows the same text as a plain
  **informational note** that does not block submission.
- **Consent labels** — up to ten label texts (`checkbox_title` through
  `checkbox_title_10`). HTML is allowed, which is how the default labels embed a
  link to the privacy policy. In your forms list you reference a label by its
  number; the first label is used when you don't specify one. The shipped defaults
  are Russian consent sentences linking to `/privacy-policy`.

## Forms list

The second form is where you list which forms get the consent element. Enter one
form per line using this format:

```
form_id|weight|checkbox_title_number
```

- **form_id** — the form's ID, for example `user_register_form`. A `*` acts as a
  wildcard, so `webform_submission_contact_*` matches every matching webform.
- **weight** *(optional)* — controls where the checkbox appears on the form.
- **checkbox_title_number** *(optional)* — which of your ten labels (2–10) to use
  on this form; omit it to use the first label.

For example:

```
user_register_form|100|1
webform_submission_contact_*|110|2
```

When a visitor submits a matching form, FZ152 adds the consent element; if it is a
required checkbox, a validation error blocks submission until the box is ticked.
(Webforms are handled specially — the element is inserted just before the form's
action buttons.)

## Privacy‑policy page

The third form controls the published policy page:

- **Enable** — whether to publish the policy page at all. When off, the module
  removes the route entirely so no policy page is exposed.
- **Title** — the page title (translatable).
- **Path** — the URL path, default `/privacy-policy` (translatable). The page is
  viewable by anyone with the core **Access content** permission.
- **Text** — the policy body, edited with a rich‑text format (default
  `basic_html`). It ships with a complete Russian 152‑FZ policy you can adapt.

## Translation

FZ152's consent labels, forms settings, and policy page are grouped together for
**Configuration Translation**, so you can provide translations of the wording and
the policy. The module ships its defaults in Russian (`ru`).

## The submodules' configuration

- **FZ152 Contact** adds the checkbox to core Contact forms; enable the checkbox
  per contact form after turning the submodule on.
- **FZ152 Consent** logs consents as records — review them (and bulk‑delete) in the
  admin View it provides at the consents listing.
