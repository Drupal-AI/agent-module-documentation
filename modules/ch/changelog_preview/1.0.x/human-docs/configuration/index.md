# Configuration

Changelog Preview needs a little setup before anyone can read a changelog: you
tell it which Markdown file to render, where on disk to find it, and at what
browser path users should view it. You then grant a role permission to view.

## Open the settings form

1. Log in as an administrator (a user who can administer site configuration).
2. Go to `/admin/changelog_manage`.

## Register a changelog

The form lets you add one or more changelogs. For each entry you provide:

- **The changelog file path** — the location of the Markdown (`.md`) file to
  render. This path is **relative to your Drupal root folder**. Point it at the
  `CHANGELOG.md` you want editors to see.
- **The browser path** — the URL path where users will later open this changelog
  to read it. This is the address you share with the people who should review the
  notes.

You can register several changelogs, each with its own file path and browser
path, so a site can present more than one set of release notes.

When rendered, the Markdown is converted to HTML and any code blocks in it are
highlighted in grey for readability.

## Grant the view permission

Registering a changelog is not enough on its own — a user also needs permission
to read it. Go to **People → Permissions** (`/admin/people/permissions`) and grant
the **view changelog** permission to the roles that should be able to open the
changelog pages.

> **Keep it to trusted roles.** The module reads files from disk based on the
> configured paths, so treat the view permission as a sensitive grant rather than
> something to hand to anonymous or untrusted users.

## Save

Save the form. Each registered changelog is now available at the browser path you
assigned, for any user who holds the view permission.
