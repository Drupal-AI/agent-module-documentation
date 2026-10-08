# Configuration

syncloud is configured in two parts: the **settings form** for the MQTT
connection, and the **`syn` entity mappings** that decide which site events get
forwarded. Both live under **`admin/structure/syn`** and require the `administer
syn` permission.

## The settings form — MQTT and Telegram

Open **`admin/structure/syn`** and fill in the broker connection:

- **Server** — the hostname/address of your MQTT broker.
- **Port** — the broker's port.
- **Login** — the username syncloud connects with.
- **Password** — the password for that account.
- **Telegram integration** (`telegram-int`) — the master on/off toggle. When this
  is switched **off**, the queue processor skips publishing entirely, so nothing
  is sent to the broker. Turn it on once your connection details are correct and
  you are ready to forward events.

These values are what the module's MQTT client uses to connect and publish.
Because they include broker credentials, keep the resulting configuration out of
anywhere untrusted (for example, be careful about committing exported config that
contains them).

## The `syn` event mappings

A **`syn` entity** is what tells syncloud "when *this* kind of thing happens, send
*that*." Each one maps a local entity type/bundle — for example a Commerce order
type, a webform, or contact messages — to remote routing details: a remote id
(`syn_id`), plus fields such as `ip`, `host`, `mode`, `url`, and an `extra` area
that can hold analytics ids (Yandex/Google). You create and edit these through the
`syn` list/add/edit forms reached from the settings area.

Once a mapping exists, the flow is automatic: when a matching event fires (a
contact message or webform submission is inserted, or a Commerce order completes),
syncloud queues the entity, and the queue processor builds the message and
publishes it as JSON to the MQTT topic for that mapping. Order messages include
line items, prices and quantities, billing-profile customer fields, and shipping
and payment details; webform and contact messages include their submitted values.

Cron also triggers queue processing, so with cron running your queued events are
delivered without any manual step.

## Developer payload hooks

If you need to adjust what goes out, other modules can alter the payloads before
they are published:

- `hook_syncloud_queue_preprocess_commerce(&$entity, $syn_id)` — for Commerce
  order messages.
- `hook_syncloud_queue_preprocess_webform(&$entity, $syn_id)` — for webform
  submissions.
- `hook_syncloud_queue_preprocess_contactform(&$entity, $syn_id)` — for contact
  messages.

## Important: lock down the queue route

The route **`/syncloud/queue`** is open to anonymous users. It does not read any
request input or return queue data — it only triggers queue processing — but it
deliberately waits five seconds and then processes the queue for up to about 30
seconds. That means an anonymous client can call it over and over to force
processing and hold a worker for roughly 5–35 seconds each time, which is an
availability/denial-of-service risk. Before you put the site into production,
**restrict this route** at your web server or proxy layer, or arrange for queue
processing to be driven by cron only rather than by that self-called endpoint.

Also worth knowing: keep the `administer syn` permission granted only to a trusted
back-office role, since it controls the broker credentials and event mappings.
