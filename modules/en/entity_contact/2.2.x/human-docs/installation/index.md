# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Text** module (`text`) — enabled automatically as a dependency.
- The **PhpSpreadsheet** library (`phpoffice/phpspreadsheet:^3.9`) — declared in the
  project's `composer.json` and pulled in automatically by Composer. It is used by the
  XLSX export submodule.

> **Note:** This project is not covered by Drupal's security advisory policy. Review
> it against your own site's requirements before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_contact -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_contact -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_contact -y
```

## Submodules — enable only what you need

Entity Contact ships several optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Contact Email** | `entity_contact_email` | Sends admin-configured e-mail on each submission (static recipients plus optional message-field recipient, and file-field attachments). |
| **Entity Contact Route** | `entity_contact_route` | Embeds a contact form on the `/contact-form/{form}` route. |
| **Entity Contact Export** | `entity_contact_export` | Exports submissions with pluggable layouts and formats (CSV). |
| **Entity Contact Export XLSX** | `entity_contact_export_xlsx` | Adds an XLSX export format (uses PhpSpreadsheet). |
| **Entity Contact Search API** | `entity_contact_search_api` | Indexes submissions in Search API. |
| **Example Submission Handler** | `entity_contact_example_submission_handler` | A coding starting point for writing your own submission handler. |

For example, to add e-mail sending:

```bash
drush en entity_contact_email -y
```

## Grant the permissions

Under **People → Permissions** (`/admin/people/permissions`):

- **access entity contact form** — lets a role submit the public contact form. This
  is a dedicated permission (not `access content`); grant it to the roles (including
  anonymous, if appropriate) that should be able to submit.
- **administer entity contact forms** — create and configure contact forms.
- **view entity contact form submissions** / **administer entity contact form
  submissions** — view and manage stored submissions.
- **administer entity contact form settings** — configure the flood limit/interval
  and the IP-storage toggle.
- **administer entity contact form emails** — configure the e-mail submodule (when
  enabled).
- **export entity contact messages** — run submission exports (when the export
  submodule is enabled).

## Verify it worked

Go to **Content → Entity contact** (`/admin/content/entity-contact`). You should be
able to add a contact form there. Next, see
[Configuration](../configuration/index.md) to build a form and expose it.
