# Configuration

Configuration happens per theme, inside that theme's own settings form. There's no
central settings page — you enable custom JavaScript for each theme where you want
it.

> **Reminder:** JavaScript you enter here runs in every visitor's browser. Only a
> fully trusted administrator (with the **Execute arbitrary js_editor scripts**
> permission) should ever use this form. See the [overview](../index.md) for why
> this is treated as a full‑site‑compromise‑level capability.

## Add custom JavaScript to a theme

1. Log in as an administrator who holds the **Execute arbitrary js_editor
   scripts** permission.
2. Go to **Appearance** (`/admin/appearance`).
3. Click **Settings** for the installed theme you want to add JavaScript to.
4. Scroll to the bottom of the theme settings form and tick the **Enable or
   disable custom JS** checkbox.
5. In the code editor that appears — a rich text area with syntax highlighting —
   type or paste your custom JavaScript.
6. Click **Save configuration**.

The code now runs on the front end for that theme. To add JavaScript to another
theme, repeat these steps on that theme's settings page — the feature can be
enabled independently on multiple themes.

## Turning it off

To stop the custom JavaScript from running, return to the theme's settings form
and untick **Enable or disable custom JS**, then save.
