# Configuration

The one thing this module needs to know is **where your Gotenberg service lives** —
its endpoint URL. That is set on the module's settings form, which requires the
**Administer Gotenberg settings** (`administer gotenberg settings`) permission and
is reachable from the **Configure** link next to the module on `/admin/modules`.

## Run a Gotenberg service

Gotenberg is a separate service (typically a Docker container) that you run
yourself. Follow the
[Gotenberg documentation](https://gotenberg.dev/docs/getting-started/introduction)
to stand one up. In most setups it runs on your own network, not on the public
internet.

## Set the endpoint

On the settings form, enter the URL of your Gotenberg instance (for example, an
internal address like `http://gotenberg:3000`). Save the form. The wrapper class
and the Entity Print plugin will send conversion requests to that endpoint.

## Security: point only at a trusted instance

This is the part to get right. Gotenberg runs a **headless browser** and renders
whatever HTML you send it, and the module sends its requests to the URL you
configure here. Two consequences:

- **Use only a Gotenberg instance you control and trust**, ideally on your own
  private network, and keep that endpoint access-restricted so it is not reachable
  by anyone else. Because the endpoint is a configurable URL that the server calls,
  treat changing it as a sensitive action — an attacker who could change it could
  redirect your document traffic.
- Be mindful that **the HTML you submit is rendered by that service**. Send it only
  content you are comfortable having the Gotenberg instance process.

## A note on data flow

Every PDF conversion sends the source HTML/URL from Drupal to the configured
Gotenberg endpoint (outbound), and the rendered PDF comes back. Keep that traffic
on a trusted network.
