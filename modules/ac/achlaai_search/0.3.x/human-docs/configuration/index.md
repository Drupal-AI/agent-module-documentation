# Configuration

Setup is a short connect-then-place flow. There is no API key to paste — the
connection is established by proving your site owns its domain.

## Open the settings page

1. Log in as a user who holds the **Manage the Achla AI Search connector**
   permission (grant it deliberately — see
   [Installation](../installation/index.md)).
2. Go to **Configuration → Web services → Achla AI Search**
   (`/admin/config/services/achlaai-search`).

## 1. Connect with Ownership v2

From the settings page, start an **Ownership v2** attempt. Your site initiates the
attempt, and the Achla service completes it by sending a server-to-server request
back to your site's callback endpoint (`/achla-ai/ownership/callback`). That
callback is public on purpose — it is authenticated cryptographically (a signature
check plus a PKCE-style confirmation) and rate-limited, not left open — so you do
not paste or store any secret. If the attempt stalls, it can recover by polling
without ever exposing the verifier to the browser.

Once ownership is confirmed, the connector authority is stored locally and the
widget is allowed to appear. Until then, the module fails closed and shows nothing.

## 2. Place the search widget

Configure where the search-and-answer widget appears by giving a **CSS selector**
for the element it should mount on. The settings page includes a
placement-validation action (protected by a CSRF token) so you can check that your
selector matches an element before you rely on it. Only the signed, backend-approved
widget release is placed — the module will not inject arbitrary JavaScript.

## 3. Check the status

The status page at `/admin/config/services/achlaai-search/status` shows the
connector's lifecycle state. Review it after connecting, after an upgrade, or
whenever Achla reports a lifecycle change on their side. If a change disabled a
previous connector, reconnect from the settings page.

## Disconnecting

You can disconnect the site from Achla from the settings page when you no longer
want the integration; the widget then stops being served.
