# Configuration

Gin Layout Builder styles the Layout Builder UI automatically — this settings form only
tunes a handful of behaviors. The defaults are sensible, so you can leave it alone and
everything works.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Gin Layout Builder settings**, or navigate
   directly to `/admin/config/gin_lb/settings`.

## Toastify loading

Gin Layout Builder uses the Toastify library to show small notification "toasts." This
setting controls where that library is loaded from:

- **CDN** *(default)* — load Toastify from a content delivery network. Simplest, but
  won't work on a site with a strict Content Security Policy that blocks external
  scripts.
- **Composer** — load a locally installed copy (installed via Composer). Choose this to
  serve Toastify from your own domain and satisfy a strict CSP.
- **Do not load** — skip Toastify entirely. Use this on a locked-down site where you
  don't want the library at all.

## Enable preview regions

When on, Layout Builder's **region preview** starts turned on for editors, so the empty
regions of a layout are visible while editing. Off by default. Turn it on if your
editors find it easier to see the region outlines from the start.

## Hide the "Discard changes" button

When on *(the default)*, Layout Builder's **Discard changes** button is hidden from the
layout edit form. This is handy if you don't want editors discarding their in-progress
changes with that button. Untick it to show the button again.

## Hide the "Revert to defaults" button

When on *(the default)*, Layout Builder's **Revert to defaults** button is hidden.
Untick it to let editors revert an overridden layout back to its default from the UI.

## Save behavior

Controls what happens after an editor saves a layout:

- **Stay** *(default)* — keep the editor on the layout edit page after saving, so they
  can continue working.
- **Default** — restore Drupal core's normal behavior, which redirects to the entity's
  view page after saving.

## Save

Click **Save configuration**. Your changes take effect immediately on the Layout
Builder screens. (Note the button-hiding and save-behavior options only apply to the
Layout Builder UI this module styles — that is, when your front-end theme is not Gin.)
