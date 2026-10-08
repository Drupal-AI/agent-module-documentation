# Configuration

Sticky Local Tasks works as soon as it is enabled — this form only lets you tune
where the sticky tabs sit and whether the original tabs stay too.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Sticky Local Tasks**, or navigate
   directly to `/admin/config/user-interface/sticky-local-tasks`.

> **A note on permissions:** the module declares a permission named *administer
> sticky local tasks*, but the settings form is gated by core's **Administer site
> configuration** permission instead. Granting the module-specific permission on
> its own does *not* give someone access to this form — so plan your roles around
> *Administer site configuration*.

## What you can set

- **Position** — choose where the sticky control appears. The module supports
  placing it in the **bottom right** or the **bottom left** of the page, so you
  can move it away from anything your theme already anchors in a corner.
- **Preserve the default local tasks** — by default the module can keep Drupal's
  original top-of-page tabs in place and add the sticky copy as a duplicate. Turn
  this on if you want both the normal tabs and the sticky version; leave it off if
  you would rather rely on the sticky control alone.

## Save

Click **Save configuration**. Reload a content page with local tasks and the
sticky control will reflect your chosen position and behaviour.
