<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IMCE Copy Link adds a **Copy Link** button to the IMCE file browser that copies the selected file's URL to the clipboard, so an editor who needs a link to a file does not have to reconstruct it by hand.

---

IMCE is the long-standing file browser used for picking files in editors and file fields. What it does not offer on its own is the adjacent task: "I need the URL of this file to paste somewhere else" — into an email, a spreadsheet, another system, or a link in a different piece of content. This module adds that as a single IMCE plugin (`src/Plugin/ImcePlugin/Copylink.php` plus `imce_copylink.js`, a stylesheet, and an SVG icon), depending only on `imce` and spanning `^8 || ^9 || ^10 || ^11`. After enabling it, you turn the button on per IMCE profile: go to **`/admin/config/media/imce`**, edit a **Configuration profile**, and in **Directories** tick the **Copy link** checkbox for the folders that should allow it (the shortcut is **Ctrl+Alt+C**). Select one file and click the button to copy its URL; with nothing selected it copies the current folder's URL, and selecting more than one file is refused with "Only one link may be copied at a time." Whether the copied link is absolute or relative follows IMCE's own **Common settings → Enable absolute URLs** flag — this module copies exactly the URL IMCE computed. One caveat worth knowing: the browser Clipboard API requires a **secure context**, so on a site served over plain HTTP the copy may silently fail, which on a TLS-less local environment can look like the module being broken when it is really browser policy.

---

- Copy a file's URL from the IMCE browser.
- Copy the current folder's URL when no file is selected.
- Share a link to an uploaded document.
- Paste a file URL into an email.
- Avoid reconstructing a file path by hand.
- Give editors a quick, keyboard-driven (Ctrl+Alt+C) link-copy action.
- Reference a file from another system.
- Copy an image URL for external use.
- Reduce errors in manually typed paths.
- Support an editorial file workflow.
- Link to a PDF from a newsletter.
- Copy a link during content authoring.
- Share a file with a colleague.
- Reference an uploaded asset in a ticket.
- Speed up file linking across a shared file library.
- Reduce support requests about file URLs.
- Support a documentation workflow.
- Restrict who can copy links by using the per-directory IMCE profile permission.
- Work alongside IMCE's existing browser without changing how files are stored.
