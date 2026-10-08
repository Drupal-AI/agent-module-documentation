<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AutoPlay Auto Integration forwards Webform submissions to AutoPlay's automotive dealership lead-management platform.

---
The module provides a Webform handler (`AutoplayHandler`) that on `postSave` maps submitted values to an AutoPlay lead and sends it to the configured WSDL endpoint via a PHP `SoapClient` (default sandbox `https://lead-api.aptest.co.nz/LeadAPI.svc?singleWsdl`, production `https://lead-api.autoplay.co.nz/V2/LeadAPI.svc?singleWsdl`). A settings form at `/admin/config/system/autoplay` (permission `administer autoplay settings`) stores the default DealershipId and endpoint. A queue worker (`AutoplaySubmissionHandler`) supports deferred delivery.

Setup: enable Webform, add the AutoPlay handler to a form, set the WSDL/endpoint and DealershipId, then map form elements to lead fields. Delivery uses SOAP over the WSDL URL; keep the production HTTPS WSDL configured so lead data is sent over TLS.
---
- Add the AutoPlay handler to a Webform.
- Configure the WSDL endpoint at `/admin/config/system/autoplay`.
- Set the default DealershipId.
- Map webform fields to AutoPlay lead attributes.
- Push new enquiries to a dealership CRM.
- Use the sandbox WSDL for testing.
- Switch to the production WSDL for go-live.
- Queue submissions for background delivery.
- Grant `administer autoplay settings` to marketing admins.
- Capture test-drive request leads.
- Route contact form submissions to AutoPlay.
- Debug SOAP payloads via the handler trace option.
- Retry failed lead delivery via the queue worker.
- Restrict who can edit the endpoint configuration.
- Localise the lead source per form.
- Validate the WSDL is reachable before enabling.
