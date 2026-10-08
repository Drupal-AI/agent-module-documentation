<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Collection Hero renders the hero band — the full-width introduction at the top of a landing page.

---

The hero is the first thing a visitor sees and the component with the most influence on how a page performs, both in the marketing sense and the technical one. It typically combines a large background image, a heading, supporting text and a call to action.

Two things about it deserve attention that other components do not need.

**It is the largest contentful paint on almost every landing page.** Whatever image the hero loads is the thing browsers measure the page's loading performance against, so the responsive image configuration matters more here than anywhere else — and preloading it is often the single highest-value performance change available on a landing page.

**Text over an image is a contrast problem.** A heading that is legible over one photograph is illegible over another, and editors change the photograph. An overlay, a scrim or a constrained text area is what makes it reliable; leaving it to whoever picks the image is how a page becomes unreadable in production.

---

- Add a hero band to a landing page.
- Show a heading over a background image.
- Place a call to action in the hero.
- Serve a responsive hero image.
- Preload the hero image.
- Improve largest contentful paint.
- Keep hero text legible over any image.
- Apply an overlay or scrim.
- Constrain the text area over an image.
- Style the hero with utility classes.
- Translate hero content.
- Save a hero to the section library.
- Audit hero images for size.
- Test contrast with several images.
- Set a consistent hero height.
