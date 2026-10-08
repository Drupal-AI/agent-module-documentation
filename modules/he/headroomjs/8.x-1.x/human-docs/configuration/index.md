# Configuration

Headroom.js has a single settings form. Log in as an administrator and go to
**Configuration → System → Headroom.js**
(`/admin/config/system/headroomjs`).

## Enable and target an element

The form lets you switch the behaviour on and choose **which HTML element**
Headroom.js attaches to — you specify the element/selector for the header or menu
you want to hide-and-reveal (for example your theme's header element). When
enabled, the library is attached to the page and applied to the element you
named, toggling its classes as the user scrolls.

## Tune the scroll behaviour

The form exposes Headroom.js's behaviour options. The one you'll most likely
adjust is the **tolerance** value — how many pixels of scrolling trigger the
hide/show effect. A small value (say 10–20 px) makes the header react almost
immediately; a large value (say 200 px) makes it wait until you've scrolled a
long way before it "pops." Tune this until the effect feels intuitive on your
site.

## You must supply the CSS

The module deliberately ships **no CSS**. Headroom.js works by toggling classes
on the element as you scroll, but it's up to you to style them — you'll need to
set the element's `position` (typically fixed/sticky) and the `display`/transform
rules for the headroom classes so it actually pins, hides, and slides the way you
want. Without that styling the element won't visibly move.

## Save

Click **Save configuration**. Reload a long page and scroll down and back up to
confirm the element hides and reappears. If nothing happens, re-check that the
Headroom.js library is installed (see [Installation](../installation/index.md)),
that you named the correct element, and that your CSS positions it.
