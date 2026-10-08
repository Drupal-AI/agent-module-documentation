# Configuration

All of Better Messages' behavior lives in one settings form. You do not have to
change anything — the module ships with sensible defaults (a centered, 400px‑wide
box that fades in and out and can be dragged) — but the form is where you tailor
how the popups look and act.

## Open the settings form

1. Log in as a user with the **Configure Better Messages** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Better Messages**, or navigate
   directly to `/admin/config/user-interface/better-messages`.

## Position

Controls where the message box appears on screen. The **position** option offers
center (the default), top‑left, top‑right, bottom‑left, or bottom‑right. When you
pick a corner, two offset fields fine‑tune the placement:

- **Vertical offset** *(default 0)* — pixels to push the box down from (or up
  toward) the edge. Ignored when position is *center*.
- **Horizontal offset** *(default 10)* — pixels to inset the box from the side.
  Ignored when position is *center*.

There is also a **Fixed position** toggle *(on by default)*: when enabled, the
message box stays put as the visitor scrolls, so it remains visible on long pages.

## Width

**Width** *(default `400px`)* sets how wide the message container is. Enter any CSS
width value.

## Animations

Two settings control how the box opens and how it closes:

- **Pop‑in effect and duration** *(default `fadeIn`, `slow`)* — the animation used
  when a message appears, and how quickly it plays.
- **Pop‑out effect and duration** *(default `fadeOut`, `slow`)* — the animation
  used when the message goes away.

Choose subtler, slower animations for a calm feel, or faster ones to grab
attention.

## Auto‑close behavior

By default messages stay until dismissed, but you can have them close themselves
after a set time:

- **Auto‑close after (seconds)** *(default 0)* — how many seconds a message stays
  before closing on its own. `0` means it never closes by time.
- **Disable auto‑close** *(default off)* — a hard switch that keeps auto‑close off
  entirely. Useful if you want errors to remain until the user explicitly closes
  them.
- **Show countdown** *(on by default)* — displays a countdown timer so the visitor
  can see how long before the toast disappears.
- **Pause on hover** *(on by default)* — pauses the auto‑close timer while the
  mouse is over the message, so a toast will not vanish while someone is reading
  it.
- **Open delay (seconds)** *(default 0.3)* — a short pause before the message
  appears, which makes the animation feel less abrupt.

## Drag and resize (jQuery UI)

These two options rely on the jQuery UI modules that Better Messages depends on:

- **Draggable** *(on by default)* — lets the visitor drag the message box around
  the screen.
- **Resizable** *(off by default)* — lets the visitor resize the message box by its
  edge.

## Visibility — limit where popups appear

The **visibility** section embeds Drupal's standard condition plugins (such as
request path). Use it to restrict the popups to, or exclude them from, specific
pages — for example, show them everywhere except the checkout flow or certain
admin screens. Leave it empty to show the enhanced messages on every page.

Better Messages also ships a **Message type** condition, which lets other
condition‑aware plugins (like block visibility) act based on whether a status,
warning, or error message is currently present. That condition is available
automatically once the module is enabled.

## Save

Click **Save configuration**. Changes take effect the next time a message is shown
— trigger one (for example, save a node) to preview your new settings.
