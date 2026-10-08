# Configuration

HTML Title has one real setting — the list of allowed tags — plus two ways to
extend where the marked-up rendering applies. The module works with its default
tags the moment you enable it; this page is about adjusting that.

## Open the settings form

1. Log in as a user with the **Administer HTML title settings** permission. This is
   a restricted permission the module adds; grant it only to trusted roles, since
   it controls which HTML tags are allowed in titles.
2. Go to **Configuration → User interface → Html title**, or navigate directly to
   `/admin/config/user-interface/html_title`.

## Allow html tags

The form has a single field, **Allow html tags**: a space-separated list of the
HTML start-tags permitted in titles. The shipped default is:

```
<br> <sub> <sup>
```

Only the tags you list here survive when a title is displayed — any other tag is
stripped out by the module's security filter, which is what keeps titles safe from
cross-site scripting. To also allow italics and bold, for example, you might set:

```
<em> <sup> <sub> <strong>
```

The tags are meant to be **inline** ones. The supported set is `em`, `sub`, `sup`,
`b`, `i`, `strong`, `cite`, `code`, `bdi`, and `wbr`. You *can* type other tags,
but block-level or interactive tags defeat the purpose and may be stripped anyway.
The field accepts up to 64 characters.

Click **Save configuration** when done. The change takes effect immediately, and
because titles are filtered only at display time, your stored title values are
never altered.

You can also read or set this from the command line:

```bash
drush config:get html_title.settings allow_html_tags
drush config:set html_title.settings allow_html_tags '<em> <sup> <sub>' -y
```

## Render markup on other fields — the "HTML-title text" formatter

HTML Title adds a field formatter called **HTML-title text** for plain-text
(*string*) fields. To use it, go to the relevant entity's **Manage display**
screen, find your string field, and choose **HTML-title text** as its format. That
field's value will then render through the same allowed-tags filter — handy for a
subtitle or a custom heading field, not just the node title.

## Marked-up titles in Views

You don't need to configure anything for Views. HTML Title automatically upgrades
the node **Title** field so that any view showing it — in a table, grid, or list —
renders the allowed markup. Existing and new views pick this up on their own, and
the field's "Link to content" option keeps working. Uninstalling the module leaves
those views intact.

## A note on RSS

Titles in RSS feeds are deliberately stripped of tags so feeds stay valid, even
though the same titles show their markup on the site.
