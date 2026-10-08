# Configuration

All of Shield's behavior is set on a single settings form. The important thing to
remember is that **the shield is off until you switch it on** and set
credentials — enabling the module alone does nothing.

## Open the settings form

1. Log in as a user with the **Administer shield** permission (an administrator by
   default).
2. Go to **Configuration → System → Shield**, or navigate directly to
   `/admin/config/system/shield`.

## Turn the shield on

- **Enable Shield** — the master on/off switch. Tick it to start prompting for
  credentials. *(Off by default.)*

## Credentials

- **Credential provider** — where the username and password come from:
  - **Shield (plain config)** — stored directly in configuration. Simple, but the
    password ends up in exported config.
  - **Key** — the username is stored in config and the **password** comes from a
    [Key](https://www.drupal.org/project/key) entity.
  - **Multikey** — a single Key entity holds **both** the username and password.

  The Key‑based providers keep secrets out of exported configuration and require
  the Key module.
- **User** and **Password** — the shared Basic Auth credentials when using the
  plain provider. (With the Key providers you instead point at the Key entity
  that holds them.)
- **Greeting** — the text shown in the browser's Basic Auth dialog (default
  `Hello!`). You can include `[user]` and `[pass]` tokens if you want to display
  the credentials in the prompt itself — handy on a demo site.

## Exceptions — who and what may skip the shield

These let you poke controlled holes in the wall:

- **Allow CLI** — let command‑line access (Drush) run without prompting. *(On by
  default, so your deploy and cron keep working.)*
- **IP allowlist** — a newline‑separated list of IP addresses or CIDR ranges that
  bypass the shield entirely. Use this for your office, VPN, or a monitoring
  service.
- **Domains** — host/domain patterns that are publicly accessible. Use this to
  expose a public front‑office domain while a back‑office domain on the same site
  stays protected.
- **HTTP method allowlist** — HTTP methods that bypass the shield, for example
  `options` so CORS preflight requests succeed while everything else is gated.
- **Path mode** and **Paths** — path matching, in one of two modes:
  - **Exclude** *(default)* — the listed paths **bypass** the shield; everything
    else is protected. Good for leaving a webhook or health‑check endpoint open.
  - **Include** — **only** the listed paths are protected; everything else is
    open. Good for shielding just a not‑yet‑launched section.

  Enter one path pattern per line.

## Diagnostics

- **Debug header** — when on, Shield adds an `X-Shield-Status` response header
  explaining its decision (disabled, skipped for CLI/path/IP/domain/HTTP method,
  authenticated, or pending). Turn it on if you're puzzled about why the prompt is
  or isn't appearing, then turn it off again.

## Compatibility with Drupal's own Basic Auth

- **Unset Basic Auth headers** — strips the incoming Basic Auth headers before
  Drupal processes the request, so core's own `basic_auth` module doesn't conflict
  with the shield's credentials. *(On by default; leave it on unless you have a
  specific reason not to.)*

## Save

Click **Save configuration**. Reload the site in a fresh browser session (or a
private window) and you should get the Basic Auth prompt — supply the credentials
to get through. If you set up an IP allowlist that includes your address, you'll
skip the prompt from that network.

## Upgrading from Drupal 7

Shield ships a migration (`shield_settings`) that imports your Drupal 7 Shield
settings during a site upgrade, so you don't have to re‑enter them by hand.
