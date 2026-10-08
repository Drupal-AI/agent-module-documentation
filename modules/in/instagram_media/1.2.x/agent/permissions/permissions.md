# Permissions

Defined in `instagram_media.permissions.yml`:

| Permission | Title | Description |
|---|---|---|
| `administer instagram media block` | Administer Instagram Media Blocks | Perform administration tasks related to Instagram Media Blocks. |

Note: this permission is declared but is not referenced anywhere in the module's code. In practice:
- **Editing** an Instagram Media block (the settings form that holds the token/app secret) is gated by core's block-administration access (`administer blocks` / block layout access), not by this permission.
- **Viewing** the rendered feed is gated by the block plugin's own `blockAccess()`, which requires the core `access content` permission (granted to anonymous by default). No token or credential is present in the rendered output — only downloaded media, captions, counts, and profile links.
