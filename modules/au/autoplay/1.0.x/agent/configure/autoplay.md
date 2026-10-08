<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring AutoPlay

1. Enable `webform` and `autoplay`.
2. Go to `/admin/config/system/autoplay` (permission `administer autoplay settings`) and set the default DealershipId.
3. Edit a Webform → **Settings → Emails/Handlers → Add handler → AutoPlay**.
4. In the handler, set the **WSDL** (production `https://lead-api.autoplay.co.nz/V2/LeadAPI.svc?singleWsdl`) and map form elements to lead fields.
5. On submission, `AutoplayHandler::postSave()` builds the lead and calls the SOAP `LeadAPI` operation; the queue worker can defer sending.

Notes: the endpoint is a SOAP/WSDL service invoked with `new \SoapClient($wsdl, ['trace' => 1])`; ensure the HTTPS production WSDL is set so lead PII is transmitted over TLS.
