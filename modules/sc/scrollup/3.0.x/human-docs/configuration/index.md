# Configuration

Scrollup works as soon as it is enabled, but its settings form lets you tune where
the button appears and how it behaves.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Scrollup**, or navigate directly to
   `/admin/config/system/scrollup`.

## What you can configure

The form gives you control over:

- **Which themes show the button** — display the "scroll up" button only on the
  themes you choose, so, for example, it can appear on the front-end theme but not
  the admin theme.
- **Position** — where the button sits along the bottom of the page.
- **Scroll speed** — how fast the page animates back to the top when the button is
  clicked.
- **Trigger point** — the amount the visitor must scroll down before the button
  appears, so it stays hidden until it is actually useful.
- **Colours** — the background colour of the button and its hover colour, so it can
  be matched to your theme.

## Accessibility worth checking

These are more important than the colours. When you set the button up, confirm
that:

- it is **keyboard reachable and focusable** — a control that only works with a
  mouse or touch excludes exactly the people who most benefit from not having to
  scroll;
- it has an **accessible name** — an icon-only button announces nothing useful to a
  screen reader; and
- the scroll **respects `prefers-reduced-motion`** — an animated jump to the top is
  precisely the kind of motion that can cause problems for people with vestibular
  disorders.

## Save

Click **Save configuration**. Your changes take effect immediately — reload a long
page and scroll to see the button behave with your new settings.
