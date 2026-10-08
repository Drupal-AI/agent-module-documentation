# Configuration

Simple Toasts is configured on a single settings form. Until you enable it for at
least one theme, messages continue to display the standard inline way, so this page
is where the module actually starts working.

## Open the settings form

1. Log in as a user with permission to administer site configuration.
2. Go to **Configuration → User Interface → Simple Toasts Settings**, or navigate
   directly to `/admin/config/user-interface/simple-toasts/settings`.

## Choose which themes use toasts

You decide, per active theme, whether Simple Toasts takes over its messages. This
lets you enable toasts on your front-end theme while leaving the admin theme with the
default inline messages, for example. Only the themes you tick will show toasts.

## Per-theme appearance and behaviour

For each theme you enable, you can tune how its toasts look and behave:

- **Message style** — use the theme's own message styling, or pick one of the
  predefined styles that ship with the module.
- **Position** — where toasts appear on screen: top right, top left, top centre,
  bottom right, bottom left or bottom centre.
- **Duration** — how long a message stays before it disappears, set separately for
  each message type (status, warning, error) so you can, say, keep errors on screen
  longer than routine status notices.
- **Animation** — how toasts enter and leave: slide-in, fade-in, slide-out,
  fade-out, or animations switched off altogether.

## Save

Save the form, then trigger a message on the site (for example save a node) to see
your toasts appear in the chosen position with the timing and animation you set.
