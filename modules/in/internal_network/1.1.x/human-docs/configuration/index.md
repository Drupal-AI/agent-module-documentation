# Configuration

Internal Network Condition is configured centrally, then applied per block, per
route, per term, or in Twig. Start with the global settings page.

## Open the settings page

1. Log in as an administrator.
2. Go to **Configuration → System → Internal Network**, or navigate directly to
   `/admin/config/system/internal-network`.

## Global settings

The central page defines the defaults every feature uses:

- **Internal IP ranges** — the CIDR ranges that count as "internal," one per line
  (for example `192.168.0.0/16` or `10.0.0.0/8`). This is the heart of the module.
- **Route restriction** — enable or disable it, list the routes to restrict, and
  choose the action for external visitors: **deny (403)** or **redirect to the
  homepage**. Menu links pointing to a restricted route are hidden automatically
  (via JavaScript, which keeps full‑page caching working).
- **Taxonomy term restriction** — configure the **bypass roles** and behaviour for
  content tagged with a restricted term.
- **Logging** — optionally log every access decision for debugging and auditing.
- **Test mode** — for development off the internal network, with a configurable
  **test header** so you can simulate an internal IP in non‑production. Because that
  header effectively lets you spoof your IP, only use test mode in non‑production
  environments.
- **Bypass roles** — roles that are exempt from the restrictions.

Save the settings.

## Using it in blocks, Twig, routes, and taxonomy

- **Block visibility** — edit any block's configuration and use the **Internal
  Network** visibility condition. You can rely on the global ranges or set a
  per‑block override.
- **Twig templates** — wrap content in the provided function:

  ```twig
  {% if is_internal_network() %}
    This content is only visible to internal users.
  {% endif %}
  ```

- **Routes** — add routes to the route‑restriction list on the settings page;
  external visitors get a 403 or a redirect, and matching menu links hide
  themselves.
- **Taxonomy terms** — tag a node or paragraph with a restricted term. Each term
  supports two modes: **hard deny (403)** or **soft hide** (JavaScript‑based and
  cache‑friendly), plus per‑term IP range overrides.

## Visibility is not access control

Keep the distinction clear when you decide which feature to use:

- **Soft hide / block visibility / menu hiding** control what is *shown*. They do
  not make the underlying content unreachable, so don't use them as the only
  protection for sensitive data.
- **Hard deny (403) routes and terms** are the enforcing options. For genuinely
  sensitive content, combine those with Drupal's own permissions and entity access.

And remember the earlier warning: all of this trusts the client IP, so behind a
proxy your `reverse_proxy` settings must be correct or the checks can be bypassed
by spoofing `X-Forwarded-For`.

## Verify it worked

From an IP inside your ranges, confirm the internal content appears; from an
outside IP (or with test mode off), confirm it is hidden or denied as configured.
If you enabled logging, check the log to see the access decisions being recorded.
