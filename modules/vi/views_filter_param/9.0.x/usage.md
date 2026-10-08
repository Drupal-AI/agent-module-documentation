<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Filter Parameter provides a Views field that captures the current page's exposed-filter query string so per-row edit/delete links can return the user to the same filtered listing.

---

The field plugin (`ViewsFilterParam`, id `filter_param_views_field`) does no query work; in `render()` it reads the current path and `\Drupal::request()->query` and builds a `?destination-link=<path>&<current query>` string, exposed to Views rewrite as `{{ filter_param_views_field }}`. You append that to an operation link. On the destination form, `hook_form_alter()` detects the `destination-link` query parameter and adds a submit handler (`filter_redirect_submit_handler`) that reconstructs the URL and redirects back to the filtered view after save.

Setup: add the "Views filter param" field to a fields-based view (exclude it from display), then reference `{{ filter_param_views_field }}` in a rewritten link field. Security note: the redirect target is taken from the user-supplied `destination-link` query parameter and passed to `Url::fromUri('internal:' . $url)` in `filter_redirect_submit_handler()` — the `internal:` scheme constrains it to same-site paths (an off-site target throws), but the value is otherwise unvalidated and the surrounding query parameters are concatenated raw, so treat it as a same-site-only redirect and be aware the parameters are reflected into the URL.

---
- Add the "Views filter param" field to a fields-based view.
- Emit `?destination-link=<path>&<filters>` for each row.
- Return users to the same filtered listing after an edit.
- Return users to the same listing after a delete.
- Preserve exposed-filter selections across a row action.
- Preserve pager/sort query parameters in the destination.
- Reference `{{ filter_param_views_field }}` in a rewritten link.
- Exclude the helper field from the rendered table display.
- Keep admins on the filtered view when managing content.
- Improve editorial UX on long filtered content lists.
- Carry multi-value (array) filter params through the link.
- Redirect after form submit via the added submit handler.
- Build "edit and come back" workflows on Views listings.
- Retain search/filter context on bulk editorial tasks.
- Combine with Views UI edit/delete link fields.
- Work on any entity listing built with Views fields.
