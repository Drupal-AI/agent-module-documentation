# Configuration

Mail Box Management is configured on a single page where you tell it how to reach
your IMAP mailbox. The most important decisions here are about **security**,
because you are handing the site live credentials to a real email account.

## Keep the IMAP credentials out of version control

The IMAP **username** and **password** are secrets. Do not paste them anywhere
that gets committed, and do not hard‑code them. The recommended pattern on this
project is to keep the password in an environment variable and load it through
DDEV's dotenv support:

```bash
ddev dotenv set .ddev/.env --mailbox-imap-password=<your-password>
ddev restart
```

That makes `MAILBOX_IMAP_PASSWORD` available inside the web container (keep
`.ddev/.env` out of version control). Where the module or your `settings.php`
allows it, reference the environment variable rather than storing the plain
password in exported configuration.

## Always connect over an encrypted channel

Enable **SSL/TLS** for the connection. IMAP over an unencrypted connection sends
your credentials and mail contents in the clear; use the secure port your provider
specifies (commonly 993 for IMAP over SSL).

## Open the configuration form

Go to **Configuration → Mail Box Management**
(`/admin/mailbox-management/configuration`). Enter the IMAP server details:

- **Hostname** — your IMAP server address (for example `imap.example.com`).
- **Port** — the IMAP port (commonly **993** for SSL/TLS).
- **SSL/TLS** — enable encryption for the connection (strongly recommended).
- **Username** — the mailbox account username.
- **Password** — the mailbox account password (ideally supplied from an
  environment variable, as above).

Complete the setup on that page to establish the connection.

## After connecting

Once the mailbox is connected you can **fetch** emails (subject, sender, body, and
attachments), **display and organise** them, **process** them with your own
workflows (for example turning incoming mail into support tickets or content), and
**send** and **reply** to messages.

## Privacy reminder

Mailbox contents are private correspondence and may contain personal data. Make
sure only the intended users can see the mailbox — a user should generally only
see their own mailbox unless you have deliberately chosen to share it — and review
the module's permissions accordingly.
