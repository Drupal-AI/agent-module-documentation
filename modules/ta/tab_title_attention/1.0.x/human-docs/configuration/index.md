# Configuration

Tab Title Attention needs to be configured before it does anything — enabling the
module alone shows no animation. There are two parts: the animation settings form,
and the permissions that decide who can edit it and who sees it.

## Activate and configure the animation

1. Log in as an administrator.
2. Go to **Configuration → User interface → Tab Title Attention settings**.
3. **Activate** the module's functionality, then configure the animation — your
   message and how it behaves (for example appearing, blinking, or scrolling
   across the browser-tab title once the tab has been inactive for a while).
4. Save the form.

> **Core-bug note.** The module is currently affected by Drupal core bug
> [#2783897] around visibility conditions. Until that is fixed, you must explicitly
> **select your theme** in the condition settings for the animation to apply as
> expected.

## Set who can edit and who sees it

The module ships its own permissions, so you control both sides of it from
**People → Permissions**:

- One permission governs **who can edit** the animation settings.
- Another governs **who the animation is shown to**.

Grant the editing permission only to trusted roles (it controls the message shown
in visitors' browser tabs), and grant the "shown to" permission to whichever
audience you want to re-engage.

## Save

Click **Save** on the settings form, and **Save permissions** on the permissions
page. Changes take effect immediately for the roles you selected.
