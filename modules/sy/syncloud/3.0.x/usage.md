Syncloud captures Drupal site events (Commerce orders, webform submissions, contact-form messages) as `syn` tracking entities, queues them, and publishes each event as a JSON message to an external MQTT broker for downstream Telegram/analytics delivery.

---

Syncloud (project machine name `syncloud`, package "Synapse") defines a single content entity type, `syn`, plus a site-wide settings form at `admin/structure/syn`. Whenever a Commerce order is placed, a webform submission is completed, or a contact message is submitted, a hook or event subscriber creates a `syn` record (capturing the client IP, host, request URL, page mode, and Matomo/Google/Yandex tracking-cookie values) and pushes a `{id, syn_id}` job onto the `syncloud_queue` Drupal queue. Queue items are drained by `Queue::queueProcess()` — triggered both by an internal self-request to `/syncloud/queue` and available on demand — which reloads the source entity, builds a structured message (billing profile fields, order items, prices, shipping, payment gateway for Commerce; decoded element values for webforms; non-skipped fields for contact messages), and, when the "Telegram integration" flag is on, publishes it via the `syncloud.mqtt` service to the MQTT topic `$telega/syncloud/<uuid>/event/contact-message`. A separate weekly cron task publishes a site-usage stat message to `stat/<uuid>/state/usage`. The module also injects a Matomo-style JavaScript tracking snippet into page `<head>` (via `hook_page_attachments`) and can append a Matomo profile link to outgoing mail (`hook_mail_alter`). MQTT connection details (server, port, login, password) and behavior flags live in the `syncloud.settings` config object, edited through the settings form. NOTE: release 3.0.6 has two functional defects on current Drupal 11.x. First, the `syn` entity's `message` base field references `contact_message`, an entity type with no ID key in current core, which raises a `FieldException` when `syn` field definitions are built — in practice every web page (front end and admin) returns HTTP 500 while the module is enabled, though CLI/`drush` (including cron) still runs. Second, the `syncloud.queue` service type-hints a `QueueFactoryInterface` argument that Drupal 11 injects as `QueueFactory`, raising a `TypeError` that independently breaks the enqueue-and-publish path and the `/syncloud/queue` route. The weekly cron usage publish (which calls `syncloud.mqtt` directly) is the only integration path unaffected by these two defects.

---

- Track completed Commerce orders and forward order details to an external MQTT/Telegram bridge.
- Capture webform submissions and publish their decoded field values to a messaging backend.
- Capture contact-form messages and relay their fields to an external channel.
- Record the client IP, host, scheme, and request URL for each captured site event.
- Persist Matomo (`_pk_id`), Google (`_ga`), and Yandex (`_ym_uid`) tracking-cookie identifiers alongside each event.
- Maintain a browsable list of `syn` tracking records at `admin/content/syn`.
- Manually create, edit, view, and delete `syn` records through the admin UI.
- Configure the MQTT broker server, port, login, and password from a single settings form.
- Toggle the whole tracking integration on or off site-wide with the "Enable SynCloud" flag.
- Enable or suppress the tracking snippet on admin pages, for the uid=1 super-admin, or for all authenticated users.
- Inject a Matomo-style page-view tracking script into the HTML head of front-end pages.
- Point the tracking snippet at a custom Matomo host instead of the default endpoint.
- Set a Matomo/analytics Site ID used by the injected tracking script.
- Gate MQTT publishing behind the "Telegram integration" flag so events queue but do not publish until enabled.
- Publish a weekly site-usage stat message (Drupal/PHP/module versions, site UUID) to the broker via cron.
- Append a "view full visit history" Matomo profile link to outgoing mail when a Matomo cookie is present.
- Surface a status-report requirement warning when the configured MQTT login/password are still the public defaults.
- Extend the outbound message for Commerce/webform/contact events via the `hook_syncloud_queue_preprocess_*` alter hooks.
- Restrict who may view, create, edit, delete, or administer `syn` records using dedicated permissions.
- Store per-site identity (`syncloud.uuid`, `syncloud.secret`) in state for addressing MQTT topics.
- Use it as a lightweight bridge between Drupal e-commerce/form activity and an MQTT-based notification pipeline.
