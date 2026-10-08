<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Microsoft Clarity integrates the Microsoft Clarity behavioral-analytics service, adding its tracking script for heatmaps and session recordings.

---

Microsoft Clarity is a free behavioral-analytics product — heatmaps, session recordings, and interaction analytics that show how visitors actually use pages. This module injects its tracking script into the site so that data flows to Clarity, configured with the project ID.

The considerations are the ones that come with any third-party analytics that records behavior, and session recording raises them more sharply than page-view analytics. Clarity can capture how users move through pages and, unless configured to mask, what they type and see — so it is loading a third-party script that observes visitor behavior and sends it to Microsoft. That has clear privacy implications: it should be disclosed in the site's privacy policy, gated behind cookie/tracking consent where the jurisdiction requires it (so the script does not run before the visitor agrees), and configured with Clarity's masking so sensitive fields are not recorded.

For a site that wants Clarity's insight and handles the consent and masking properly, the module is the straightforward integration. The module places the script; making it compliant — consent-gating and masking — is configuration the operator must complete, not something enabling the module does on its own.

---

- Add Microsoft Clarity analytics.
- Capture heatmaps.
- Record user sessions.
- See how visitors use pages.
- Inject the Clarity script.
- Configure a Clarity project ID.
- Analyze interaction behavior.
- Gate Clarity behind consent.
- Disclose Clarity in a privacy policy.
- Mask sensitive fields in recordings.
- Understand session-recording privacy.
- Add behavioral analytics.
- Track scroll and clicks.
- Load the tracking script.
- Comply with tracking law.
- Avoid recording before consent.
- Configure Clarity masking.
- Measure page engagement.
- Integrate a third-party analytics.
- Handle recorded-data privacy.