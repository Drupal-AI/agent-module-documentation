# Configuration

Everything is configured on a single form by adding the **Email confirmation**
handler. There is no global settings page.

## Add the handler to a form

1. Edit the webform you want to protect and open its **Settings → Emails /
   Handlers** tab.
2. Click **Add handler** and choose **Email confirmation**. (You need Webform's
   normal permission to edit the form.)

Because this handler is built on top of core Webform's email handler, its form
looks just like the standard *Email* handler — you get all the usual To/From,
subject, reply‑to, body and conditions fields — plus a few confirmation‑specific
settings.

## Point the email at the submitter

Set the **To** address to the email element the visitor fills in, for example
`[webform_submission:values:email]`, so the confirmation link is sent to the
person who submitted the form rather than to a fixed admin address.

## The confirmation link token

The handler's default email body is just the token
`[webform_submission:confirmation_link]`. That token expands to the absolute,
signed confirmation URL. You can place it anywhere in your own branded email body
— surround it with your own wording, HTML and styling — as long as the token is
present so the recipient has something to click.

## Confirmation‑specific settings

| Setting | What it does |
|---|---|
| **Confirmation URL timeout** | How long the link stays valid, in **seconds**. Leave it empty (or 0) for links that never expire. |
| **Redirect path** | Where to send the visitor after they successfully confirm — typically a thank‑you page. This field is required and is validated as a URL. |
| **Confirmation message** | The on‑screen message shown after a successful confirmation. Required. |

The handler's *states* are fixed to fire on draft creation/update (that field is
hidden), which is what makes the "hold as draft, then confirm" flow work — you
don't need to set it.

## How the flow behaves

- A new submission is saved as a **draft**, so it does not yet count as completed
  and other handlers that act only on completed submissions won't fire yet.
- The visitor receives the email and clicks the link.
- Drupal loads the submission, re‑checks the signature (a constant‑time compare of
  an HMAC keyed by the site hash salt), confirms the submission is still a draft
  and the link is within its timeout, then marks it **completed** and redirects to
  your **redirect path** while showing your **confirmation message**.
- Because confirmation only works while the submission is a draft, a link stops
  working once it has been used — it is effectively single‑use. A stale, altered
  or reused link shows an error and redirects instead.

## Tips

- You can add **more than one** email‑confirmation handler to a form (for example
  to notify different recipients) — the handler's cardinality is unlimited.
- Combine it with Webform's **conditions** so confirmation emails only send for
  certain submissions.
- Track confirmed vs unconfirmed submissions by watching the draft flag in the
  form's *Results*.
