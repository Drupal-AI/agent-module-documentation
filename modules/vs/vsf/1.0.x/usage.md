<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a microphone control to the site that lets visitors speak a query, transcribes it in the browser with the Web Speech API, and feeds it into search — a voice front-end to the existing search, configured with a few label strings.

---

When enabled (a checkbox on `/admin/config/system/voice-search`, permission `administer site configuration`), `hook_page_attachments` injects a microphone icon and the module's JS/CSS library (`vsf/vsf_styles`) into pages. Speech recognition runs entirely client-side in the browser; the configurable strings ("Speak Now", "Listening..", "Did not get, please try again") give feedback while the mic is active. A controller route `/voice-search-feature/data` (`access content`, no-cache) returns an AJAX-rendered template fragment (the voice widget markup, populated with the configured labels) for insertion into a wrapper element — it renders configuration-derived text only and performs no server-side search or external fetch, so it is not an SSRF/mutation surface.

The module is a lightweight accessibility/UX enhancement rather than a search engine: it captures spoken input and hands it to the page's search; actual results come from whatever search the site already uses. Setup is: enable the feature, adjust the prompt strings, and ensure the mic widget appears where users search.

---
- Add voice input to the site's search
- Let visitors speak a query instead of typing
- Turn on the feature via `/admin/config/system/voice-search`
- Customise the "Speak Now" prompt text
- Customise the "Listening.." status text
- Customise the "not recognised, try again" message
- Provide a hands-free search option for accessibility
- Inject the microphone icon into pages when enabled
- Load the voice widget styles library (`vsf/vsf_styles`)
- Improve UX for mobile users who prefer speaking
- Support multiple spoken languages via the browser's engine
- Fetch the voice widget markup via the AJAX data route
- Feed transcribed speech into the existing search form
- Offer voice search on a public-facing content site
- Keep speech recognition client-side (no audio sent to the server)
