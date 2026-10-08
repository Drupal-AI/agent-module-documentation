# Configuration

Amplitude configuration has two parts: the **global settings** (your API key and
SDK options) and the **events** you want to track.

## Open the settings form

1. Log in as a user with the **Administer Amplitude settings** permission.
2. Go to **Configuration → System → Amplitude**, or navigate directly to
   `/admin/config/system/amplitude`.

## Global settings

- **API key** — your Amplitude project key. This is Amplitude's public,
  client-side key: it is meant to be sent to the browser, so it is not treated as
  a secret.
- **Debug** — turn on Amplitude SDK debug logging while you are setting things up.
- **Config options** — extra initialization options passed straight through to
  the Amplitude SDK.
- **User properties** — a token-enabled field. It is token-replaced using the
  current route's entities, cleaned of tags, then sent to Amplitude as user
  properties. This is how you attach information like the current user or content
  values to every event.

## Events

Beyond the global settings, you build individual tracking **events**, managed
through a list linked from the settings form (with add, edit, and delete forms).
Each event lets you set:

- **Which pages it applies to** — a set of paths (request-path visibility
  conditions), so an event can be limited to, say, campaign landing pages or a
  content type's URL pattern.
- **The trigger** — what makes it fire, such as page load or a click.
- **A CSS selector** — for click triggers, the element to watch.
- **Data capture** — optional data attributes to read off a clicked element.
- **Properties** — token-enabled event properties built from the current route
  entity.

On each request, the module works out which events match the current path and
passes them to the Amplitude SDK, which fires them in the browser.

## Save

Save the settings form after entering your API key, and save each event as you
create it. Multiple events can fire on the same page, so you can combine, for
example, a page-load event with a click-conversion event.
