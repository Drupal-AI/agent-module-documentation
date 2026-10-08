# Permissions

One permission (`ckeditor_tooltips.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer ckeditor tooltips` | Access the global settings form (`ckeditor_tooltips.settings`, `/admin/config/content/ckeditor-tooltips`). Not marked `restrict access: true`, but it only controls global Tippy appearance/behaviour options. |

There is no separate permission to *use* the tooltip button — that is governed by normal text-format
access (whichever CKEditor 5 formats have the tooltip toolbar item and which roles may use those
formats).
