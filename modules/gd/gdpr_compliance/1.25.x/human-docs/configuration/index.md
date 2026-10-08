# Configuration

All of the module's settings live in one config object, edited through two forms.
Both require the **Administer GDPR compliance** permission (which is a restricted
permission — grant it only to trusted administrators).

## GDPR Form Settings — the consent checkbox

At **Configuration → GDPR → GDPR Form Settings**
(`/admin/config/gdpr/compliance`). This controls where the required "I have read
and agree to the Cookie & Privacy Policy" checkbox appears.

- **Policy link URL** — where the checkbox's policy link points. An internal path
  like `/gdpr-compliance/policy` (the default) or an external `http(s)://` URL.
- **User registration** — add the checkbox to `/user/register`. On by default.
- **User login** — add the checkbox to `/user/login`. Off by default.
- **Contact forms** — choose *disable*, *all* contact forms, or *custom* (then
  pick specific contact form bundles).
- **Node forms** — the same three‑way choice for content add/edit forms, with a
  bundle selection when set to custom. Disabled by default.
- **Webforms** — the same, applied to selected webforms. Disabled by default.

The checkbox is always **required** where it appears. It is automatically skipped
on the admin "add user" page (`/admin/people/create`) and for administrative
user‑management forms, so admins creating accounts aren't blocked by it. The
contact/node/webform options only show if those modules are enabled.

## GDPR Pop‑up Settings — the cookie banner

At **Configuration → GDPR → GDPR Pop‑up Settings**
(`/admin/config/gdpr/compliance/popup`). This controls the cookie‑consent banner,
which appears on non‑admin pages (it's hidden on `/admin/*`).

- **Show to guests** / **Show to authenticated users** — who sees the banner.
  Both on by default.
- **Position** — **top** or **bottom** of the page (bottom by default).
- **More information link** — where the "More information" button goes; defaults
  to the bundled policy page.
- **Cookie text (line 1)** and **Analytics text (line 2)** — the banner wording.
  Leave blank to use the built‑in defaults. (Line 1 is capped at 255
  characters.)
- **Agree button label** and **More information button label** — the button
  texts (blank uses sensible defaults such as "I've read it").
- **Enable custom colors** — turn on to set your own colors, then choose a
  **Pop‑up background color** and **Button color** as hex values. The contrasting
  text color (black or white) is worked out automatically for readability, so you
  don't set it directly.

Once a visitor accepts or dismisses the banner, a cookie remembers the choice and
the banner won't reappear.

## The bundled policy page

The module serves a ready‑made policy at **`/gdpr-compliance/policy`** (viewable
by anyone with "access content"). It ships with English, Russian, and German
versions and shows the one matching the visitor's interface language (falling
back to English). The page also displays a last‑changed date derived from the
source file.

To make it your own, you have three options: edit the bundled policy HTML file
directly, implement the `hook_gdpr_compliance_policy_alter` hook to change the
content or the values (like the contact email) shown on it, or simply point the
banner's and checkbox's policy links at a policy node you maintain yourself. The
hook is documented in the sibling [`agent/`](../agent/start.md) docs.
