# Configuration

Site24x7 RUM does nothing until you give it a RUM key, so this page is the important
one. All settings live on a single form.

## Open the settings form

1. Log in as a user with the **`administer site24x7`** permission (an administrator by
   default).
2. Go to **Configuration → System → Site24x7**, or navigate directly to
   `/admin/config/system/site24x7`.

If no key is set yet, the form prompts you to register a free Site24x7 account and add
a RUM Monitor for your site first.

## RUM key and datacentre

- **RUM key** — paste the app key from your Site24x7 RUM Monitor. The form validates
  its format (24–34 alphanumeric characters), so a mistyped or truncated key is caught
  on save. This key is appended to the beacon URL as its `appKey`.
- **Datacentre** — choose the Site24x7 datacentre your account is hosted in: **US, EU,
  IN (India), AU (Australia), or CN (China)**. The module derives the correct beacon
  host from your choice, so it must match where your account lives or the data will not
  reach it.

## Restrict which pages are monitored

You can limit monitoring by path, exactly like the Google Analytics module:

- **All pages except those listed** — monitor everywhere by default, then list the
  paths to exclude.
- **Only the listed pages** — monitor nothing by default, then list the paths to
  include.

Paths support **wildcards** (for example `blog/*`). Note that 403 (access denied) and
404 (not found) pages are always trackable regardless of these rules.

## Restrict which roles are monitored

You can also scope monitoring by user role — **include** selected roles or **exclude**
selected roles — so, for example, you can keep your own staff's sessions out of the
data. The include/exclude behavior mirrors Google Analytics' role filtering.

## Save

Click **Save configuration**. The beacon is attached to matching pages immediately
(the output is cached with config cache tags, so it updates when you change the
settings).

## Content-Security-Policy note

If the **CSP** module is installed, the settings form warns you to allow the Site24x7
datacentre host in your **`script-src-elem`** directive. Until you do, a strict CSP
will block the beacon script and no data will be collected.
