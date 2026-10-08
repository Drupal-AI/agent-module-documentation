# Configuration

EZ Likes works out of the box on Layout-Builder node pages, so everything here is
about **narrowing down where the button appears**, styling it, and opening up the
report to the right people.

## Open the settings form

1. Log in as a user with the **Administer EZ Likes** permission.
2. Go to **Configuration → Content → EZ Likes**, or navigate directly to
   `/admin/config/content/ez-likes`.

## The settings, field by field

- **Enabled content types** — tick the node types that should show the button.
  Leave everything unchecked to show it on **all** content types.
- **Included pages** — a list of path patterns (one per line, wildcards
  supported) that **force** the button onto specific pages, even if the
  content-type list wouldn't otherwise include them.
- **Excluded pages** — a list of path patterns (one per line, wildcards
  supported) that **always suppress** the button. This has the highest priority
  and overrides everything else.
- **Button color** — a hex colour for the button (default `#006bb6`). Dark, tint,
  and shadow variants are computed automatically at render time, so one value
  styles the whole button.
- **Show Share button** — toggle the clipboard-copy Share button on or off.

### How the visibility rules combine

When more than one rule could apply to a page, EZ Likes resolves them in this
priority order:

> **Excluded pages** beat **Included pages**, which beat the **content-type
> allowlist**.

So an excluded path never shows the button no matter what; an included path shows
it even if its content type isn't ticked; otherwise the content-type list decides.

Click **Save configuration** when you're done.

## Grant the report permission

The analytics report is gated by its own restricted permission. To let an editor
see it without giving them broader admin rights, go to **People → Permissions**
(`/admin/people/permissions`) and grant **Access EZ Likes report** to the
appropriate role. (The settings form above is separately gated by **Administer EZ
Likes**.)

## Read the report

Go to **Reports → EZ Likes Report** (`/admin/reports/ez-likes`). It lists every
node with at least one recorded interaction, with:

- **Sortable columns** and **filters** by content type and title.
- A **per-node detail view** so you can drill into who interacted with a given
  node.
- **CSV export** for pulling the data into a spreadsheet.

## Good to know

- **Anonymous de-duplication is by client IP** (plus session), so visitors sharing
  one public IP address — for example behind a corporate NAT — can be counted as
  the same person. Keep that in mind when reading anonymous counts.
- **Your data is preserved on uninstall.** Rather than dropping its tables, the
  module renames them to a backup and restores them automatically if you reinstall,
  so you won't lose historical counts by toggling the module off and on.
