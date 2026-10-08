# Configuration

All of Honeypot's settings live on a single page: **Configuration → Content
authoring → Honeypot configuration** (`/admin/config/content/honeypot`). You
need the **administer honeypot** permission to open it.

![The Honeypot configuration page: the Honeypot Configuration settings and the start of the Honeypot Enabled Forms section](../images/settings.png)

The page has two parts: a **Honeypot Configuration** block of global settings at
the top, and a **Honeypot Enabled Forms** block below where you turn protection
on for individual forms.

## Step 1 — decide how much to protect

At the very top is a single checkbox:

- **Protect all forms with Honeypot** — enables protection for *every* form on
  the site at once. As the form's own help text points out, this is convenient
  but heavy-handed; it is usually best to leave this **off** and instead pick the
  specific forms you care about in the **Honeypot Enabled Forms** section (see
  Step 5).

> **Caching caveat.** The form warns that **page caching is disabled on any page
> where a protected form appears whenever the Honeypot time limit is not `0`.**
> That is because the time check needs a fresh per-visitor timestamp, which a
> cached page cannot provide. Keep this in mind if you turn on *Protect all
> forms* on a high-traffic, heavily cached site — protecting only the handful of
> forms that actually receive spam keeps caching working everywhere else.

## Step 2 — turn on logging (optional)

- **Log blocked form submissions** — when ticked, every submission Honeypot
  rejects is written to the Drupal log (**Reports → Recent log messages**). This
  is useful while you tune the settings so you can confirm bots are being caught
  and that legitimate users are not. Leave it off once you are confident.

## Step 3 — set the hidden field name

- **Honeypot element name** (default `url`) — the machine name of the invisible
  honeypot field that gets added to protected forms. Real visitors never see it;
  bots that auto-fill every field give themselves away by filling it in. A
  generic name such as `url`, `email`, `homepage`, or `link` works best. Change
  it if the default clashes with a real field already on one of your forms. It
  **must not contain spaces or special characters**, and you should avoid words
  like `honeypot` that would tip off a tuned spam bot about the field's purpose.

## Step 4 — set the time limit

- **Honeypot time limit** (default `5` seconds) — the minimum number of seconds
  that must pass before a submission is accepted as human. A form sent faster
  than this is treated as a bot and rejected. Honeypot also applies an automatic
  back-off: visitors who repeatedly trip the trap face a progressively longer
  required delay. Set the value to **`0` to disable** the time check entirely
  (leaving only the hidden-field check). As the form notes directly under this
  field, **page caching is disabled on any page carrying a form that is protected
  by the time limit** — another reason to set it to `0`, or to protect only
  selected forms, if caching matters on those pages.

- **Honeypot expire** (default `300` seconds) — how long Honeypot keeps its
  per-visitor tracking data. Rows older than this in the `{honeypot_user}` table
  are cleaned up automatically the next time cron runs. The default is fine for
  most sites; leave it unless you have a specific reason to change it.

When you are happy with these values, click **Save configuration**.

## Step 5 — enable protection per form

Scroll down to the **Honeypot Enabled Forms** section. This is where you opt
individual forms into protection when *Protect all forms* is left off. Forms are
grouped for convenience — for example a **General Forms** group with **User
Registration form** and **User Password Reset form**, a **Contact Forms** group,
and so on, depending on which modules your site has enabled.

1. Tick the checkbox next to each form you want Honeypot to guard — common
   spam targets are user registration, contact forms, comment forms, and
   webforms.
2. Leave forms you do not need protected unticked.
3. Click **Save configuration** to apply your choices.

A few forms — the login form, the search forms, exposed Views filters, and
Honeypot's own settings form — are excluded from protection by default and are
not offered here, so you cannot accidentally lock yourself out of logging in or
searching.

## Letting trusted users bypass Honeypot

Honeypot also ships a **bypass honeypot protection** permission. Any role
granted it is exempt from both the hidden-field and time-limit checks, so
legitimate fast submissions from trusted editors are never rejected. Grant it at
**People → Permissions** (`/admin/people/permissions`) if a trusted role is
being caught by the time limit.
