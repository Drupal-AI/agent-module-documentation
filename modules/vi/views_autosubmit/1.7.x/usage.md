<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Autosubmit adds an "Autosubmit" exposed-form style to Views so an exposed filter form submits itself automatically — as the user types or changes a control — instead of requiring a click on the Apply button.

---

The module ships a single Views **exposed form** plugin, `autosubmit` (`Drupal\views_autosubmit\Plugin\views\exposed_form\Autosubmit`, extending core's `ExposedFormPluginBase`). You select it per view display under *Advanced → Exposed form → Exposed form style*, replacing the default `basic`. It defines two options: **autosubmit_hide** (boolean, default `TRUE`) — hide the submit button when JavaScript is on — and **timeout** (integer milliseconds, default `500`) — the debounce delay before a text input triggers submission. At render time `exposedFormAlter()` adds the CSS classes `views-auto-submit-full-form` to the form and `views-use-ajax` / `views-auto-submit-click` to the submit button, attaches the `views_autosubmit/autosubmit` JS library (jQuery + `core/once` + `core/drupal`), pushes the `timeout` into `drupalSettings.views_autosubmit`, and adds `js-hide` to the button when `autosubmit_hide` is set. The behavior lives entirely in the view's display config (`display_options.exposed_form.type: autosubmit` with `options.autosubmit_hide` / `options.timeout`); the module has no settings form, configure route, permissions, Drush commands, or plugin types of its own. It pairs naturally with an AJAX-enabled view so results refresh in place.

---

- Make a product catalog filter results instantly as shoppers adjust exposed filters.
- Build a live search box that queries as the visitor types (debounced).
- Remove the Apply button from an exposed filter form for a cleaner UI.
- Auto-refresh a listing when a select-list exposed filter changes.
- Create an instant-filter events calendar without manual submits.
- Speed up a faceted-style content browser using core Views only.
- Debounce a keyword text filter so it waits ~500 ms after typing stops.
- Tune responsiveness by setting a shorter or longer submit timeout.
- Keep the submit button visible for no-JS fallback while still autosubmitting with JS.
- Add instant filtering to an admin content overview view.
- Auto-submit exposed sort controls so ordering updates immediately.
- Provide a "type-ahead results" experience on a directory or member listing.
- Combine with the view's AJAX setting so results update without a full page reload.
- Apply autosubmit to only one display of a view (e.g. the page but not a block).
- Improve UX on a mobile listing where an extra Apply tap is friction.
- Auto-filter a media library grid as exposed filters change.
- Let editors filter a large moderation queue live.
- Drive a location/store finder that updates as filters change.
- Replace a custom JS filter hack with a supported exposed-form plugin.
- Configure via exported view config (`exposed_form.type: autosubmit`) for deployment.
- Standardize instant filtering across multiple views by selecting the same style.
- Reduce server round-trips perception by hiding the button and auto-submitting.
- Autosubmit a taxonomy-term filtered blog listing.
