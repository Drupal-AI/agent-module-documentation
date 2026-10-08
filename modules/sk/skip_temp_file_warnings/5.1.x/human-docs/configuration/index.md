# Configuration

Skip Temp File Warnings does not add a settings page of its own. It adds one
setting to Drupal's core logging page, where you tell it which file-URI scheme(s)
to clean up.

## Open the logging settings

1. Log in as a user who can administer site configuration (an administrator).
2. Go to **Configuration → Development → Logging and errors**, or navigate
   directly to `/admin/config/development/logging`.

## Enter the file-URI scheme string

Find the field this module adds and enter the **string that appears in the file
URI** from the warning message. The scheme is the part before `://`.

For example, in this log line:

> Could not delete temporary file "**public**://sample.jpg" during garbage
> collection

the string to enter is `public`.

### Handling several schemes at once

If you see the warning for more than one scheme, list them separated by commas.
For example, given these two messages:

> Could not delete temporary file "**public**://sample.jpg" during garbage
> collection
>
> Could not delete temporary file "**youtube**://sample.mo4" during garbage
> collection

you would enter:

```
public,youtube
```

## Save

Save the logging settings form. From then on, cron will clean up the stale
temporary-file entries for the scheme(s) you listed, and the repeating warning
should stop.

> **Remember:** this removes temporary-file records for the schemes you name. Only
> add a scheme whose temporary files you are confident are safe to clear — core's
> default retention exists so that files still in use mid-workflow are not deleted
> too early.
