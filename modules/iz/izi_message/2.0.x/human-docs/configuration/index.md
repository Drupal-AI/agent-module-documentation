# Configuration

Izi Message works as soon as it's enabled, but the settings form lets you control
where notifications appear, how long they stay, and how they look.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Izi message settings**, or navigate
   directly to `/admin/config/development/izi_message/settings`.

## What you can configure

The form controls the presentation of the iziToast notifications, including:

- **Position** — where on the screen the notification appears (for example a
  corner such as top‑right or bottom‑right, or centered). Pick a position that
  doesn't cover important controls in your theme.
- **Timeout / display duration** — how long a message stays on screen before it
  fades out. Set this generously; a message that vanishes too quickly is worse
  than no styling at all.
- **Appearance options** — styling that lets the notifications match your theme.

Adjust the values, then click **Save configuration**. Changes take effect
immediately — trigger a status message to see the new behaviour.

## A note on accessibility

Transient, auto‑dismissing messages carry accessibility trade‑offs worth keeping
in mind:

- Give messages a **long enough timeout** that they can actually be read.
- **Error and validation messages** are the ones people most need to re‑read
  while correcting a form — treat any auto‑dismiss behaviour for those with
  caution.
- A sensible pattern on many sites is to apply the styled notifications to the
  **admin theme only**, so editors get the improved confirmation experience while
  front‑end validation keeps core's persistent, always‑visible messages.
