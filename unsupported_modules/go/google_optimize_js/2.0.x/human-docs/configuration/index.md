# Configuration

> **Reminder:** Google Optimize no longer exists (sunset 30 September 2023), so a
> container ID you enter here will not drive live experiments. This page documents the
> form for reference and for existing installations.

All settings live on one form.

## Open the settings form

1. Log in as a user with the **Administer Google Optimize** permission.
2. Go to **Configuration → System → Google Optimize**
   (`/admin/config/system/google_optimize`).

## The fields

- **Google Optimize container ID** — the Optimize container identifier that
  `optimize.js` loads. Because the snippet is emitted client‑side, this value is
  effectively public.
- **Paths (page visibility)** — a list of paths that controls where the snippet is
  included. Enter the paths where you want the snippet attached (path aliases are
  matched via Drupal's path alias manager), following the page‑visibility rules on
  the form.

Admin routes are excluded so the snippet doesn't interfere with the Drupal admin UI.

## Save

Click **Save configuration**. On the paths you selected, the module attaches
`optimize.js` in the page head; elsewhere it stays off. Remember that the
`administer google optimize` permission only governs who can edit these settings — it
is not a content access control.
