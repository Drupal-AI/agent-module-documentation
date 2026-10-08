<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dismiss adds a small jQuery-powered "Dismiss" close button to every block of Drupal status, warning and error messages so users can hide them without reloading the page.

---

Dismiss is a deliberately lean front-end module. On every page it attaches one Drupal behavior (`Drupal.behaviors.dismiss` in `js/dismiss.js`) that prepends a `<button class="dismiss">` to each `.messages` container Drupal renders, and hides that container with jQuery `.hide('fast')` when the button is clicked. A small stylesheet (`css/dismiss.base.css`) positions and colours the button per message type (status/warning/error). The library is attached site-wide through `hook_page_attachments()`, so there is nothing to configure: no settings form, no routes, no permissions, no config, and no dependencies beyond Drupal core (`core/jquery`, `core/drupal`). Dismissal is purely cosmetic and lasts only for the current page render — the module does not persist which messages were dismissed and does not change whether Drupal generates the messages, so the same messages reappear on the next request if the underlying condition still applies.

---

- Let editors close a stack of validation errors that cover a node edit form so they can reach the fields underneath.
- Give end users a quick way to clear a status confirmation ("Your comment has been posted.") after they have read it.
- Hide long warning banners on an admin page without scrolling past them.
- Make a site feel more polished by letting visitors dismiss cookie/status notices rendered through Drupal's messages system.
- Clear stacked PHP notice/warning messages during theme development so they stop obscuring the page.
- Close the "You have unsaved changes" style warnings that pile up while working in the admin UI.
- Dismiss the error summary shown after a failed form submission once the relevant field has been located.
- Tidy the screen on a kiosk or demo site where transient Drupal messages should be easy to swipe away.
- Reduce visual clutter on data-entry screens where many status messages appear in sequence.
- Let content moderators dismiss workflow transition confirmations after each action.
- Provide a close affordance on messages for sites whose theme does not already style Drupal messages with one.
- Hide the "module installed" / "configuration saved" confirmations on admin config pages after reading them.
- Allow support staff to dismiss error output while reproducing a bug, keeping the rest of the page usable.
- Improve mobile usability by letting users clear full-width message banners that push content down.
- Offer a lightweight alternative to heavier notification modules when all you need is a close button on core messages.
- Let authenticated users clear per-request flash messages that would otherwise stay until they navigate away.
- Give commerce/checkout flows a way to dismiss inline status messages between steps.
- Clean up the screen after bulk operations (VBO/actions) that emit one status message per processed item.
- Dismiss deprecation or requirements warnings on the status report and admin pages while you work.
- Make error-heavy import/migration result pages readable by closing individual message blocks.
