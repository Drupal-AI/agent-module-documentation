# Configuration

Dblog JSON Viewer works out of the box — everything here is **optional tuning**.
If you never open this form, the viewer still renders JSON automatically on your
log detail pages.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Database Log JSON Viewer**, or navigate
   directly to `/admin/config/development/dblog-json-viewer`.

## Settings

The form exposes advanced customisation for how the viewer behaves. The most
notable option is the **search debounce delay** — how long (in milliseconds, 500ms
by default) the viewer waits after you stop typing before it runs the search. A
higher value reduces work while you type on very large JSON payloads; a lower value
makes the search feel more immediate. Adjust the available options to suit your
debugging preferences.

## Save

Click **Save configuration**. Your changes apply the next time you open a log entry
in the viewer.

> **Tip:** Reserve access to this form for trusted administrators. It is gated by
> the *Administer site configuration* permission, which is a broad permission — only
> highly trusted roles should hold it.
