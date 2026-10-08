# Configuration

Flag Anonymous is configured **per flag**, not from a central settings page. Its
options appear in an **Anonymous settings** section on each flag's own edit form,
and its settings are saved as part of that flag's configuration. There are two
things to do for each flag you want to gate: fill in the Anonymous settings, and
make sure anonymous users don't already have permission to use the flag.

## Step 1 — Remove the anonymous role's permission for the flag (important)

The call-to-action only appears for anonymous visitors who **lack** permission to
use the flag. If the *Anonymous user* role can already flag/unflag, guests see the
normal flag link and the CTA never shows.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the flag permissions (listed under the Flag module) for your flag.
3. **Untick** the flag/unflag permission for the **Anonymous user** role, and save.

## Step 2 — Open the flag's Anonymous settings

1. Go to **Structure → Flags** (`/admin/structure/flags`) and **edit** the flag you
   want to gate.
2. Scroll to the **Anonymous settings** section.
3. Tick the option to **show this flag to anonymous users even if they don't have
   permission to use it** — this is the master switch. (When you leave it off, none
   of the other options below are saved.)

## Step 3 — Fill in the fields

- **Label display** — how the message is presented:
  - *Original* — keep the flag's normal label, and show the message in a small
    pop-in when a guest clicks it.
  - *Custom* — replace the flag label entirely with the message.

- **Popin title** — a heading for the pop-in message (only used with *Original*
  display), for example "Attention". Leave it blank for no title.

- **Message** — the call-to-action text itself. Use the placeholders `@login` and
  `@register` where you want the login and registration links to appear, e.g.
  *"@login or @register to bookmark this."* The default is
  *"@login or @register to use this flag."*

- **Login label** / **Register label** — the words used for the two links (the
  `@login` and `@register` placeholders). For example "Sign in" and "Join now".

- **Open in a popup** — when enabled, the login and registration forms open in a
  modal dialog so the visitor never leaves the page (using Drupal's core dialog
  system).

- **Popup options for login** / **Popup options for register** — JSON passed as the
  dialog's options for each link, letting you tune the modal's size and behaviour.
  The default is `{"width": "auto"}`; you can set, for example, a fixed width.

Click **Save flag**.

## What happens next

Once configured, an anonymous visitor who encounters that flag sees your
call-to-action instead of an empty space (or the label with a pop-in, depending on
your choice). The login/register links carry a hidden reference to the flag and the
item, plus a return destination — so **after the visitor logs in or registers, the
module automatically performs the flagging they originally intended** and returns
them to the page they came from. That's what makes it a genuine conversion funnel
rather than just a "please log in" notice.

## Tips

- **Different copy per flag.** Because settings live on each flag, a *Bookmark*
  flag, a *Follow* flag and a *Report* flag can each have their own message and
  labels.
- **Translations.** The message and link labels are translatable through the flag
  configuration, so multilingual sites can localise the CTA.
- **Deploying.** The settings are stored as third-party settings on the flag config
  entity, so they export and deploy with your configuration like any other flag
  settings.
- **Turning it off.** Untick the master switch and save the flag — the module then
  removes its stored settings from that flag.
- **Custom placeholders (developers).** You can add extra placeholders to the
  message via a hook; see the [`agent/`](../agent/start.md) docs.
