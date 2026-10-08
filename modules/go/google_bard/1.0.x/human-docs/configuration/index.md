# Configuration

All configuration lives on one small form. Because the values you enter here are
session cookies from a live Google account, please read the security note at the
bottom before you paste anything in.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → System → Google Bard settings**, or navigate directly
   to `/admin/config/system/google-bard-settings`.

## The fields

The form stores the two cookie values the module sends with every request to
`bard.google.com`:

- **`__Secure-1PSID`** — the primary Bard session identifier from your signed‑in
  Google account. You capture it from your browser's cookie storage while logged
  in to Bard.
- **`__Secure-1PSIDTS`** — the companion rotating token cookie that accompanies the
  session ID.

Paste each value into its matching field and click **Save configuration**. After
saving, the query form at `/google-bard` can send prompts and display replies.

## About secret storage — read this first

These cookies are **not** an API key with limited scope; they are live credentials
for the whole Google account they came from. Anyone who can read them can act as
that account. Treat them accordingly:

- Use a **throwaway / dedicated** Google account for experiments, never a personal
  or organizational account.
- The module stores the cookies in Drupal configuration in plain text and injects
  them into the request environment, so do **not** export them into version‑controlled
  config, and do not run this on a production or shared site.
- The module talks to Google's consumer endpoint, so cookies can and do expire —
  expect to re‑capture and re‑enter them periodically.

Because of these constraints, this module is best kept to local prototyping. For a
supported path, migrate to Google Gemini via the Drupal AI provider ecosystem.
