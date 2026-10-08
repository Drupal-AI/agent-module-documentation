<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Visual Debugger exposes Drupal debug messages visually on the front end.

---

Visual Debugger **surfaces debug messages on the front end** — providing a friendlier UI that exposes
debugging messages (normally only visible in source/comments) directly on the page, for easier front-end
debugging. It provides its own permissions, in the Development package.

Use it during development to see debug info. It is a **developer** tool with a clear caveat: it **exposes debugging
information** (theme hints, render data) on the page, which can reveal internal structure — so gate it to
developers via its permission and **disable it in production** (don't expose debug info to real visitors). It has no
content or access role beyond its permission. Enable it only in development.

---

- Expose debug messages on the front end.
- Show theme/render debug info.
- Ease front-end debugging.
- Provide its own permissions.
- Serve development.
- Surface debugging.
- EXPOSE debugging information (internal structure).
- Gate it to developers via its permission.
- DISABLE it in production (don't expose debug info to visitors).
- Have no content/access role beyond permission.
- Enable it only in development.
- Handle visual debugging.
- Show debug info.
- Configure the debugger.
- Debug the front end.
- Handle the display.
- Reveal hints.
- Configure development.
- Handle the debugging.
- Keep it dev-only.
- Provide visual debugging.
