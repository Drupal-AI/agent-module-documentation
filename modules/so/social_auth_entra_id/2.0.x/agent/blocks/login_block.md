# Entra ID Login Block

Plugin `EntraIdLoginBlockBlock` (`src/Plugin/Block/EntraIdLoginBlockBlock.php`, `final`, extends
`BlockBase`).

```
@Block(
  id = "entra_id_login_block",
  admin_label = @Translation("Entra ID Login Block"),
  category = @Translation("Login"),
)
```

Renders a single `#type => link` to route `social_auth_entra_id.redirect`
(`/user/login/entra-id`) — clicking it starts the OAuth flow. Cache context `user`. Attaches the
`social_auth_entra_id/font-awesome` library (Font Awesome from a CDN) so icon markup renders.

## Block settings (`blockForm`)

| Setting | Default | Purpose |
|---|---|---|
| `login_text` | `<i class="fa-brands fa-microsoft"></i> Log in with Microsoft Entra ID` | Link label; rendered as `#markup` with `#allowed_tags => ['i','strong','em','b','u','span','img']`. |
| `custom_class` | `btn btn-primary` | CSS class(es) applied to the link. |

`blockValidate` rejects a `custom_class` that does not match `^[a-zA-Z0-9\s_-]+$`; `blockSubmit`
additionally strips any character outside `[a-zA-Z0-9\s_-]` from the saved value. `login_text` is
stored as-is (output-filtered by the allowed-tags list above).

Place it at `/admin/structure/block` (region of choice, typically visible to anonymous users), or
skip the block entirely and just link to `/user/login/entra-id`.
