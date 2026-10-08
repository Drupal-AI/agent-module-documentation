# Configuration

Webform Navigation has no global settings page. You enable it **per webform**, and
it takes **two** things on each form: the third‑party settings *and* the
submission handler. If you do only one, forward navigation will not work.

## Before you start: make it a wizard with a progress bar

Webform Navigation only makes sense on a multi‑page (wizard) form. On the webform:

1. Split the form into wizard pages (add **Wizard page** elements).
2. Open the form's **Settings → Form** tab and enable **Show wizard progress
   bar** (or the progress tracker). This is the control Webform Navigation makes
   clickable.

## 1. Turn on the third‑party settings

1. Go to **Structure → Webforms**, open your form, and click **Settings**.
2. Find the **Third‑party settings** section and open **Webform navigation
   settings**.
3. Configure:
   - **Forward navigation** — the master switch. When ticked, every non‑final
     wizard page becomes clickable/accessible, per‑page error logging is turned
     on, and the module automatically adjusts a few form settings so navigation
     works reliably: it forces **drafts on** (draft = all), sets an auto‑purge
     mode with a **365‑day** window for stale drafts, and enables the clickable
     wizard progress link. Leave this off and the feature is inactive.
   - **Prevent next validation** — shown once Forward navigation is on. Ticking it
     relaxes validation on the **Next** button so a visitor can move to the next
     page without immediately clearing every error. The **final submit still
     validates every page**, so nothing invalid slips through.
   - **Additional error message** — optional free text appended to the error
     summary shown on final submit. Use it to add guidance like "Please review the
     highlighted pages before submitting."
4. Save the settings.

## 2. Add the Webform Navigation handler (required)

1. On the same webform, go to the **Emails / Handlers** tab.
2. Click **Add handler** and choose **Webform Navigation**.
3. Save it.

Without this handler, forward navigation does nothing — and the third‑party
settings form shows a warning reminding you to add it. The handler has just one
option of its own, a development **Debug** checkbox: when enabled it prints each
handler method it runs on‑screen to *all* users, so use it only while debugging on
a non‑production site.

## What visitors get

Once both pieces are in place, on the front end of the wizard form:

- Every step in the progress bar is clickable, so visitors can jump forwards and
  backwards between pages without losing their entries.
- When a visitor returns to a page, any validation errors it had are shown again.
- On final submit, all pages are re‑validated and every outstanding error is
  listed together, grouped under its page's label (plus your optional additional
  message).
- Progress steps are colored by state — active, has errors, complete — via the
  module's CSS.

Repeat these two steps on each wizard webform where you want this behavior.
