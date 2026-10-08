Google DFP / Ad Manager provider for Advertising Entity — adds a `dfp` AdType and default/iFrame/AMP view handlers that emit Google Publisher Tag ad slots.

---

`ad_entity_dfp` integrates Google's Doubleclick for Publishers (Google Ad Manager) into the Advertising Entity framework. It registers a `dfp` AdType whose per-ad settings are the DFP network id, ad unit id/pattern, size formats, out-of-page flag, AMP options (size validation, same-domain rendering, consent behavior, real-time-config vendors), and default targeting. Three AdView handlers render the slot: a default HTML view backed by the Google Publisher Tag (GPT) library, a self-contained iFrame that runs GPT inside a `srcdoc` document, and an AMP `<amp-ad type="doubleclick">` view. Sizes are stored as validated numeric pairs (or the named size `fluid`); the GPT library loads client-side on non-admin pages when a DFP ad is in use, with optional preloading. Global settings control slot-order targeting and correlator behavior. All ad configuration is gated by the `administer ad_entity` permission.

---

- Create Google DFP / Ad Manager ad units inside Advertising Entity.
- Set each ad's DFP network id and ad unit id/pattern.
- Define one or more ad size formats (e.g. `300x600,300x250`).
- Include the named `fluid` size for native ads.
- Mark an ad as an out-of-page slot.
- Render a DFP ad as a GPT-backed HTML container.
- Render a DFP ad as a self-contained GPT iFrame.
- Render a DFP ad for Accelerated Mobile Pages (`<amp-ad>`).
- Configure AMP consent blocking behavior and non-personalized-ads-on-unknown-consent.
- Configure AMP real-time-config (RTC) vendors and URLs.
- Enable AMP multi-size validation and same-domain rendering.
- Add default per-ad targeting key-values.
- Include slot loading-order targeting (`slotNumber`, `onPageLoad`).
- Control the GPT correlator behavior for fetching ads.
- Preload the Google Publisher Tag library for faster loading.
- Combine DFP ads with content-driven Advertising context and targeting.
