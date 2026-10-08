# Configuration

Cookie Content Blocker's configuration lives under **Configuration → User interface → Cookie
Content Blocker** (`/admin/config/user-interface/cookie-content-blocker`). Because the module
has no consent logic of its own, the single most important step is mapping your **separate
consent manager** under *consent awareness* — without it, nothing ever un‑blocks.

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Administer cookie content blocker** — the global settings form (and the Media submodule's
  settings, if enabled).
- **Administer cookie content blocker categories** — create, edit and delete cookie categories.

## Global settings

On the settings form you'll find:

- **Blocked message** — the default text shown on a blocked placeholder (e.g. "You have not yet
  given permission to display this content").
- **Show button** *(default: on)* — show a button under the message that lets the visitor change
  their consent.
- **Button text** *(default: "Show content")* — the button's label.
- **Enable click‑consent change** *(default: on)* — when there's no button, clicking the blocked
  placeholder itself counts as consent.
- **Consent awareness** — the mapping to your external consent manager (see below).

### Consent awareness — connect your consent manager

This is where you tell the module how to detect consent. There are three groups —
**accepted**, **declined**, and **change** — and for each you can specify a **cookie** (name,
value, and a comparison operator) and/or a DOM **event** (name and selector) that your consent
manager produces. Set at least one *accepted* signal, or blocked content will never reveal. The
settings are passed to the front‑end JavaScript, which watches for these signals and swaps in
the real content when consent appears.

## Cookie categories

Under the same admin section, the **Categories** list
(`…/cookie-content-blocker/categories`) lets you create **cookie categories** — for example
"marketing" or "statistics". Each category has its own message, button text, click‑consent
option, show‑button toggle, and its **own consent‑awareness mapping**. Assign a category to a
piece of blocked content (via the filter's settings or the render property) so that content
reveals only when that category's signal fires. This is how you support "accept marketing but
not statistics" style consent.

## Text filter and CKEditor 5 button

To let editors block embeds inside WYSIWYG content, configure a text format at **Configuration →
Content authoring → Text formats and editors** (`/admin/config/content/formats`):

1. Enable the **Cookie Content Blocker** filter on the format. It transforms a
   `<cookiecontentblocker>…</cookiecontentblocker>` tag into a blocked placeholder.
2. **Order it last** in the filter list. The filter passes the wrapped HTML through as‑is and
   relies on the format's *other* filters (such as *Limit allowed HTML*) to sanitize it — so do
   **not** enable it on a format that lets low‑trust authors submit raw HTML/JavaScript.
3. Add the **CookieContentBlocker** button to the same format's CKEditor 5 toolbar. Editors then
   select content and click it to wrap the selection (a settings dialog lets them pick a message
   or category per block). A CKEditor 4 → 5 upgrade plugin is included for older setups.

## Front‑end behavior

Once configured, the module attaches its front‑end library (which depends on `js_cookie`) and
the consent‑awareness settings on every page. When your consent manager reports acceptance, the
placeholders are replaced with the real embeds automatically — with a button, on click; without
one, as soon as the consent cookie appears.
