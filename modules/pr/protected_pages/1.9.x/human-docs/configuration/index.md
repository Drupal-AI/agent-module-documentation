# Configuration

All of Protected Pages lives under **Configuration → System → Protected Pages**
(`/admin/config/system/protected_pages`), which needs the **Administer protected
pages configuration** permission. There are two main tasks: adding the paths you
want to protect, and setting the global options.

## Add a protected page

1. On the Protected Pages screen, click **Add protected page**
   (`/admin/config/system/protected_pages/add`).
2. Fill in:
   - **Relative path** — the path to protect. It must start with `/`. Use an exact
     path like `/node/5` or `/new-events`, a wildcard like `/new-events/*` to cover a
     whole section, or `/*` to lock down the entire site. You can use either a path
     alias or the internal `/node/N` path — they're treated interchangeably.
   - **Admin Title** — an internal label for your own reference; visitors never see
     it.
   - **Password** (entered twice to confirm) — the page's per-page password. It is
     hashed before it's stored.
3. Save. The path now appears in the paginated list, where you can **edit** or
   **delete** it later. The form rejects a path (or its alias) that is already
   protected.

Protected paths are stored as rows in the module's own database table, **not** as
configuration — so they do not travel with a `drush config:export`.

## Global settings

Open the **Settings** form
(`/admin/config/system/protected_pages/settings`).

### Password mode

Choose how pages can be unlocked:

- **Per page password** — only each page's own per-page password is accepted.
- **Per page or global password** *(default)* — either the page's per-page password
  **or** the site-wide global password unlocks the page.
- **Only global password** — every protected page is unlocked by the single global
  password.

### Global password

Set (or change) the site-wide **global password** here. Like per-page passwords, it
is hashed before being stored. This is the password used by the "global" modes
above.

### Session expiry

- **Session expire time** — how many minutes an unlock lasts before the visitor is
  prompted again. Set it to **0** (the default) to keep an unlock valid for the whole
  session, with no timeout.

### Prompt text

Customize what visitors see on the password screen:

- **Protected page title** — the page title of the prompt (default *"Protected Page
  -- Enter password"*).
- **Description** — the descriptive text on the prompt (HTML allowed).
- **Password fieldset legend**, **Password field label**, and **Submit button text** —
  the labels around the password field (defaults *"Enter password"* and
  *"Authenticate"*).
- **Incorrect password message** — the error shown after a wrong guess.

Click **Save configuration**. These text, password-mode, and session settings are
stored in the `protected_pages.settings` config object, so they export and deploy
between environments.

## Emailing a protected page's URL

From the protected-pages list, the **send email** action
(`/admin/config/system/protected_pages/{pid}/send_email`) lets you email a protected
page's URL to one or more recipients. The email subject and body are set on the
settings form, and the body supports the `[protected-page-url]` and `[site-name]`
tokens.

## Flood control (brute-force protection)

The password prompt automatically throttles repeated wrong guesses by IP address,
using Drupal's flood service. After too many failures (default **5** within a **900**
second window) the visitor sees *"Too many failed login attempts from your IP
address."* A successful login clears the counter. The limit and window come from
configuration if you need to adjust them.

## Permissions

At **People → Permissions**, the module defines three permissions:

- **Bypass pages password protection** (`bypass pages password protection`) — a holder
  is **never** prompted; every protected page is directly accessible to them. Grant it
  only to trusted/administrative roles.
- **Access protected page password screen** (`access protected page password screen`)
  — required to reach the `/protected-page` prompt at all. **Important:** to let
  anonymous visitors unlock pages, you must grant this to the *Anonymous user* role —
  otherwise only logged-in users with the permission (or user 1) can reach the form.
- **Administer protected pages configuration** (`administer protected pages
  configuration`) — access to the whole admin UI (list, add, edit, delete, send-email,
  settings). Trusted/administrative.
