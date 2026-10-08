<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Speakeasy reads page content aloud using the browser's built-in Speech Synthesis API, driven by a placeable block with per-site and per-user voice and speed settings.

---

Using the browser's own speech synthesis rather than a cloud service is the design decision that defines this module, and it is a good one. Nothing is sent anywhere: the block compiles plain text from the node fields the visitor can already view, strips it to text, and hands it to a JavaScript behavior that speaks it on the visitor's device with the voices their operating system provides. That means no per-character billing, no third-party processing of page content, no cookies and no consent question — a striking contrast with `elevenlabs`, where every rendering is a billed API call.

The trade is quality and consistency. System voices vary from good to robotic across platforms, and a visitor on an older device gets whatever it has. Administrators can shape this from the settings form: whitelist voices per browser, restrict languages, pick the default rate, and choose the bundled Default or Olivero theme (or None, to supply your own CSS). The block offers three output styles — a simple link, a media player with play/pause/stop and a progress slider, or a default button pair — plus optional sentence highlighting that wraps each sentence and scrolls the page as it is spoken.

**Be clear about what this is and is not, because the distinction matters.** A read-aloud button helps people who find reading tiring, are reading in a second language, or are multitasking — a real and underserved group. It is **not** a substitute for accessibility: someone using a screen reader already has speech, and far better integrated speech than a page-level button provides. A site that adds a read-aloud widget and considers accessibility handled has done the opposite of the work.

The per-user preferences route (`/user/speakeasy/preferences`, gated by `manage speakeasy user preferences`) lets a visitor choose voice and rate, stored in the `user.data` store and honored whenever the block renders — which is what makes it usable rather than a novelty, since default synthesis settings suit almost nobody.

---

- Read page content aloud in the browser with a placeable block.
- Speak node field text on the visitor's own device.
- Avoid sending content to a cloud service.
- Avoid per-character text-to-speech billing.
- Help readers who find reading tiring.
- Support readers in a second language.
- Let a visitor choose a voice from available system voices.
- Let a visitor set the speech rate.
- Store per-user voice and speed preferences (`user.data`).
- Offer a media-player output style with play, pause, stop, and a progress slider.
- Offer a simple-link or default-button output style instead.
- Highlight each sentence as it is spoken and auto-scroll the page.
- Restrict which node fields the block reads aloud.
- Whitelist allowed voices per browser (Chrome, Edge, Firefox, Safari, other).
- Restrict the languages voices may use.
- Set a site-wide default speech speed.
- Toggle voice selection and highlighting globally from one settings form.
- Choose a bundled Default or Olivero theme, or opt out to supply your own CSS.
- Provide keyboard shortcuts (Space to play/pause, S to stop).
- Announce to the visitor when their browser lacks Speech Synthesis support.
- Avoid a cookie-consent question for text-to-speech.
- Restrict who administers the global settings.
- Recognise this is not a screen reader substitute.
- Avoid treating read-aloud as accessibility done.
- Accept variable system voice quality across browsers and OSes.
- Test on several browsers and operating systems for voice coverage.
