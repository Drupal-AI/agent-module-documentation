# Configuration

Prevent Multiple Form Submissions is configured from a single settings form where
you tell the module which forms to protect and how the server-side lock should
behave.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Prevent Multiple Form Submissions**, or
   navigate directly to `/admin/config/system/pmfs`.

## What you configure

The form lets you set up protection per form. For each form you want to guard:

- **Which form to protect** — identify the specific form (by its form ID) that
  should have duplicate-submission protection. The module applies the server-side
  lock only to the forms you list here, so unrelated forms are unaffected.
- **Timeout** — how long, after a submission, a second submission of the same form
  is blocked. During this window a repeat submission is rejected instead of
  processed. Set it long enough to cover a slow response, but no longer than
  necessary, so legitimate follow-up work is not held up.
- **Skip timeout when the first request finished** *(optional)* — when enabled, the
  lock is released as soon as the initial submission has finished processing,
  instead of always waiting out the full timeout. This reduces the wait before the
  user can legitimately submit again, while still catching duplicates that arrive
  while the first request is still in flight.
- **Validation error message** — the message shown to the user when a duplicate
  submission is detected and blocked. Write something that explains what happened
  ("Your submission is already being processed — please wait a moment") so the user
  is not confused.

## A note on scope

Remember what this form is and is not doing. It enforces **idempotency for a single
form render** — one submission per rendered form, keyed to that render. It is
**not a rate limiter**: if a form needs protection against automated flooding, pair
this module with core's **flood control** or a protection layer in front of the
site.

## For developers

Beyond the form settings, the module exposes an **API** so custom controllers can
use the same configurable locking mechanism to guarantee a single processing
operation per session. See the module's own code and README for the service and
method details.

## Save

Click **Save configuration**. Protection takes effect immediately for the forms you
listed — submit one of them twice in quick succession to confirm the second attempt
is rejected with your error message.
