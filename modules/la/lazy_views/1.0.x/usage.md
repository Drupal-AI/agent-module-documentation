<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lazy Views is a tiny JS-only helper that loads any View through Drupal's `views/ajax` endpoint on demand — either on a click/event trigger or immediately on page load — by reading `data-lv-*` attributes off a placeholder element.

---

The module has no PHP logic beyond `hook_page_attachments()`, which attaches its `lazy_views/ajax`
library to every page, and a `hook_help()`. The library's `js/ajax.js` (a `Drupal.behaviors`) scans for
any element with a `data-lv-id` attribute, reads the view id, display id, arguments, DOM target,
trigger event, HTTP method and progress type from `data-lv-*` attributes, and wires up a
`Drupal.ajax()` call to `<baseUrl>views/ajax` that renders the view into a placeholder marked with
`js-view-dom-id-<target>` (the module adds that class to an element matching the target class/id if
needed). If `data-lv-execute` is set the AJAX runs immediately on attach (lazy-load on page load);
otherwise it fires on the named event (default `click`). Because it just calls core's Views AJAX route,
the view still renders server-side with its own access checks — Lazy Views only defers *when* the render
request is made. There is no configuration UI, no permissions, no Drush, no config schema; you use it
purely by placing an element with the right data attributes in your markup (template, block, or field).

---

- Defer rendering of a heavy View until the visitor clicks a button or link.
- Lazy-load a View on page load (via `data-lv-execute`) to keep the initial HTML light.
- Load "related content" / "you may also like" Views only when scrolled/triggered.
- Turn a plain link into a trigger that injects a View's results into a placeholder.
- Load a filtered View passing contextual arguments through `data-lv-args`.
- Render the same View into a chosen container by setting `data-lv-target`.
- Load different Views for different tabs, each fetched only when its tab is activated.
- Reduce Time To First Byte / initial payload on pages that embed several Views.
- Fetch a View via `GET` instead of the default `POST` by setting `data-lv-type`.
- Choose the AJAX progress indicator (`fullscreen`, `throbber`, …) via `data-lv-progress-type`.
- Load a dashboard's secondary Views after the primary content paints.
- Trigger a View load on a custom event name (e.g. a JS-dispatched `lazyload`).
- Embed on-demand search/listing results without building a custom controller.
- Add "load more"-style progressive sections backed by Views displays.
- Lazy-load Views inside modals or off-canvas panels only when opened.
- Keep expensive aggregate/report Views off the critical rendering path.
- Inject a View block's markup into an arbitrary theme region via a placeholder div.
- Load personalised Views after the cacheable page shell is delivered (edge-cache friendly shell).
- Avoid running View queries for content that may never be scrolled into view.
- Wire multiple independent lazy Views on one page, each with its own target and trigger.
