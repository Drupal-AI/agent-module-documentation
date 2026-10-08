# Configuration

Designated Proxy User has one settings form plus a set of permissions and roles
to assign. Work through the settings first, then grant the roles.

## Open the settings form

1. Log in as a user with the **Administer dpxu configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Designated Proxy User**, or navigate directly
   to `/admin/config/system/dpxu`.

## Settings, field by field

- **Enable managed‑account creation** (`dpxu_enabled`) — the master switch for
  whether managers may create new managed accounts. Turn this off to freeze new
  account creation without uninstalling the module; existing managed accounts are
  unaffected.
- **Maximum managed users per manager** (`dpxu_max_users`) — the per‑manager cap.
  When a manager reaches this number, the creation form stops them from adding
  more. Set it to match how many accounts a single coordinator should reasonably
  handle.
- **Cap‑reached message** (`dpxu_max_user_message`) — the text shown to a manager
  who has hit their limit. Use it to explain what to do next (for example, who to
  contact to raise the cap).
- **Intercept managed‑user emails** (`dpxu_intercept_emails`) — when enabled, all
  system emails addressed to a managed user (password resets, notifications, and
  the like) are rerouted to that user's manager instead. Before forwarding, the
  module strips out `http(s)` links and the one‑time‑login URL, so the manager
  receives a cleaned notification rather than a live login link. This is what lets
  email‑less accounts still "receive" account mail via a human intermediary.
- **Generate placeholder emails** (`dpxu_generate_emails`) — when enabled, a
  managed account created with a blank email field is automatically assigned a
  technically valid but undeliverable address of the form
  `dpxu_managed_user_<uid>@no-mail.invalid`. This keeps core and contrib modules
  that assume a valid email from breaking.
- **Fallback email** (`dpxu_fallback_email`) — where notices go for managed users
  who have no assigned manager. Set this to a monitored inbox so nothing is lost.
- **Contact message template** (`dpxu_contact_template`) — the email body sent
  when a managed user messages their manager through the contact form.
- **Interception message template** (`dpxu_intercept_template`) — the email body
  used when an intercepted managed‑user email is forwarded to the manager.

Both templates accept these tokens: `[dpxu:manager:fullname]`,
`[dpxu:user:fullname]`, `[dpxu:user:edit]`, `[dpxu:message:content]`, and
`[dpxu:notification:content]`.

Click **Save configuration** when you're done.

## Permissions and roles

The module ships two roles — **`dpxu_manager`** (the account manager) and
**`dpxu_managed`** (an account being managed, assigned automatically on
creation) — and a set of permissions on **People → Permissions**
(`/admin/people/permissions`):

- **Administer dpxu configuration** — access to the settings form above. Keep this
  to administrators.
- **Create dpxu users** — allows creating managed accounts at
  `/user/add/managed-user`.
- **Edit dpxu users** — allows editing owned managed accounts at
  `/user/{manager}/edit/managed-user/{user}`.
- **Edit dpxu manager field** — controls who may change the manager‑UID reference
  that links a managed account to its manager.
- **Access dpxu listings** — access to the view listing a manager's managed users.
- **Access dpxu contact form** — lets a managed user open the "message my manager"
  contact form.

Grant the **`dpxu_manager`** role, together with **Create dpxu users** and **Edit
dpxu users**, only to trusted people — a manager can reset a managed user's
password and read their intercepted mail.

## A note on access safety

Access is enforced at two layers. Beyond the route permissions above, the
module's service verifies ownership: when a manager opens the edit form for a
managed account, it checks that the current user really is that account's manager
(or holds core's **Administer users** permission) and redirects otherwise. A
manager therefore cannot edit accounts that belong to a different manager. The
manager‑UID field is additionally edit‑protected, so it can't be reassigned by
someone without the right permission.
