# Configuration

GDPR Alert is configured from a single settings form.

## Open the settings form

1. Log in as an administrator.
2. Go to `/admin/config/gdpr-alert`.

## The settings

- **Alert message** — the consent text shown in the bar. Because the module
  supports **per‑language** alerts, you can provide different message text for each
  configured language.
- **Position** — whether the alert bar appears at the **top** or the **bottom** of
  the page.
- **Dismissible** — whether the visitor can dismiss (close) the alert. If you make
  it non‑dismissible, it stays visible until acknowledged.
- **Cookie expiration** — how long the acknowledgement cookie is kept before the
  alert would show again.

Fill in any required fields and click **Save**. After saving, the render cache is
flushed automatically so the alert appears (or updates) right away.

## Styling

The module provides base styling only. Expect to add CSS in your theme to match
the bar to your site's look — the provided styles can be overridden freely.

## A reminder on compliance

Recording that a visitor saw a notice is not the same as gating trackers. Make sure
any analytics or marketing scripts on your site do **not** fire before consent is
given — this module shows and remembers the notice, but it does not hold your
tracking scripts back on its own.
