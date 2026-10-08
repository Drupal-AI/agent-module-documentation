# Configuration

Commerce MRW is configured as a **shipping method**. You create one shipping
method that uses the MRW plugin, enter your SAGEC credentials, choose a service and
set a rate. There is no separate global settings page.

## Your SAGEC credentials

MRW gives you a username and password for the PRE (test) and PRO (production)
environments, alongside your franchise code, client code and optional department
code. You enter these directly on the MRW shipping method's form: the PRE and PRO
credentials are kept as separate fields, and the **test mode** toggle decides which
set is used. The two password fields are masked; leave a password blank when
editing the method to keep the value already saved.

Treat these credentials as secrets. Limit who holds the *administer commerce
shipment* permission (the only role that can view or edit the shipping method), and
handle the method's exported configuration the way you handle any other config that
contains credentials.

## Create the MRW shipping method

1. Log in as a user who can administer Commerce shipping.
2. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
3. Choose the **MRW** plugin.

## Fields on the MRW shipping method

- **SAGEC credentials** — your franchise code, client code, optional department
  code, and the username/password pair. The form keeps the **PRE (test)** and
  **PRO (production)** credentials separate.
- **Test mode (PRE)** — a toggle that decides which environment requests go to.
  Keep this **enabled** until MRW has validated your integration, then switch it
  off to go live against PRO.
- **Service code** — the SAGEC service to ship with (for example *Ecommerce*,
  *Urgente 19* for Portugal, or any other code from the SAGEC catalogue).
- **Rate** — the flat shipping amount charged to the customer for this method.
- **Public tracking URL pattern** — the pattern used to build the customer-facing
  tracking link shown on the shipment.

## Save and test

Save the shipping method. Place a test order that uses it, then open the resulting
shipment in the back office:

- Use **Transmit to MRW** (*TransmEnvio*) to send the shipment to MRW; the returned
  MRW shipment number is stored as the tracking code.
- **MRW label** / **Download the MRW label (PDF)** streams the transport label PDF
  from SAGEC on demand.
- **Cancel MRW shipment** withdraws a transmitted shipment and clears the tracking
  code.

Status tracking is available too, but as a programmatic service rather than a
button: the module ships a tracking client (`commerce_mrw.tracking_client`) that
queries MRW's TrackingServices for the latest status or the full history. Wiring it
into a workflow (for example a cron job that marks delivered shipments) is left to
your site's code.

You can also transmit shipments whose shipping method is *not* MRW: eligible
methods get a "Transmit as" selector, and the method that actually executed is
recorded on the shipment.

## A note on data sent to MRW

Transmitting a shipment sends the consignee's details (name, address, phone, and
optionally NIF, cash-on-delivery and insurance data) to MRW's SAGEC service over
its web API. This is the personal data MRW needs to deliver the parcel — make sure
your privacy notices cover sharing it with the carrier. If you need to adjust what
is sent, subscribe to the module's event that fires before the TransmEnvio request
leaves your site.
