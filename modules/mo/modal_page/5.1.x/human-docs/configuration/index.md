# Configuration

Modal has two kinds of configuration: the **individual modals** you create (one per
dialog, at *Structure → Modal*) and a single **global settings** page (at
*Configuration → User interface → Modal settings*) that applies to all of them. Both
require the **Administer Modal** permission.

## Creating and editing a modal

Go to **Structure → Modal** (`/admin/structure/modal`) and click **Add modal**. Each
modal has a wide range of options, grouped roughly by purpose below. You only need to
set the ones relevant to your dialog — the rest have sensible defaults.

### Content

- **Title** — the modal's heading (also its administrative label).
- **Body** — the modal's content, entered with a formatted-text editor. The HTML you
  can use is limited to the tags listed in the *Allowed tags* global setting (see
  below), so the body is sanitized on output.

### Where and to whom it shows

- **Pages** — the path(s) the modal appears on. Supports wildcards such as
  `/blog/*` and the special token `<front>` for the front page.
- **Type** — how the modal is matched: **page** (match by path, the usual choice) or
  **parameter**.
- **Roles** — restrict the modal to specific user roles; leave empty to show it to
  everyone.
- **Languages** — restrict the modal to specific site languages.

### How it opens

- **Auto open** — open the modal automatically when the page loads.
- **Open on element click** — instead of (or as well as) auto-opening, open the
  modal when the visitor clicks an element matching a CSS selector you provide.
- **Show on scroll offset** — options to reveal the modal only after the visitor has
  scrolled a certain distance (with a separate offset for touch devices).

### Appearance

- **Modal size** — small, medium or large.
- **Header / footer / title toggles** — show or hide the modal's header, footer and
  title.
- **CSS classes** — add custom classes to the modal, its header, its footer and each
  button, so you can style it to match your theme.
- **Embedded video link** — a video URL to embed inside the modal.

### Buttons and closing

- **OK button** — enable a primary (right) button and set its label.
- **Dismiss button** — enable a secondary (left) button and set its label.
- **Top-right X close** — show the familiar X in the corner, with a custom label.
- **Close on ESC key** / **Close on click outside** — let visitors dismiss the modal
  with the Escape key or by clicking the backdrop.
- **Redirect link** — send the visitor to a URL when they accept the modal.
- **Auto-hide** — automatically hide the modal after a delay you set.

### Dismissal memory

- **Don't show again** — offer a "don't show again" option, with a custom label,
  backed by a cookie so a dismissed modal stays hidden.
- **Custom cookie expiration** — override the site-wide default cookie lifetime for
  this modal so it stays hidden for a chosen period.
- **Show once** — show the modal only once per visitor.

### Publishing and scheduling

- **Published** — whether the modal is currently active.
- **Publish on / Unpublish on** — timestamps that schedule when the modal goes live
  and when it expires. These only take effect if the scheduler runs — via the
  `drush modal_page:cron` command or the HTTP cron endpoint (see
  [Installation](../installation/index.md#scheduling-optional)).

Save the modal, then visit a page it targets to see it in action.

## Global settings

Go to **Configuration → User interface → Modal settings**
(`/admin/config/user-interface/modal-page/settings`). These apply to every modal:

- **Verify and auto-load Bootstrap** *(default on)* — check whether Bootstrap needs
  loading and load it if so.
- **Force-load Bootstrap** *(default off)* — always load Bootstrap from a CDN,
  regardless of the check above. Turn this off if your theme already provides
  Bootstrap.
- **Bootstrap version** *(default 3x)* — choose **3x** or **5x** to match your
  theme.
- **Allowed tags** — the list of HTML tags permitted in modal bodies (headings,
  links, emphasis, and so on). Anything outside this list is stripped when the body
  renders.
- **Clear caches on modal save** *(default off)* — rebuild caches whenever a modal is
  saved. Useful if edits do not appear immediately, at the cost of a cache rebuild
  each save.
- **Default cookie expiration** *(default 10000)* — the default lifetime for the
  "don't show again" cookie, used unless a modal overrides it with its own custom
  expiration.

Click **Save configuration** to apply. Changes take effect on the next page load.
