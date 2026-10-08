# Configuration

All of Perimeter's behavior lives in one settings object (`perimeter.settings`),
edited from a single admin form. The module works out of the box with a built-in
pattern list, so everything here is about tailoring it to your site.

## Open the settings form

1. Log in as a user with the **Administer perimeter url patterns** or **Administer
   perimeter ip whitelist** permission (either grants access to the form; an
   administrator has both).
2. Go to **Configuration → System → Perimeter**, or navigate directly to
   `/admin/config/system/perimeter`.

## URL banning patterns

The **URL banning patterns** textarea holds one regular expression per line
(`not_found_exception_patterns`). When a request 404s, its path is tested against
each pattern; a match bans the client IP. Each pattern is a complete PCRE with its
own `/…/` delimiters.

On a fresh install the list ships with twelve common probe patterns:

```
/.*\.aspx/    /.*\.asp/    /.*\.jsp/    /\/blog_edit\.php/
/\/blogs\.php/    /\/wp-admin.*/    /\/wp-login.*/    /\/my_blogs/
/\/system\/.*\.php/    /.*systopice.*/    /.*login.json/    /\/episerver.*/
```

Add your own lines to catch other endpoints you never expose — for example
`/\/xmlrpc\.php/` to ban anything 404-ing on `xmlrpc.php`. Blank lines are
ignored, and each line is trimmed of surrounding whitespace.

Editing this textarea requires the **Administer perimeter url patterns**
permission.

## Whitelisted IPs

The **Whitelisted IPs** textarea (`whitelisted_ips`) lists IP addresses and CIDR
ranges that are *never* banned, one per line. It accepts single addresses and
ranges such as `192.168.1.0/24` or `10.0.0.0/8`. Whitelist your office, VPN, and
CDN addresses so a stray 404 from a trusted source can never lock you out.

Editing this textarea requires the **Administer perimeter ip whitelist**
permission.

## Flood threshold and window

By default a single matching 404 bans the IP immediately. To give offenders a
grace count instead, use the two flood settings:

- **Flood threshold** (`flood_threshold`, default `0`) — how many matching
  requests are allowed before a ban lands. `0` bans on the first match; `2` allows
  two and bans on the third.
- **Flood window** (`flood_window`, default `3600` seconds) — the time window over
  which the threshold is counted. After the window passes, the counter resets.

> **Important caching note:** the ban logic only fires on *uncached* 404
> exceptions. A 404 served from the page cache never reaches Perimeter, so
> repeated hits to the *same* missing URL can be served from cache and count as a
> single attempt. Flood counting is most meaningful against scanners that probe
> *different* URLs.

## Permissions

Perimeter defines three permissions:

| Permission | What it grants |
|------------|----------------|
| **Administer perimeter url patterns** | Edit the *URL banning patterns* textarea. |
| **Administer perimeter ip whitelist** | Edit the *Whitelisted IPs* textarea. |
| **Bypass perimeter defence rules** (restricted) | Requests from this user never trigger a ban. |

The settings form is reachable by anyone with either of the first two permissions.
Assign the bypass permission carefully — it is meant for trusted authenticated
users.

## Managing and removing bans

Perimeter only *adds* bans; you review and remove them on core Ban's page at
**Configuration → People → IP address bans** (`/admin/config/people/ban`). To
unban from the command line:

```bash
drush php:eval '\Drupal::service("ban.ip_manager")->unbanIp("203.0.113.45");'
```

## Editing settings from the command line

Every option is stored in `perimeter.settings`:

```bash
drush config:get perimeter.settings                     # the whole object
drush config:get perimeter.settings flood_threshold     # a single key
drush config:set perimeter.settings flood_threshold 3 -y
```

The pattern and whitelist lists are sequences, which are awkward to set one line at
a time on the CLI, so edit them from the form or with a small `drush php:eval`
script (see the [agent configuration doc](../../agent/configure/settings.md) for a
ready-made example). These settings export as normal config, so you can deploy your
patterns, whitelist, and thresholds across environments with
`drush config:export` / `drush config:import`.

## Honeypot integration

If the contrib **Honeypot** module is installed, Perimeter also bans the IP of
anyone whose form submission Honeypot rejects (with a couple of safe exceptions,
such as user 1 and login-form timing rejections). This uses the same flood
threshold and window. No configuration is needed beyond having both modules
enabled.
