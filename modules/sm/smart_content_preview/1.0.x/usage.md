<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content Preview lets you choose which Smart Content segments to "pass" so you can preview the personalized variation that a given segment would see - without having to actually satisfy the underlying conditions (device, location, cookies, etc.).

Use it for QA and content review of personalization: verify each segment's variation renders correctly.

---

Install (requires `smart_content`). A preview-settings event subscriber (`PreviewSettingsEventsSubscriber`) injects preview state into the Smart Content decision settings so selected segments evaluate as matched. Editors select the segments to preview; the decision JS then forces those segments true.

No dedicated admin routes/permissions are added; the module hooks into Smart Content's decision-settings pipeline. Intended for use by content/QA staff reviewing personalized output.

---

- Preview Smart Content personalization variations.
- Force selected segments to evaluate as true.
- Bypass real conditions during review.
- QA each segment's rendered variation.
- Inject preview state into decision settings.
- Avoid faking device/location to test.
- Speed up personalization content review.
- Integrate via Smart Content's event pipeline.
- Require no separate configuration UI.
- Work with any Smart Content segment.
- Support Drupal 8 through 11.
- Depend only on smart_content.
- Help editors validate variation markup.
- Complement the SSR and block submodules.
- Keep evaluation client-side.
- Toggle preview per segment selection.
