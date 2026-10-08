# TCPDF Example — permissions

One permission, defined in `tcpdf_example.permissions.yml`:

| Machine name | Title | Description |
|--------------|-------|-------------|
| `use tcpdf example` | Use TCPDF Examples | Generate the example pdfs that are provided by TCPDF Example module |

It gates **both** routes (`tcpdf_example.content` and `tcpdf_example.download_pdf`) via
`_permission: 'use tcpdf example'`. It is not flagged `restrict access` and is not an admin
permission, but it triggers server-side PDF generation, so grant it only to trusted roles.

Grant via drush:

```bash
drush role:perm:add authenticated 'use tcpdf example'
```
