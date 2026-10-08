# Configuration

## 1. Enter your Omnisend API key

1. In your [Omnisend](https://www.omnisend.com) account, create/obtain your **API
   key** (and public key).
2. In Drupal, go to **Configuration → Web services → Omnisend**
   (`/admin/config/services/omnisend`) — you need the **Administer site
   configuration** permission.
3. Enter the public key and API key, and save. The key is sent to Omnisend as an
   `X-API-KEY` / `Omnisend-API-Key` header on API calls.

## 2. Add the handler to a Webform

1. Edit the Webform whose submissions you want to send to Omnisend.
2. Under **Settings → Emails / Handlers**, add the **Omnisend** handler.
3. Map which webform fields become which Omnisend contact properties:
   - **Standard fields** (email, name, address, demographics) can be chosen from a
     select list.
   - **Custom fields** use a small YAML mapping syntax:

     ```yaml
     field[omnisend_field_id,0]: '[webform_field_machine_name]'
     ```

     For example, a custom field by ID: `field[345,0]: '[webform_field_machine_name]'`,
     or a personalization tag: `field[%PERS_1%,0]: '[webform_field_machine_name]'`.
4. Save. New submissions are now synced to Omnisend in real time, creating or
   subscribing the contact — which can also trigger Omnisend automations such as a
   welcome flow.

## 3. Review lists and campaigns

The admin dashboard at `/admin/omnisend/campaigns` shows your Omnisend campaigns (and
the API can fetch your lists). Note the permission caveat below — until the
`access omnisend dashboard` permission is provided, these pages are reachable only by
user 1.

## Transport and egress

API calls use Guzzle with **TLS verification enabled** and hard‑coded Omnisend
endpoints (`api.omnisend.com` / `a.omnisend.com`) — there's no way for a request to be
redirected elsewhere, and certificate checking is on. Be aware that enabling the
integration sends submitter data (email, name, address, and any fields you map) to
Omnisend, so confirm that egress and the data it carries meet your site's privacy and
consent requirements before syncing.
