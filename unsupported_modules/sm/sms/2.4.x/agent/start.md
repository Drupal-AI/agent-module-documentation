# SMS Framework (`sms`) — agent index

Extensible API between Drupal and SMS gateways: `sms_gateway` plugins + config entities, an
SMS message send/queue pipeline with events, per-entity phone-number fields with verification,
and incoming-message / delivery-report routes. Depends on core `telephone`, `system`, and
`dynamic_entity_reference`. Config hub route `sms.admin` (`/admin/config/smsframework`).
Composer project is `smsframework`; **module machine name is `sms`**.

- **Global settings, gateway config entities, phone-number settings, the `/verify` page** →
  [configure/gateways-and-settings.md](configure/gateways-and-settings.md)
- **Implement an `sms_gateway` plugin (annotation, base class, incoming, reports)** →
  [plugins/sms-gateway.md](plugins/sms-gateway.md)
- **Send/queue API, phone-number provider, verification service** →
  [api/sending.md](api/sending.md)
- **Events (`SmsEvents`) and `hook_sms_gateway_info_alter`** →
  [hooks/events.md](hooks/events.md)
- **Permissions & the dynamic incoming/report routes** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs):
- `sms_blast` → [../../modules/sms_blast/2.4.x/agent/start.md](../../modules/sms_blast/2.4.x/agent/start.md)
- `sms_devel` → [../../modules/sms_devel/2.4.x/agent/start.md](../../modules/sms_devel/2.4.x/agent/start.md)
- `sms_sendtophone` → [../../modules/sms_sendtophone/2.4.x/agent/start.md](../../modules/sms_sendtophone/2.4.x/agent/start.md)
- `sms_user` → [../../modules/sms_user/2.4.x/agent/start.md](../../modules/sms_user/2.4.x/agent/start.md)

Key facts:
- Plugin type `sms_gateway`: annotation `Drupal\sms\Annotation\SmsGateway`, manager service
  `plugin.manager.sms_gateway`, base `SmsGatewayPluginBase`. Bundled plugin: `log` (installed +
  fallback by default).
- Services: `sms.provider` (send/queue/delivery reports), `sms.phone_number`,
  `sms.phone_number.verification`, `sms.queue`.
- Config: `sms.settings` (fallback_gateway, page.verify=`/verify`, flood.verify_*); `sms_gateway`
  and `phone_number_settings` config entities; `sms` message + `sms_phone_number_verification`
  content entities. Uses `dynamic_entity_reference` so verifications target any entity type.
- Incoming/report endpoints are added dynamically per gateway by `RouteSubscriber` (not in
  `sms.routing.yml`). The incoming route is `_access: TRUE` (public) — gateways must validate
  their own callbacks; see permissions doc.
