# Configuration

Messages works with its default card styling the moment you enable it — everything on
this page is **optional tuning**. The settings form lets you decide which message
types are styled, where the cards appear, how they animate, and how long they stay.

## Open the settings form

1. Log in as a user with the permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → User interface** and open the Messages (status messages)
   settings link.

## What you can adjust

The form groups its options into a few areas:

- **Per message type enable/disable** — turn the card styling on or off individually
  for each message type (status, warning, error). This lets you, for example, style
  success and warning notices while leaving errors in Drupal's default rendering, or
  vice versa.
- **Position** — control where the message cards appear on the page (the module offers
  non-intrusive positioning options rather than always pinning them inline at the top).
- **Timing** — set how the cards behave over time, such as how long they remain before
  auto-dismissing. Give users enough time to read important messages before they clear.
- **Animation and visual effects** — toggle the CSS animations (including the
  staggered animation used when several messages appear at once) and the visual
  effects such as the wave backgrounds. Turn these down for a plainer, calmer
  presentation.

Each message card also gets a **manual close button**, so users can dismiss a message
themselves regardless of the timing settings.

## Save

Save the form. Changes take effect immediately — trigger a status message and reload
to confirm the cards look and behave the way you configured them.
