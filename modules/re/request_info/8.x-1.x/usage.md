Request Info adds a block of current-request attributes to Drupal's status report so administrators can see exactly what request Drupal received behind a proxy, CDN or load balancer.

---

Reverse proxies, CDNs and load balancers rewrite requests before Drupal sees them, and the gap between what a visitor sent and what Drupal received is where a whole class of environment problems lives: wrong client IP in logs, wrong scheme causing mixed-content or redirect loops, wrong host breaking absolute URL generation, and trusted-proxy settings that do not match the real infrastructure. Answering "what does Drupal actually see?" usually means adding a debug statement or reading a log; this module instead lists the request's client IP, base URL, trusted-proxy and secure flags, scheme, headers, host, port, HTTP-auth user, protocol version and preferred language directly on `admin/reports/status`, where an administrator already looks when the environment is misbehaving. It is a tiny, dependency-free diagnostic: two hook implementations, no routes, permissions or configuration. Values are gated by the same permission that guards the status report itself, and the module masks the session cookie value and the HTTP-auth password before rendering; even so, the headers block is request detail, so sanitise a status-report screenshot before pasting it into a public issue queue.

---

- See what request Drupal actually received behind a proxy.
- Diagnose a wrong client IP appearing in logs.
- Debug a redirect loop caused by a wrong scheme.
- Check the HTTP host Drupal resolves behind a load balancer.
- Verify trusted reverse-proxy settings are taking effect.
- Confirm `isSecure()` reports HTTPS correctly behind TLS termination.
- Investigate mixed-content problems from a mis-detected scheme.
- Inspect the incoming request headers Drupal sees.
- Confirm a CDN's header rewriting reaches Drupal as expected.
- Confirm load-balancer forwarding configuration.
- Debug absolute-URL generation via the reported base URL.
- Check the reported HTTP port and protocol version.
- Verify the preferred-language negotiation input.
- See whether HTTP basic-auth credentials are being passed through.
- Put request detail where administrators already look for environment issues.
- Sanitise a status report before sharing it externally.
- Avoid pasting raw request headers into a public issue queue.
- Review request handling during a site or infrastructure audit.
- Re-verify proxy assumptions after a Drupal or hosting upgrade.
- Enable temporarily to troubleshoot, then leave in place as a passive check.
- Confirm which addresses count as a trusted proxy for this request.
