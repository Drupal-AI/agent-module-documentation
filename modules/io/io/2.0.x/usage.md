<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
io integrates the browser Intersection Observer API, providing a foundation for lazy-loading, scroll animations and visibility-triggered behaviour, with a browser submodule.

---

The Intersection Observer API tells JavaScript when an element enters or leaves the viewport — the efficient basis for lazy-loading images, triggering animations on scroll, or loading content as it becomes visible. io integrates it into Drupal as a reusable foundation other modules/themes build on, with an `io_browser` submodule. It is a front-end library integration with no security surface; it provides the mechanism, and what triggers on visibility is defined by the code that uses it.

---

- Trigger behaviour on scroll into view.
- Lazy-load with Intersection Observer.
- Animate elements on visibility.
- Load content when visible.
- Build scroll-triggered effects.
- Provide an IO foundation.
- Use io_browser integration.
- Efficiently detect viewport entry.
- Base lazy-loading on IO.
- Reuse the observer mechanism.
- Enable when the feature is needed.
- Keep it disabled otherwise.
- Restrict administration to trusted roles.
- Confirm behaviour on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Keep the setup minimal.
- Document why it was added.
- Verify it fits your theme.
- Audit access to it.
- Match it to your use case.