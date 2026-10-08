Webform Counter displays a live count of a webform's submissions (optionally with a progress bar toward a target) via tokens that an AJAX behavior fills in on page load.

---

Webform Counter extends the Webform module with a per-webform "Submissions Counter". On a webform's Settings → Third party settings → Submissions Counter you configure an optional offline base count, an optional target count, and the singular/plural text used to phrase the number. The module then exposes two site tokens — `[site:webform-counter:MACHINE_NAME]` (text only) and `[site:webform-counter-progress:MACHINE_NAME]` (progress bar plus text) — that you drop into an Advanced HTML/Text element or anywhere else tokens are processed. Each token first renders only an empty placeholder span; the bundled JavaScript (`webform_counter/counter`) issues an AJAX request to `/webform-counter/ajax-counter`, which computes `WebformSubmissionStorage::getTotal()` plus the offline count and returns the formatted counter, so the number is never baked into the page cache. The progress bar percentage is `round(100 * count / target)`, clamped to 0–100. The module ships no permissions, no Drush commands, and no admin settings page of its own; everything lives in Webform's third-party settings and in two token/AJAX hooks.

---

- Show "N people already signed" social proof on a petition or pledge webform.
- Display live registration counts on an event sign-up form.
- Add a progress bar toward a fundraising or signature target with `[site:webform-counter-progress:...]`.
- Seed the visible count with historical/offline submissions using the "Offline submissions count" setting.
- Set a "Target submissions count" so the progress bar appears and fills as submissions arrive.
- Phrase the count with correct singular/plural grammar ("1 person" vs "5 people") via the count-text fields.
- Support locale-specific plural forms (the settings form generates one text field per plural form for the webform's language).
- Place the counter inside the webform itself using an Advanced HTML/Text element with the Full HTML text format.
- Place the same counter in a block, node body, or view header — anywhere tokens are processed.
- Reuse one webform's counter on multiple pages by repeating its token (each renders an independent placeholder).
- Keep the counter accurate on cached pages, since the value is fetched by AJAX after the page loads rather than cached inline.
- Show a text-only tally where a progress bar is not wanted using `[site:webform-counter:...]`.
- Communicate campaign momentum ("almost there — 480 of 500") by combining target and count text.
- Motivate completion of a limited-capacity drive by making remaining capacity visible via the bar.
- Present a read-only count without exposing individual submissions or submission data.
- Add a counter to an existing webform without changing its elements, handlers, or storage.
- Roll out counters across several campaign forms, each with its own offline base, target, and wording.
- Combine the progress token with surrounding marketing copy in a rich-text region.
- Localize the counter wording per site language when running multilingual campaigns.
