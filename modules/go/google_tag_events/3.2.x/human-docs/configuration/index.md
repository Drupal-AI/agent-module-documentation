# Configuration

Google Tag Manager: Events does not carry its own API key — it rides on top of the
**Google Tag** module. To actually push events, you configure a GTM container in
Google Tag; to test without one, you turn on this module's debug mode.

## Configure at least one GTM container

Before events can be delivered, Google Tag needs at least one GTM container
configured. Set that up in the Google Tag module first (its containers live under
**Configuration → Services → Google Tag**). Without a configured container, pushed
events have nowhere to land — except in debug mode.

## The Events settings form

Go to **Configuration → Services → Google Tag → Events → Settings**
(`/admin/config/services/google-tag/events/settings`). Access requires Google Tag's
**Administer Google Tag Manager** permission (`administer google_tag_container`).

- **Debug mode** — enable this to test event pushing *without* any configured GTM
  container. Combined with a browser extension such as *Datalayer Checker* or
  *dataslayer*, it lets you confirm which events a page emits before you wire up a
  real container.

## Pushing events (for developers)

Events are pushed from PHP through the `google_tag_events` service, for example:

```php
google_tag_events_service()->setEvent('some_event_name', [
  'event' => 'some_event_name',
  'foo' => 'bar',
]);
```

which results in a `dataLayer.push({ 'event': 'some_event_name', 'foo': 'bar' })`
on the next rendered page. You can also encapsulate the data preparation in an
**event plugin** (a plugin whose ID matches the event name), keeping the
preparation logic out of your hooks.

## Privacy and data flow

Events are delivered to Google Tag Manager, which forwards data to Google and any
tags you have configured — so this feeds third-party analytics (outbound). More
importantly, event queueing for anonymous visitors sets a cookie *before* any
consent decision is recorded. Review this against your consent-management setup and
include it in your cookie audit before enabling it on a live site.
