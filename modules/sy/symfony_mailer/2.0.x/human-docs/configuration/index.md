# Configuration

Mailer Plus keeps a thin base module — a **verify** page and the sending pipeline —
and puts the real configuration in its three submodules. The landing page links you
to each. Everything here requires the **`administer mailer`** permission, which is
access‑restricted (grant it only to trusted administrators).

## The verify page

1. Go to **Configuration → System → Mailer Plus** (`/admin/config/system/mailer`).
2. This is the **verify** screen. It sends a test email and reports whether outgoing
   mail — and the transport you've configured — is actually working. Use it whenever
   you change transports or move to a new environment.

The verify page is the hub: it links out to the transport, policy, and override
screens described below. (Note the base module itself has no `configure` settings
route — this page is the entry point.)

## Transports — how mail is sent (`mailer_transport`)

The **Mailer Transport** submodule is a required dependency, so it's always available.
Manage transports at **Configuration → System → Mailer Plus → Transports**
(`/admin/config/system/mailer/transport`). Each transport is a config entity; add one
and choose its type:

- **SMTP** — send through an SMTP server (host, port, credentials). The most common
  choice for production.
- **Sendmail** — hand off to the local `sendmail` binary.
- **DSN** — configure a transport from a single Symfony DSN string.
- **Native** — use PHP's configured mail settings.
- **Null** — discard all mail (useful on staging/test sites).

Set the transport you want as the one your emails use (a policy can also select a
transport per email type — see below).

## Policies — what emails look like and who they go to (`mailer_policy`)

Enable the **Mailer Policy** submodule to shape emails. Manage policies at
**Configuration → System → Mailer Plus → Policies**
(`/admin/config/system/mailer/policy`). A **policy** is a config entity attached to an
email type (its tag), holding a stack of **EmailAdjuster** rules. Adjusters let you,
for example:

- set the **From**, **To**, **Reply‑To**, **BCC**, or **Subject**;
- choose the **theme** used to render the email;
- **inline CSS** and **convert to plain text**;
- **skip sending** conditionally;
- **choose which transport** an email type uses.

Because each email carries a hierarchical **type/sub‑type tag** (for example `user`,
or the more specific `user__password_reset`), you can create a broad policy for all
user mail and a narrower one that only affects password‑reset mail. To configure the
site‑wide defaults, edit the policy for the top‑level (all‑email) tag and set the From
address, theme, and CSS inlining there.

## Legacy override — capture core emails (`mailer_override`)

Enable the **Mailer Override** submodule to redirect emails still sent through core's
old `hook_mail` API into the Mailer Plus pipeline, so even modules that haven't been
updated benefit from HTML rendering and your policies. Configure which emails are
overridden at **Configuration → System → Mailer Plus → Override**
(`/admin/config/system/mailer/override`).

## How rendering works

When an email is built, its body is rendered as **HTML** through a Drupal theme, its
CSS is **inlined** (via `css-to-inline-styles`), and a **plain‑text alternative** is
generated (via `html2text`) for recipients who prefer it. Which theme is used, whether
CSS is inlined, and whether a plain‑text part is produced are all controlled by
EmailAdjuster rules in a policy — so you tune the look of your mail on the Policies
screen, not in code.

> **Developers:** Mailer Plus exposes a fluent `Email` API, per‑phase hooks
> (`hook_mailer_PHASE()`, `hook_mailer_TYPE_PHASE()`,
> `hook_mailer_TYPE__SUBTYPE_PHASE()`), an alter hook for mailer definitions, and
> `#[MailerInfo]` component‑mailer / processor plugin types for adding new email
> sources and cross‑cutting behavior. See the sibling
> [`agent/`](../../agent/start.md) docs.
