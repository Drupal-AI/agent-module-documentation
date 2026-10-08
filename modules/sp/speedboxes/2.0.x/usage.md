<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Speedboxes lets an administrator tick or untick a whole run of checkboxes by dragging a selection box across them instead of clicking each one.

---

Install with `composer require drupal/speedboxes` and enable it with `drush en speedboxes`; there is nothing to configure and no dependencies beyond Drupal core. Once enabled it activates automatically on Drupal's two densest checkbox grids — the core **Permissions** page (`/admin/people/permissions`) and, if the Group module is present, the **group permissions** form — by attaching a small JavaScript library to those forms. To use it, **left-click and drag** across a block of checkboxes; a translucent selection rectangle follows the cursor, the boxes it covers are highlighted, and when you release the mouse a small toolbar pops up next to the cursor offering **Check all**, **Uncheck all** and **Reverse selection**. Those actions toggle the selected checkboxes in the browser only — the change is not saved until you submit the form the normal way with its **Save permissions** button, so the page's usual access check and form validation still apply. The behaviour is entirely client-side (jQuery-based) and requires `^11.2 || ^12` core; it changes nothing on the server and stores no configuration of its own. If you want the drag interaction on other checkbox-heavy forms, a developer can attach the `speedboxes/speedboxes` library to that form in a `hook_form_FORM_ID_alter`.

---

- Tick or untick a run of checkboxes by dragging across them.
- Set up a role on the permissions grid far faster than clicking box by box.
- Grant a group of related permissions in one gesture.
- Revoke a block of permissions at once with Uncheck all.
- Invert a selection with Reverse selection to flip a set of boxes.
- Configure Group module role permissions the same way.
- Reduce repetitive clicking on a site with many modules and permissions.
- Cut mis-clicks caused by tiny, tightly packed checkboxes.
- Speed up the initial site build where roles are defined from scratch.
- Preview a bulk change in the browser before saving the form.
- Highlight which checkboxes a drag will affect before releasing the mouse.
- Keep the standard Save permissions step so nothing changes until you submit.
- Add the drag behaviour to another checkbox grid via a custom form_alter.
- Restyle the selection box and popup toolbar by overriding the module's CSS.
- Translate the toolbar labels (Check all / Uncheck all / Reverse selection).
- Enable it with no configuration and no external libraries.
- Remove it cleanly by uninstalling — it leaves no config or data behind.
- Use it as a lightweight admin-usability improvement on Drupal 11.2+/12.
- Review the resulting role after a bulk change before saving.
- Train editors and admins on faster permission management.
