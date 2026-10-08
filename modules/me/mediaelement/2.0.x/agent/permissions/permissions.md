# MediaElement permissions

One permission (`mediaelement.permissions.yml`):

| Permission | Gates |
|---|---|
| `administer mediaelement` | Access to the global settings form `mediaelement.config` (`/admin/config/media/mediaelement/config`) — library source, sitewide attach, default/override dimensions. |

Not marked `restrict access: true`, but it only controls the module's own admin config form. Field
formatter selection is governed by core's *administer display* permissions, not this one.
