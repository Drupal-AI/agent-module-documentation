# Configuration

File Mime Validator enforces a mapping of file extension to acceptable MIME
type(s). The module ships with a set of default mappings, and you can add to them
so the check stays current as you accept new file types.

## Where the settings form lives

The configuration form is at **Configuration → System → File Mime Validator**
(`/admin/config/system/file-mime-validator/file-types-mime-config`). There you
review the default MIME types and add your own extension-to-MIME mappings.

## Important: the settings form is currently unreachable for most users

The configuration route is gated with a permission named `administer` — but
**Drupal core defines no such permission**, and the module ships no permissions of
its own that would grant it. Because `hasPermission('administer')` is false for
every account, the form can only be opened by **user 1**, which bypasses
permission checks entirely.

This is a defect in the module, not something you can fix by granting a permission
on the People → Permissions page. Two practical ways to work with it:

- **Configure as user 1** — log in as the superuser (user 1) and open the form
  normally.
- **Set the configuration with Drush** — edit the module's settings directly
  without the form, for example:

  ```bash
  drush cset file_mime_validator.settings …
  ```

  (Prefix with `ddev` on DDEV.) Adjust the specific keys to match the mapping you
  want.

Crucially, **the validation itself is unaffected** — uploads are still checked
against the configured mappings regardless of whether you can open the settings
screen. Only the ability to edit the mappings through the UI is impacted.

## How it fits with core

Treat File Mime Validator as **defence in depth behind** Drupal's extension
allow-list, not a substitute for it:

- Keep each file field's **allowed-extensions** list as narrow as possible — an
  accurate MIME check on a type you should never have accepted does not help you.
- Continue to store uploads on the private scheme where appropriate and ensure the
  server does not execute uploaded files.

Together, the narrow allow-list plus this content-vs-extension check close the gap
where a script or HTML payload is renamed to a permitted extension.
