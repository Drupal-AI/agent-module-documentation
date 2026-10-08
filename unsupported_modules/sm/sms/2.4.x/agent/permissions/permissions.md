# SMS Framework — permissions & dynamic routes

## Permissions (`sms.permissions.yml`)

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer smsframework` | yes | The whole admin hub: settings, gateways, phone-number settings (all `sms.*` admin routes). |
| `sms verify phone number` | no | The `/verify` phone-number verification form (`VerifyPhoneNumberForm`). |

Submodules add their own: `Send SMS Blast` (sms_blast), `sms_devel form` (sms_devel),
`send to any number` (sms_sendtophone).

## Static routes (`sms.routing.yml`)

All admin routes under `/admin/config/smsframework/*` require `administer smsframework`. The
`/verify` route is added dynamically (see below), not in the static file.

## Dynamic routes (`RouteSubscriber::routes()`)

Generated from config, not present in `sms.routing.yml`:

1. **`sms.phone.verify`** — path from `sms.settings:page.verify` (default `/verify`), form
   `VerifyPhoneNumberForm`, permission `sms verify phone number`.
2. **Delivery-report receive** (`sms.delivery_report.receive.<gateway>`) — one per gateway whose
   plugin `supportsReportsPush()` and which has a `reports_push_path` (must start with `/`).
   Controller `DeliveryReportController::processDeliveryReport`. Guarded by the
   `_sms_gateway_supports_pushed_reports` access check (`SupportsPushedReportsAccessCheck`),
   which only confirms the gateway supports push — it is **not** authentication.
3. **Incoming receive** (`sms.incoming.receive.<gateway>`) — one per gateway whose plugin
   `autoCreateIncomingRoute()` and which has an `incoming_push_path`. Controller
   `SmsIncomingController::processIncoming`, `POST` only, **`_access: TRUE` (public)**.

## Trust boundary for gateway callbacks (document, not a module bug)

The incoming route is intentionally public and the delivery-report access check is not an
authenticator — SMS providers call these webhooks server-to-server. SMS Framework delegates
authentication to the gateway plugin: `processIncoming()` / `parseDeliveryReports()` must verify
the provider's signature or shared secret before trusting the request, otherwise inbound
messages and delivery reports can be forged. Out of the box the only installed gateway (`log`)
creates no incoming/report routes, so a default install exposes no such endpoint. When enabling
a real gateway, confirm it validates its callbacks (and that `sms_user` account-registration /
reply features, if enabled, are only driven by authenticated inbound messages).
