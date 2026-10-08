# Configuration

Website Feedback works as soon as you enable it and grant the **create website
feedback** permission, but a settings form lets you shape the button and the form.

## Open the settings form

1. Log in as a user with the **Administer website feedback** permission (an
   administrator by default).
2. Go to **Configuration → Development → Website Feedback settings**, or navigate
   directly to `/admin/config/development/website-feedback`.

## The settings, field by field

- **Show the Type selector** (`type_enabled`, on by default) — whether the form
  offers a Type choice of *Feedback*, *Support request*, or *Bug report*. Turn it
  off to keep everything in a single feedback stream.
- **Enable screenshots** (`screenshot_enabled`) — shows the screenshot field on
  the form. When on, submitters can capture the current page as an image using
  html2canvas.
- **Enable tags** (`tags_enabled`) — shows a tags field so submitters can
  categorise their report with taxonomy terms.
- **Tags vocabulary** (`tags_vocabulary`) — which taxonomy vocabulary the tags
  field draws its terms from. Set this if you turn tags on.
- **Screenshot technology** (`screenshot_technology`, default `html2canvas`) —
  the capture library used for screenshots.
- **Button text** (`button_text`, default *Feedback*) — the label shown on the
  floating button.
- **Button title** (`button_title`) — the hover (tooltip) text for the button.
- **Success message** (`success_message`, default *Thank you! We received your
  feedback.*) — the thank‑you message shown after a submission.
- **Load html2canvas from CDN** (`html2canvas_cdn`, on by default) — when on,
  html2canvas loads from the jsDelivr CDN. Turn it off to serve a local copy,
  which the module expects at `/libraries/html2canvas/html2canvas.min.js`; the
  form warns you if that file is missing.
- **Link position** (`link_position`, default *right*) — whether the floating
  button sits on the *right* or *left* edge of the viewport.

Click **Save configuration** to apply. Changing the tags vocabulary or screenshot
technology clears cached entity field definitions, since the fields depend on
them.

## Permissions

Five permissions gate the workflow (set at **People → Permissions**):

- **Administer website feedback** — access the settings form; full access to all
  feedback entities. This is a restricted, trusted permission.
- **Create website feedback** — submit feedback. This *also* controls whether the
  floating button appears on pages, so it is the permission you grant to expose
  the widget to a role.
- **View website feedback** — view submitted feedback (useful for a view‑only QA
  or support team).
- **Edit website feedback** — edit feedback, including administrative fields
  (author, resolved status, created date).
- **Delete website feedback** — delete feedback, individually or in bulk.

## Reviewing and resolving submissions

Submissions are listed at **Content → Website feedback**
(`/admin/content/website-feedback`). This is a Views‑based collection with bulk
actions to **Resolve**, **Unresolve**, and **Delete** selected items, so you can
triage reports and mark each one Resolved once it is handled. New items can also be
added by hand at `/admin/content/website-feedback/add`.
