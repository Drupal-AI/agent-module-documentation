# Configuration

Radar is set up in a few steps after installation: place the radar button, tune its
appearance, set up the dialog form fields, provide the Screenshot API key, and then
review the reports that come in.

## 1. Place and enable the radar button

Go to **Structure → Block layout** (`/admin/structure/block`) and place the **radar**
button block in a region that is visible across your site (or the pages where you
want feedback). Once placed, the button appears for visitors and opens the feedback
dialog when clicked.

## 2. Customise the button and dialog

- **Button appearance and placement** — adjust how the radar button looks and where
  it sits on the page, so it is noticeable without getting in the way.
- **Dialog form fields** — set up the fields the dialog collects, so each report
  captures the information your team needs (for example a description, and any extra
  context you want to prompt for). The screenshot is captured automatically and
  attached to the report.

## 3. Provide the Screenshot API key

The automatic screenshot relies on the Screenshot API, which needs an API key. Treat
that key as a secret:

- Do not hard‑code it or commit it to version control. Store it in an environment
  variable instead. On DDEV, the built‑in dotenv helper keeps it out of the repo:

  ```bash
  ddev dotenv set .ddev/.env --screenshot-api-key='your-key'
  ddev restart
  ```

  (`.ddev/.env` must stay out of version control.)
- Where possible, reference the key through a **Key** entity backed by that
  environment variable rather than pasting the raw value into a configuration field.

Bear in mind that capturing a screenshot sends page data to the Screenshot API
service, so confirm that this outbound data flow is acceptable for your site.

## 4. Review reported issues

Incoming reports — description plus attached screenshot — are stored in Radar's log,
which you review from the admin area to triage and act on the feedback.
