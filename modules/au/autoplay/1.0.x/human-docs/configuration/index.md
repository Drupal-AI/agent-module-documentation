# Configuration

Setting up AutoPlay has two parts: entering your dealership defaults on the module's
settings form, then attaching the AutoPlay handler to each Webform whose submissions
should become leads.

## Set the dealership defaults

1. Log in as a user with the **Administer autoplay settings**
   (`administer autoplay settings`) permission. Grant this only to trusted
   administrators (for example, marketing admins) — it controls where lead data is
   sent.
2. Go to **Configuration → System → AutoPlay**, or navigate directly to
   `/admin/config/system/autoplay`.
3. Set the default **DealershipId** and the **endpoint** to use. AutoPlay provides
   two WSDL endpoints:
   - **Sandbox** (for testing):
     `https://lead-api.aptest.co.nz/LeadAPI.svc?singleWsdl`
   - **Production** (for go‑live):
     `https://lead-api.autoplay.co.nz/V2/LeadAPI.svc?singleWsdl`
4. Save. Keep the **production HTTPS WSDL** configured for live traffic so lead data
   (which contains customer PII) is transmitted over TLS.

## Add the handler to a Webform

1. Edit the Webform that should send leads (for example a contact or test‑drive
   request form).
2. Go to **Settings → Emails / Handlers → Add handler → AutoPlay**.
3. In the handler, confirm or set the **WSDL / endpoint** (use the production WSDL
   for live forms) and **map the form elements to AutoPlay lead fields** — connect
   each relevant Webform element to the corresponding lead attribute.
4. Save the handler.

## How delivery works

- When a submission is saved, the handler builds an AutoPlay lead from the mapped
  values and calls the SOAP Lead API operation at the configured endpoint.
- A **queue worker** is available so lead delivery can be deferred and processed in
  the background (on cron) instead of during the visitor's request; this also lets
  failed deliveries be retried via the queue.
- You can localise the lead source per form and restrict who may edit the endpoint
  configuration via the settings permission above.

## Before go‑live

- Test against the **sandbox** WSDL first and confirm leads arrive in AutoPlay.
- Verify the **production** WSDL is reachable from your server.
- Switch the endpoint to **production** only when you're ready to send real leads,
  and confirm it uses **HTTPS** so PII is protected in transit.
