<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A/B Test JS runs client-side split tests: define conditions that decide who is eligible, experiences that change the page, and tests that bind the two together with a traffic split.

---

Marketing teams want to try two headlines and keep the winner, and the usual answer is a hosted optimisation tool that loads a third-party script, flickers the page while it rewrites the DOM, and sends visitor data somewhere else. This keeps the whole apparatus inside Drupal: conditions and experiences are snippets of JavaScript stored in the site, tests assign visitors to variants, and nothing leaves the server. Version **1.0.x** on `^9.3 || ^10 || ^11`, administered under `/admin/config/user-interface/abjs`. The permission model deserves credit and is the thing to understand before granting anything: **`administer ab test scripts and settings`** is marked `restrict access: TRUE` and gates every route that creates or edits a condition or an experience — the places where JavaScript is written — while **`administer ab tests`** is the unrestricted permission that lets a marketer create tests from the snippets a developer has already approved. That split is exactly right, because an experience is arbitrary JavaScript injected into every page view, which is site takeover in the hands of anyone who should not have it. Grant the marketing team `administer ab tests` and keep the scripts permission with the people who would be allowed to deploy code. On the delivery side, remember that client-side tests flicker unless the variant is applied before first paint, and that they interact badly with aggressive page caching — the split must be decided somewhere the cache does not flatten.

---

- Test two headlines against each other.
- Run a split test without a third-party tool.
- Keep experiment data on the site.
- Try an alternative call-to-action.
- Test a button colour.
- Target an experiment to a page.
- Split traffic between variants.
- Let marketers run approved experiments.
- Keep script authoring with developers.
- Test a landing page layout.
- Measure conversion differences.
- Avoid a third-party optimisation script.
- Run an experiment on a campaign page.
- Target logged-in users only.
- Test a navigation change.
- Roll out a variant gradually.
- Keep visitor data in-house.
- Disable an experiment quickly.
