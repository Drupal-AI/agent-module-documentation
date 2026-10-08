# Configuration

All settings live on one form at **Configuration → System → Google Analytics
Cookieless** (`/admin/config/system/google-analytics-cookieless`).

## A note about accessing the form

Before you can reach the form, be aware of a permission quirk. The settings route
requires the **Administer Google Analytics** permission — which is defined by the
*classic* Google Analytics module, not by this one (this module's own permission is
named *Administer Google Analytics Cookieless*). The practical effect:

- If the classic **Google Analytics** module is installed, grant its *Administer
  Google Analytics* permission to reach the form.
- If it is **not** installed, that permission does not exist, so the form is
  reachable only by **user 1** (the superuser). This locks the form down rather
  than opening it up — but it can be confusing. Install/align the permission you
  intend to use.

## Settings, field by field

- **Account (UA property ID)** — your Universal Analytics ID in the form
  `UA-XXXXXXX-Y`. The module validates this against the pattern `^UA-\d+-\d+$` and
  emits **no** tracking snippet at all unless it matches. This is the one required
  field.
- **JS file address** — the URL of the tracking JavaScript the bundled library
  loads. Leave the default unless you are pointing at a custom or self-hosted
  endpoint.
- **Anonymise IP** — when enabled, visitor IP addresses are anonymised before being
  sent to Google. This is on by default and is the privacy-friendly choice.
- **Track logged-in users** — when turned off, authenticated users are not tracked;
  only anonymous visitors are counted. Turn it off if you don't want editor/admin
  activity in your statistics.

## Page visibility

You control which pages are tracked with a mode plus a list of paths (this reuses
the classic Google Analytics module's familiar path-visibility logic):

- **Track all pages except those listed** — the default: track everywhere, but skip
  the paths you list.
- **Track only the listed pages** — the opposite: track *only* the paths you list.
- **Never track (by path)** — suppress tracking for the path rule entirely.

Enter the paths, one per line, in the accompanying text area. A common setup is to
exclude admin paths so back-end activity is not counted.

## How tracking is decided

On each page, the module emits the snippet **only if** all of the following are
true: the account ID passes the `UA-…` format check, the current path passes your
visibility rules, and — if you turned off *track logged-in users* — the visitor is
anonymous. If any check fails, no tracking is added to that page.

## Save

Click **Save configuration**. Load a front-end page and confirm the tracking is
present and that the `_ga` cookie is *not* set.

## Privacy and consent

Even without the GA cookie, this still sends page-view data (and a
fingerprint-derived identifier) to Google — that is **third-party egress** of
visitor data. Keep IP anonymisation on, disclose the tracking in your privacy
policy, and confirm this approach meets the consent rules that apply to your
audience before relying on it.
