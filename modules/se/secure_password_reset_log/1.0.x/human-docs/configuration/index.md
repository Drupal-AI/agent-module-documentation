# Configuration

## Open the settings form

1. Log in as a user with the **administer secure password reset logs** permission.
2. Go to **Configuration → Security → Secure Password Reset Log**, or navigate directly
   to **`/admin/config/security/password-reset-flood`**.

## The settings

The form groups the module's behaviour into a few areas, as described in its
documentation:

- **Logging preferences** — control what data is stored about each reset request and
  how long it is retained. Because the logs capture account and IP details, store only
  what you need and keep the retention period sensible.
- **Flood-control limits** — set the number of reset attempts allowed within a given
  time window before the source is throttled or blocked. This is what stops
  brute-force and automated reset abuse.
- **Blocking rules and security thresholds** — define the conditions (by IP or by user
  account) under which repeated or suspicious attempts are blocked, and for how long.

Tune the thresholds to match your traffic: too tight and legitimate users who mistype
their address may get blocked; too loose and abusive bursts slip through. Save the
form when you are done.

## Reviewing the logs

Reset events are recorded and can be reviewed either through the module's own
administrative interface or via Drupal's standard log reports at
**`/admin/reports/dblog`**. Use them to spot repeated attempts from a single IP or
against a single account.

## Permissions

- **view secure password reset logs** — lets a role read the log data. This is
  security-sensitive information, so grant it only to trusted roles.
- **administer secure password reset logs** — lets a role change the settings on this
  page. Keep it to administrators.

## Optional: CrowdSec integration

From version 1.0.2, if you install and configure the **CrowdSec Drupal module**, this
module can emit CrowdSec signals for suspicious reset activity — repeated reset
attempts, unusual patterns, or apparent enumeration — to feed automated threat
detection and IP remediation. The integration is optional and adds no hard dependency;
simply installing CrowdSec enables it.
