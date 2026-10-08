AB Age Gate shows a full-screen JavaScript age-verification overlay that asks visitors to confirm their age (and store the answer in a cookie) before they browse an age-restricted site.

---

AB Age Gate is a splash/overlay module built for AB InBev brand sites. On every front-end response an event subscriber attaches a small library that, when no `agegate` cookie is present, prepends a full-screen overlay to the page. The visitor confirms their age using one of three configurable modes — a full day/month/year date of birth, a simple Yes/No prompt, or a "dynamic year" prompt that progressively asks for month and day only near the age boundary — and on success an `agegate` cookie is set so the gate is not shown again. The module ships localized prompt/label text for many European locales, extensive branding controls (logo, background image or gradient, accent and button colors, custom font family), an "ignore pages" list to disable the gate on specific paths, optional Google Tag Manager dataLayer events, and a lightweight per-day counters table (loads, successes, under-age, failures, desktop/mobile) that is written by three AJAX endpoints and displayed through a bundled View dashboard. It is a compliance/UX layer rendered entirely on the client; it does not restrict server-side access to content.

---

- Add an age-confirmation splash to an alcohol or other age-restricted brand site before content is shown.
- Require a full date of birth (day/month/year) and compute whether the visitor meets a configurable minimum age.
- Offer a simpler Yes/No "are you old enough" prompt instead of a full date entry.
- Use the "dynamic year" mode that first asks only for birth year and reveals month/day fields only when the answer is near the age threshold.
- Set the minimum allowed age (default 18, bounded 16–25 in the settings form).
- Remember a visitor's confirmation across pages and visits via the `agegate` cookie.
- Let visitors tick "remember my settings" to persist the cookie beyond the session.
- Present the gate in the visitor's site language, falling back to English when a language has no configured text.
- Optionally show a language-preselect step so visitors pick a language before verifying, then redirect to the language-prefixed URL.
- Localize every string (header, subheader, placeholders, errors, cookie/consent copy, imprint, responsible-drinking notice) for locales such as en, fr, nl, de, es, it, pl, da, fi, no, sv.
- Brand the overlay with an uploaded logo image (managed file) or the bundled default logo.
- Set a background image, or a solid color / top-to-bottom gradient background for the overlay.
- Customize primary text color, popup background color, button text color and button background color.
- Apply a custom CSS font family to the overlay.
- Disable the gate on specific paths (e.g. `/privacy-policy`) and on the homepage via `<front>` using the Ignore Pages list.
- Automatically skip the gate on admin, node-add and translation-add paths.
- Link the overlay's consent copy to Terms of Consent and Privacy Policy nodes selected by entity autocomplete.
- Emit GTM `dataLayer` GAEvent pushes for positive/negative age-gate interactions when "Use GTM Datalayer" is enabled.
- Collect per-day statistics (overlay loads, successful confirmations, under-age rejections, invalid-date failures, desktop vs mobile splits).
- View the collected statistics through the bundled `custom_ab_agegate_statistics` View and its dashboard menu link.
- Export the statistics View to CSV using the bundled `views_data_export`/`csv_serialization` integration.
- Configure everything from one admin form at `/admin/config/ab_age_gate` (permission: administer site configuration).
