# Configuration

REST Log works as soon as it is enabled, but you should visit its settings form
before leaving it on — mainly to keep the **Maximum lifetime** short, because the log
stores request payloads and response bodies without redaction.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Logging and errors → REST Log settings**, or
   navigate directly to `/admin/config/development/logging/rest_log`.

## Maximum lifetime

This sets how long a log entry is kept before REST Log's automatic cleanup deletes
it. The default is **30 days**. Because the entries can contain credentials and
personal data (see the warning below), a **shorter lifetime is safer** — set it to
the shortest window that still covers the investigation you are running. Automatic
cleanup runs on cron, so make sure cron is running for the setting to take effect.

## Same-host referrer filter

REST Log can **include or exclude** requests whose HTTP `referer` header points at
your own site (a same-host referrer). Excluding them is useful when you only care
about calls coming from an external client or decoupled front end and want to filter
out requests triggered from within your own site's pages; include them when you want
a complete record. Choose whichever gives you the cleaner picture for what you are
debugging.

## Save

Click **Save configuration**. The new lifetime and filter apply going forward.

## A note on what gets stored

Keep these facts in mind whenever REST Log is enabled — they are properties of how
the module records data, not settings you can turn off from this form:

- The header mask is a **denylist** (`auth`, `pass`, `token`, `cookie` in the
  header name), so headers like **`x-api-key`, `x-secret`, `x-signature` and
  `x-client-secret` are logged in clear**.
- Masked secrets keep their **first three characters**, which reveals a credential's
  vendor prefix.
- **Request payloads and response bodies are stored unredacted** — a login POST
  stores the password; a user GET stores personal data. Treat the `rest_log` table
  as a personal-data store and exclude it from shared database dumps.
- **Cache-served responses are never logged**, so the log is not a complete audit
  trail.

The practical takeaways: keep the lifetime short, restrict who can view the report
(via the module's access handler / permissions), and turn the module off once your
investigation is finished.
