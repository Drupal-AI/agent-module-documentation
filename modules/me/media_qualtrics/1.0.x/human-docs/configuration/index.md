# Configuration

Media Qualtrics has a single settings form: the **allowed hosts** list. It controls
which URLs the "Remote Media - Qualtrics" formatter will actually render — and, when
the CSP module is enabled, which hosts are added to the `frame-src` directive so the
embeds can load.

## Open the settings form

1. Log in as a user with the **Administer qualtrics allowed hosts** permission.
2. Go to **Configuration → Media → Qualtrics settings**, or navigate directly to
   `/admin/config/media/qualtrics`.

## Allowed Hosts

The form is a single **Allowed Hosts** textarea. Enter **one host per line**. Each
entry must be a bare `https://` domain — a scheme (which must be `https`) and a host,
with **no path**. For example:

```
https://qualtrics.com
https://survey.example.com
```

- The default shipped value is `https://qualtrics.com`.
- The form validates each line: it rejects `http://…` addresses, and rejects any
  entry that includes a path (offering you the corrected bare-domain form instead).
- Subdomains of an allowed host match automatically, so listing
  `https://qualtrics.com` also covers `https://yourbrand.qualtrics.com`.
- If you ever leave the list empty, the formatter quietly falls back to the built-in
  default `https://qualtrics.com`, so embeds from the standard Qualtrics domain keep
  working.

Click **Save configuration** when done.

## What the list does

- **Rendering:** a field value is only turned into an iframe if its URL matches one
  of the allowed hosts. Any non-matching value is silently skipped (the survey simply
  doesn't appear), which prevents editors from embedding arbitrary external pages.
- **Content Security Policy:** if the **CSP** module is installed, the module adds
  every allowed host to the `frame-src` directive on non-admin routes automatically,
  so a strict CSP won't block the Qualtrics iframe.

## Setting it from the command line

The values live in the `media_qualtrics.settings` config object under `allowed_hosts`:

```bash
# read the current list
drush cget media_qualtrics.settings allowed_hosts

# set entries (each is one element of the sequence)
drush cset media_qualtrics.settings allowed_hosts.0 'https://qualtrics.com' -y
drush cset media_qualtrics.settings allowed_hosts.1 'https://survey.example.com' -y
```
